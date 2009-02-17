#
#  $Id: och_analyzer3.rb 832 2005-09-08 15:39:45Z kimuraw $
#
#  Copyright (c) 2001 FUJIMOTO Hisakuni <hisa@imasy.or.jp>
#
#  This program is free software.
#  You can distribute/modify this program under the terms of
#  the GNU Lesser General Public License version 2.
#

CPP = '/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/arm-apple-darwin9-gcc-4.0.1'

CPPFLAGS = " -DTARGET_OS_MAC -DTARGET_CPU_PPC -isysroot /Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS2.0.sdk -E"

class OCHeaderAnalyzer

  attr_reader :path, :cpp_result, :framework

  def initialize(path)
    @path = path
    @cpp_result = OCHeaderAnalyzer.do_cpp(path)
    if ma = /\b(\w+)\.framework\b/.match(path) then
      @framework = ma[1]
    end
  end

  def filename
    File.basename(@path)
  end

  def enum_types
    if @enum_types.nil? then
      re = /\btypedef\s+enum\s*\w*\s*\{[^\}]*\}\s*(\w+)\s*;/m
      @enum_types = @cpp_result.scan(re).flatten
    end
    return @enum_types
  end

  def enums
    if @enums.nil? then
      re = /\benum\b.*\{([^}]*)\}/
      @enums = @cpp_result.scan(re).map {|m|
	m[0].split(',').map {|i|
	  i.split('=')[0].strip
	}.delete_if {|i| i == "" }
      }.flatten.uniq
      if filename == 'NSWindow.h' # window level support
	File.open(path) do |f|
	  re = /^#define\s+(NS\w+Level)\s+k[[:upper:]]\w+$/
	  @enums += f.read.scan(re)
	end 
      end
    end
    @enums
  end

  def externs
    if @externs.nil? then
      re = /^extern\s+\b(.*);.*$/
      @externs = @cpp_result.scan(re).map {|m| m[0].strip }
      re = /^extern\s__attribute__\(\(visibility\s\(\"default\"\)\)\)\s+\b(.*);.*$/
      @externs += @cpp_result.scan(re).map {|m| m[0].strip }
    end
    @externs
  end

  def constants
    if @constants.nil? then
      @constants = externs.map{ |i|
	constant?(i)
      }.compact
    end
    @constants
  end

  def functions
    if @functions.nil? then
      @functions = externs.map{ |i|
	function?(i)
      }.compact
    end
    @functions
  end

  def informal_protocols
    re = /^\s*(@interface\s+(\w+)\s*\(\s*(\w+)\s*\))\s*$([^@]*)^\s*@end\s*$/m
    re_type = /(-|\+)\s*\(\s*([^)]*)\s*\)/
    @cpp_result.scan(re).map! { |m|
      porig = m[0].strip
      pbase = m[1]
      pname = m[2]
      entries = m[3].strip.split(';').map{|i| i.strip }
      entries.map! {|i|
	i.strip!
	mm = re_type.match(i)
	return_type = mm ? mm[2].strip : 'id'
	selector = i.split(':').map do |ii|
	  mmm = /(\b\w+|\.{3})$/.match(ii.strip)
	  if mmm.nil?
	    p ii 
	    next
    end
	  mmm[0]
	end
	selector = if selector.size <= 1 then
		     selector[0]
		   else
		     selector[0...-1].join(':')
		   end
	InformalProtocolEntry.new(i, return_type, selector)
      }
      InformalProtocol.new(porig, pbase, pname, entries)
    }
  end

  private

  def constant?(str)
    str.strip!
    if str == '...' then
      VarInfo.new('...', '...', str, enum_types)
    else
      str += "dummy" if str[-1].chr == '*'
      re = /^([^()]*)\b(\w+)\b\s*(\[[^\]]*\])*$/
      m = re.match(str.strip)
      if m then
	m = m.to_a[1..-1].compact.map{|i|i.strip}
	m[0] += m[2] if m.size == 3
	m[0] = 'void' if m[1] == 'void'
	VarInfo.new(m[0],m[1],str, enum_types)
      end
    end
  end

  def function?(str)
    str.strip!
    re = /^(.*)\((.*)\)$/
    m = re.match(str.strip)
    if m then
      func = constant?(m[1])
      if func then
	args = m[2].split(',').map{|i|
	  ai = constant?(i)
	  ai = VarInfo.new('unknown', 'unknown', i, enum_types) if ai.nil?
	  ai
	}
	args = [] if args.size == 1 && args[0].rettype == 'void'
	FuncInfo.new(func, args, str, enum_types)
      end
    end
  end

  def OCHeaderAnalyzer.octype_of(str)
    case str.strip
    when 'id' then :_C_ID
    when 'Class' then :_C_ID
    when 'void' then :_C_VOID
    when 'SEL'  then :_C_SEL
    when 'BOOL' then :_PRIV_C_BOOL
    when 'NSRect' then :_PRIV_C_NSRECT
    when 'NSPoint' then :_PRIV_C_NSPOINT
    when 'NSSize' then :_PRIV_C_NSSIZE
    when 'NSRange' then :_PRIV_C_NSRANGE
    when 'NSWindowDepth' then :_C_INT
    when 'NSComparisonResult' then :_C_INT
    when /^unsigned\s+char$/ then :_C_UCHR
    when 'char' then '_C_CHR'
    when /^unsigned\s+short(\s+int)?$/ then :_C_USHT
    when /^short(\s+int)?$/ then :_C_SHT
    when /^unsigned\s+int$/ then :_C_UINT
    when /^unsigned$/ then :_C_UINT
    when 'int' then :_C_INT
    when /^unsigned\s+long(\s+int)?$/ then :_C_ULNG
    when /^long(\s+int)?$/ then :_C_LNG
    when 'float' then :_C_FLT
    when 'double' then :_C_DBL
    when /char\s*\*$/ then :_C_CHARPTR
    when /\*$/ then :_PRIV_C_PTR
    else :UNKNOWN
    end
  end

  def OCHeaderAnalyzer.do_cpp(path)
    f_on = false
    result = `#{CPP} #{CPPFLAGS} #{path}`.map {|s|
      s.sub( /\/\/.*$/, "" )
    }.select { |s|
      next if /^\s*$/ =~ s
      m = %r{^#\s*\d+\s+".*/(\w+\.h)"}.match(s)
      f_on = (m[1] == File.basename(path)) if m
      f_on
    }.join
    if $?.to_i != 0 then
      raise "#{CPP} returned #{$?.to_int/256} exit status"
    end
    return result
  end

  class VarInfo

    attr_reader :rettype, :name, :orig
    attr_accessor :octype

    def initialize(type, name, orig, enum_types)
      @rettype = type
      @name = name
      @orig = orig
      @rettype.gsub!( /\[[^\]]*\]/, '*' )
      t = type.gsub(/\b(__)?const\b/,'').strip
      t.gsub!( /<[^>]*>/, '' )
      t.gsub!( /\bconst\b/, '' )
      t.strip!
      t = "int" if enum_types.include?(t)
      @octype = OCHeaderAnalyzer.octype_of(t)
    end

    def to_s
      @orig
    end

  end

  class FuncInfo < VarInfo

    attr_reader :args, :argc

    def initialize(func, args, orig, enum_types)
      super(func.rettype, func.name, orig, enum_types)
      @args = args
      @argc = @args.size
      if @args[-1] && @args[-1].rettype == '...' then
	@argc = -1
	@args.pop
      end
      self
    end

    def to_s
      @orig
    end

  end

  class InformalProtocolEntry
    attr_reader :orig, :rettype, :selector
    def initialize(orig, rettype, selector)
      @rettype = rettype
      @selector = selector
      @orig = orig
    end
    def to_s
      @orig
    end
  end

  class InformalProtocol
    attr_reader :orig, :base, :name, :entries
    def initialize(orig, base, name, entries)
      @orig = orig
      @base = base
      @name = name
      @entries = entries
    end
    def to_s
      @title
    end
  end

end

if __FILE__ == $0 then
  if ARGV.size == 1 then
    ar = OCHeaderAnalyzer.new(ARGV[0])
    puts "#{ar.filename}"
    puts "enums      total: #{ar.enums.size}"
    puts "enum_types total: #{ar.enum_types.size}"
    puts "constants  total: #{ar.constants.size}"
    puts "functions  total: #{ar.functions.size}"
  else
    est = etst = cst = fst = 0
    ARGV.each do |path|
      ar = OCHeaderAnalyzer.new(path)
      es, ets, cs, fs = ar.enums.size, ar.enum_types.size, ar.constants.size, ar.functions.size
      printf "%s enums=%d enum_types=%d constants=%d funcs=%d\n",
	ar.filename.ljust(30), es, ets, cs, fs
      est, stst, cst, fst = est + es, etst + ets, cst + cs, fst + fs
    end
    puts "enums      total: #{est}"
    puts "enum_types total: #{etst}"
    puts "constants  total: #{cst}"
    puts "functions  total: #{fst}"
  end
end
