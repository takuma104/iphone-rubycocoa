#!/usr/bin/env ruby
# Copyright (c) 2006-2007, Apple Inc. All rights reserved.
# Copyright (c) 2005-2006 FUJIMOTO Hisakuni
# 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1.  Redistributions of source code must retain the above copyright
#     notice, this list of conditions and the following disclaimer.
# 2.  Redistributions in binary form must reproduce the above copyright
#     notice, this list of conditions and the following disclaimer in the
#     documentation and/or other materials provided with the distribution.
# 3.  Neither the name of Apple Inc. ("Apple") nor the names of
#     its contributors may be used to endorse or promote products derived
#     from this software without specific prior written permission.
# 
# THIS SOFTWARE IS PROVIDED BY APPLE AND ITS CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL APPLE OR ITS CONTRIBUTORS BE LIABLE FOR
# ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
# OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
# STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
# IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.

require 'rexml/document'
require 'fileutils'
require 'optparse'
require 'tmpdir'

=begin
module Kernel
  alias :_original_system :system
  def system(cmd)
#    p caller
#    puts cmd
    _original_system(cmd)
#    true
  end
end

class File
  def self.unlink(path)
  end
end
=end

class OCHeaderAnalyzer
  CPP = '/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/arm-apple-darwin9-gcc-4.0.1'
  CPPFLAGS = " -isysroot /Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS2.0.sdk -E"

  def self.data(data)
    new(data)
  end

  def self.path(path, fails_on_error=true, do_64=false, flags='')
    complete, filtered = OCHeaderAnalyzer.do_cpp(path, fails_on_error, do_64, flags)
    new(filtered, complete, path)
  end

  def initialize(data, complete_data=nil, path=nil)
    @externname = 'extern'
    @cpp_result = data
    @complete_cpp_result = complete_data
    @path = path
  end

  # Get the list of C enumerations, as a Hash object (keys are the enumeration 
  # names and values are their values.
  def enums
    if @enums.nil?
      re = /\benum\b\s*(\w+\s+)?\{([^}]*)\}/
      @enums = {}
      @cpp_result.scan(re).each do |m|
        m[1].split(',').map do |i|
          name, val = i.split('=', 2).map { |x| x.strip }
          @enums[name] = val unless name.empty? or name[0] == ?#
        end
      end
    end
    @enums
  end

  def file_content
    if @file_content.nil?
      @file_content = File.read(@path)
      # This is very naive, and won't work with embedded comments, but it
      # should be enough for now. 
      @file_content.gsub!(/\/\*([^*]+)\*\//, '')
      @file_content.gsub!(/\/\/.+$/, '')
    end
    @file_content
  end

  # Get the list of `#define KEY VAL' macros, as an Hash object.
  def defines
    if @defines.nil?
      re = /#define\s+([^\s]+)\s+(\([^)]+\)|[^\s]+)\s*$/
      @defines = {}
      file_content.scan(re).each do |m|
        next unless !m[0].include?('(') and m[1] != '\\'
        @defines[m[0]] = m[1]
      end 
    end
    @defines
  end

  # Get the list of C structure names, as an Array.
  def struct_names
    re = /typedef\s+struct\s*\w*\s*((\w+)|\{([^{}]*(\{[^}]+\})?)*\}\s*([^\s]+))\s*(__attribute__\(.+\))?\s*;/ # Ouch... 
    @struct_names ||= @cpp_result.scan(re).map { |m| 
      a = m.compact
      a.pop if /^__attribute__/.match(a.last)
      a.last
    }.flatten
  end

  # Get the list of CoreFoundation types, as an Array.
  def cftype_names
    re = /typedef\s+(const\s+)?struct\s*\w+\s*\*\s*([^\s]+Ref)\s*;/
    @cftype_names ||= @cpp_result.scan(re).map { |m| m.compact[-1] }.flatten
  end

  # Get the list of function pointer types, as an Hash object (keys are the 
  # type names and values are their C declaration.
  def function_pointer_types
    unless @func_ptr_types
      @func_ptr_types = {}
      re = /typedef\s+([\w\s]+)\s*\(\s*\*\s*(\w+)\s*\)\s*\(([^)]*)\)\s*;/
      data = @cpp_result.scan(re)
      re = /typedef\s+([\w\s]+)\s*\(([^)]+)\)\s*;/
      data |= @cpp_result.scan(re).map do |m|
        ary = m[0].split(/(\w+)$/)
        ary[1] << ' *'
        ary << m[1]
        ary
      end
      data.each do |m|
        name = m[1]
        args = m[2].split(',').map do |x| 
          if x.include?(' ')
            ptr = x.sub!(/\[\]\s*$/, '')
            x = x.sub(/\w+\s*$/, '').strip
            ptr ? x + '*' : x
          else
            x.strip
          end
        end 
        type = "#{m[0]}(*)(#{args.join(', ')})"
        @func_ptr_types[name] = type
      end
    end
    @func_ptr_types
  end

  def typedefs
    if @typedefs.nil?
      re = /^\s*typedef\s+(.+)\s+(\w+)\s*;$/
      @typedefs = {}
      data = (@complete_cpp_result or @cpp_result)
      data.scan(re).each { |m| @typedefs[m[1]] = m[0] }
    end
    @typedefs
  end

  def externs
    re = /^\s*#{@externname}\s+\b(.*)\s*;.*$/
    @externs ||= @cpp_result.scan(re).map { |m| m[0].strip }
  end

  def constants
    @constants ||= externs.map { |i| constant?(i, true) }.flatten.compact
  end

  def functions(inline=false)
    if inline
      return @inline_functions if @inline_functions
      inline_func_re = /(inline|__inline__)\s+((__attribute__\(\([^)]*\)\)\s+)?([\w\s\*<>]+)\s*\(([^)]*)\)\s*)\{/
      res = @cpp_result.scan(inline_func_re)
      res.each { |x| x.delete_at(0); x.delete_at(1) }
    else
      return @functions if @functions
      skip_inline_re = /(static)?\s(inline|__inline__)[^{;]+(;|\{([^{}]*(\{[^}]+\})?)*\})\s*/
      func_re = /(^([\w\s\*<>]+)\s*\(([^)]*)\)\s*)(__attribute__[^;]+)?;/
      res = @cpp_result.gsub(skip_inline_re, '').scan(func_re)
    end
    funcs = res.map do |m|
      orig, base, args = m
      base.sub!(/^.*extern\s+/, '')
      func = constant?(base)
      if func
        args = args.strip.split(',').map { |i| constant?(i) }
        next if args.any? { |x| x.nil? }
        args = [] if args.size == 1 and args[0].rettype == 'void'
        FuncInfo.new(func, args, orig, inline)
      end
    end.compact
    if inline
      @inline_functions = funcs
    else
      @functions = funcs
    end
    funcs
  end

  def informal_protocols
    self.ocmethods # to generate @inf_protocols
    @inf_protocols
  end

  def ocmethods
    if @ocmethods.nil?
      @inf_protocols ||= {}
      interface_re = /@(interface|protocol)\s+(\w+)\s*(\([^)]+\))?/
      end_re = /^@end/
      body_re = /^[-+]\s*(\([^)]+\))?\s*([^:\s;]+)/
      args_re = /\w+\s*:/
      prop_re = /@property\s*(\([^)]+\))?\s*([^;]+);$/
      current_interface = current_category = nil
      @ocmethods = {}
      i = 0
      @cpp_result.each_line do |line|
        size = line.size
        line.strip!
        if md = interface_re.match(line)
          current_interface = md[1] == 'protocol' ? 'NSObject' : md[2]
          current_category = md[3].delete('()').strip if md[3]
        elsif end_re.match(line)
          current_interface = current_category = nil
        elsif current_interface and md = prop_re.match(line)
          # Parsing Objective-C 2.0 properties.
          if (a = md[2].split(/\s/)).length >= 2 \
          and /^\w+$/.match(name = a[-1]) \
          and (type = a[0..-2].join(' ')).index(',').nil?
            getter, setter = name, "set#{name[0].chr.upcase + name[1..-1]}"
            readonly = false
            if attributes = md[1]
              if md = /getter\s*=\s*(\w+)/.match(attributes)
                getter = md[1]
              end
              if md = /setter\s*=\s*(\w+)/.match(attributes)
                setter = md[1]
              end
              readonly = true if attributes.index('readonly')
            end
            typeinfo = VarInfo.new(type, '', '')
            methods = (@ocmethods[current_interface] ||= [])
            methods << MethodInfo.new(typeinfo, getter, false, [], line) 
            unless readonly
              methods << MethodInfo.new(VarInfo.new('void', '', ''), setter + ':', false, [typeinfo], line)
            end
          end
        elsif current_interface and (line[0] == ?+ or line[0] == ?-)
          mtype = line[0]
          data = @cpp_result[i..-1]
          body_md = body_re.match(data)
          next if body_md.nil?
          rettype = body_md[1] ? body_md[1].delete('()') : 'id'
          retval = VarInfo.new(rettype, '', '')
          args = []
          selector = ''
          data = data[0..data.index(';')]
          args_data = []
          data.scan(args_re) { |x| args_data << [$`, x, $'] }
          variadic = false
          args_data.each_with_index do |ary, n|
            before, argname, argtype = ary
            arg_nameless = (n > 0 and /\)\s*$/.match(before))
            argname = ':' if arg_nameless
            realargname = nil
            if n < args_data.length - 1
              argtype.sub!(args_data[n + 1][2], '')
              if arg_nameless
                argtype.sub!(/(\w+\s*)?\w+\s*:\s*$/, '')
              else
                unless argtype.sub!(/(\w+)\s+\w+:\s*$/) { |s| realargname = $1; '' }
                  # maybe the next argument is nameless
                  argtype.sub!(/\w+\s*:\s*$/, '')
                end
              end
           else
              argtype.sub!(/\s+__attribute__\(\(.+\)\)/, '')
              if arg_nameless
                argtype.sub!(/\w+\s*;$/, '')
              else
                unless argtype.sub!(/(\w+)\s*;$/) { |s| realargname = $1; '' }
                  variadic = argtype.sub!(/,\s*\.\.\.\s*;/, '') != nil
                  argtype.sub!(/\w+\s*$/, '') if variadic
                end
              end
            end
            selector << argname
            realargname ||= argname.sub(/:/, '')
            args << VarInfo.new(argtype, realargname, '') unless argtype.empty?
          end
          selector = body_md[2] if selector.empty?
          args << VarInfo.new('...', 'vararg', '') if variadic
          method = MethodInfo.new(retval, selector, line[0] == ?+, args, data)
          if current_category and current_interface == 'NSObject'
            (@inf_protocols[current_category] ||= []) << method
          end
          (@ocmethods[current_interface] ||= []) << method
        end
        i += size
      end
    end
    return @ocmethods
  end

  #######
  private
  #######

  def constant?(str, multi=false)
    str.strip!
    return nil if str.empty?
    if str == '...'
      VarInfo.new('...', '...', str)
    else
      str << " dummy" if str[-1].chr == '*' or str.index(/\s/).nil?
      tokens = multi ? str.split(',') : [str]
      part = tokens.first
      re = /^([^()]*)\b(\w+)\b\s*(\[[^\]]*\])*$/
      m = re.match(part)
      if m
        return nil if m[1].split(/\s+/).any? { |x| ['end', 'typedef'].include?(x) }
        m = m.to_a[1..-1].compact.map { |i| i.strip }
        m[0] += m[2] if m.size == 3
        m[0] = 'void' if m[1] == 'void'
        var = begin
          VarInfo.new(m[0], m[1], part)
        rescue
          return nil
        end
        if tokens.size > 1
          [var, *tokens[1..-1].map { |x| constant?(m[0] + x.strip.sub(/^\*+/, '')) }]
        else
          var
        end
      end
    end
  end

  def self.do_cpp(path, fails_on_error=true, do_64=false, flags='')
    f_on = false
    err_file = '/tmp/.cpp.err'
    cpp_line = "#{CPP} #{CPPFLAGS} #{flags} #{do_64 ? '-D__LP64__' : ''} \"#{path}\" 2>#{err_file}"
    complete_result = `#{cpp_line}` 
    if $?.to_i != 0 and fails_on_error 
      $stderr.puts File.read(err_file)
      File.unlink(err_file)
      raise "#{CPP} returned #{$?.to_int/256} exit status\nline was: #{cpp_line}"
    end
    result = complete_result.select { |s|
      # First pass to only grab non-empty lines and the pre-processed lines
      # only from the target header (and not the entire pre-processing result).
      next if s.strip.empty? 
      m = %r{^#\s*\d+\s+"([^"]+)"}.match(s)
      f_on = (File.basename(m[1]) == File.basename(path)) if m
      f_on
    }.select { |s|
      # Second pass to ignore all pro-processor comments that were left.
      /^#/.match(s) == nil
    }.join
    File.unlink(err_file)
    return [complete_result, result]
  end

  class VarInfo
    attr_reader :rettype, :stripped_rettype, :name, :orig
    attr_accessor :octype

    def initialize(type, name, orig)
      @rettype = type
      @name = name
      @orig = orig
      @rettype.gsub!( /\[[^\]]*\]/, '*' )
      t = type.gsub(/\b(__)?const\b/,'')
      t.gsub!(/<[^>]*>/, '')
      t.gsub!(/\b(in|out|inout|oneway|const)\b/, '')
      t.gsub!(/\b__private_extern__\b/, '')
      t.gsub!(/^\s*\(?\s*/, '')
      t.gsub!(/\s*\)?\s*$/, '')
      raise "empty type (was '#{type}')" if t.empty?
      @stripped_rettype = t
    end

    def function_pointer?(func_ptr_types)
      type = (func_ptr_types[@stripped_rettype] or @stripped_rettype)
      @function_pointer ||= FuncPointerInfo.new_from_type(type)
    end

    def <=>(x)
      self.name <=> x.name
    end

    def hash
      @name.hash
    end

    def eql?(o)
      @name == o.name
    end
  end

  class FuncInfo < VarInfo
    attr_reader :args, :argc

    def initialize(func, args, orig, inline=false)
      super(func.rettype, func.name, orig)
      @args = args
      @argc = @args.size
      if @args[-1] && @args[-1].rettype == '...'
        @argc -= 1 
        @variadic = true
        @args.pop
      end
      @inline = inline
      self
    end

    def variadic?
      @variadic
    end

    def inline?
      @inline
    end
  end

  class FuncPointerInfo < FuncInfo
    def self.new_from_type(type)
      @cache ||= {}
      info = @cache[type]
      return info if info

      tokens = type.split(/\(\*\)/)
      return nil if tokens.size != 2

      rettype = tokens.first.strip
      rest = tokens.last.sub(/^\s*\(\s*/, '').sub(/\s*\)\s*$/, '')
      argtypes = rest.split(/,/).map { |x| x.strip }

      @cache[type] = self.new(rettype, argtypes, type) 
    end

    def initialize(rettype, argtypes, orig)
      args = argtypes.map { |x| VarInfo.new(x, '', '') }
      super(VarInfo.new(rettype, '', ''), args, orig)
    end
  end

  class MethodInfo < FuncInfo
    attr_reader :selector

    def initialize(method, selector, is_class, args, orig)
      super(method, args, orig)
      @selector, @is_class = selector, is_class
      self
    end

    def class_method?
      @is_class
    end

    def <=>(o)
      @selector <=> o.selector
    end
     
    def hash
      @selector.hash
    end

    def eql?(o)
      @selector == o.selector
    end
  end
end

TIGER_OR_BELOW = `sw_vers -productVersion`.strip.to_f <= 10.4
IS_PPC = `arch`.strip == 'ppc'

class BridgeSupportGenerator
  VERSION = '0.9'

  GCC = '/Developer/Platforms/iPhoneSimulator.platform/Developer/usr/bin/gcc-4.0 -isysroot /Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator2.0.sdk'

  FORMATS = ['final', 'exceptions-template', 'dylib', 'complete']
  FORMAT_FINAL, FORMAT_TEMPLATE, FORMAT_DYLIB, FORMAT_COMPLETE = FORMATS
 
  attr_accessor :headers, :generate_format, :private, :frameworks, 
    :exception_paths, :compiler_flags, :enable_64, :out_file,
    :pch_files
 
  attr_reader :resolved_structs, :resolved_cftypes, :resolved_enums,
    :types_encoding, :defines, :resolved_inf_protocols_encoding

  def initialize
    @headers = []
    @exception_paths = []
    @out_file = nil
    @generate_format = FORMAT_FINAL
    @private = false 
    @compiler_flags = nil 
    @frameworks = []
    @enable_64 = false
  end

  def duplicate
    g = BridgeSupportGenerator.new
    g.headers = @headers
    g.exception_paths = @exception_paths
    g.out_file = @out_file
    g.generate_format = @generate_format
    g.private = @private
    g.compiler_flags = @compiler_flags
    g.frameworks = @frameworks
    g.enable_64 = @enable_64
    g.pch_files = @pch_files
    return g
  end 

  def add_header(path)
    @headers << path
    @import_directive ||= ''
    @import_directive << "\n#include <#{File.basename(path)}>"
  end

  def collect 
    prepare
    scan_headers
    case @generate_format
    when FORMAT_FINAL, FORMAT_COMPLETE
      generate_precompiled_header
      collect_types_encoding
      collect_enums
      collect_numeric_defines
      collect_cftypes_info
      collect_structs_encoding
      collect_inf_protocols_encoding
      fix_types
      fix_method_types
      fix_struct_tags
    else
      generate_precompiled_header
      collect_types_encoding
    end
  end

  def write 
    case @generate_format
    when FORMAT_DYLIB
      generate_precompiled_header
      generate_dylib
    else
      generate_xml
    end
  end

  def cleanup
    delete_precompiled_header
  end

  def xml_document
    @xml_document ||= generate_xml_document
  end

  def generate_format=(format)
    if @generate_format != format
      @generate_format = format
      @xml_document = nil
    end
  end

  def merge_64_metadata(g)
    raise "given generator isn't 64-bit" unless g.enable_64

    [:types_encoding, :resolved_structs, :resolved_enums,
     :defines, :resolved_inf_protocols_encoding].each do |sym|

      hash = send(sym)
      g.send(sym).each do |name, val64|
        if val = hash[name]
          hash[name] = [val, val64]
        else
          hash[name] = [nil, val64]
        end
      end
    end

    g.resolved_cftypes.each do |name, ary64|
      type64 = ary64.first
      if ary = @resolved_cftypes[name]
        ary << type64
      else
        ary = ary64.dup
        ary[0] = nil
        ary << type64
        @resolved_cftypes[name] = ary
      end
    end
  end

  def has_inline_functions?
    @functions.any? { |f| f.inline? }
  end

  def self.dependencies_of_framework(path)
    @dependencies ||= {}
    name = File.basename(path, '.framework')
    path = File.join(path, name)
    deps = @dependencies[path]
    if deps.nil?
      deps = `otool -L "#{path}"`.scan(/\t([^\s]+)/).map { |m|
        dpath = m[0]
        next if File.basename(dpath) == name
        next if dpath.include?('PrivateFrameworks')
        next unless dpath.sub!(/\.framework\/Versions\/\w+\/\w+$/, '')
        dpath + '.framework'
      }.compact
      @dependencies[path] = deps
    end
    deps
  end

  def self.doc_for_dependency(fpath)
    @dep_docs ||= {}
    doc = @dep_docs[fpath]
    if doc.nil?
      fname = File.basename(fpath, '.framework')
      paths = []
      if bsroot = ENV['BSROOT']
        paths << File.join(bsroot, "#{fname}.bridgesupport")
      end
      path = File.join(fpath, "Resources/BridgeSupport/#{fname}.bridgesupport")
      alt_path = "/Library/BridgeSupport/#{fname}.bridgesupport"
      if dstroot = ENV['DSTROOT']
        path = File.join(dstroot, path)
        alt_path = File.join(dstroot, alt_path)
      end
      paths << path
      paths << alt_path
      a = Dir.glob(File.join(fpath, '**', '*.bridgesupport'))
      if a.length == 1
        paths << a.first
      end
      bspath = paths.find { |p| File.exist?(p) }
      return nil if bspath.nil?
      doc = REXML::Document.new(File.read(bspath))
      @dep_docs[fpath] = doc
    end
    doc
  end

  #######
  private
  #######

  def prepare
    # Clear previously-harvested stuff.
    [ @resolved_structs,
      @resolved_inf_protocols_encoding,
      @resolved_enums,
      @resolved_cftypes,
      @collect_types_encoding ].compact.each { |h| h.clear }

    return if @prepared

    @frameworks.each { |f| handle_framework(f) }

    if @headers.empty?
      raise "No headers to parse" 
    end
    if @import_directive.nil? or @compiler_flags.nil?
      raise "Compiler flags need to be provided for non-framework targets."
    end
    if @generate_format == FORMAT_DYLIB and @out_file.nil? 
      raise "Generating dylib format requires an output file"
    end
    if @enable_64 and (@generate_format != FORMAT_FINAL \
                       and @generate_format != FORMAT_COMPLETE)
      raise "Enabling 64-bit only works with the final metadata format"
    end

    # Link against Foundation by default.
    if @compiler_flags and @import_directive 
      @import_directive.insert(0, "#import <Foundation/Foundation.h>\n")
      @compiler_flags << ' -framework Foundation '
    end

    # Open exceptions, ignore mentionned headers.
    # Keep the list of structs, CFTypes, boxed and methods return/args types.
    @ignored_defines_regexps = []
    @structs = {} 
    @cftypes = {} 
    @opaques = {} 
    @opaques_to_ignore = []
    @method_exception_types = []
    @sel_types = {}
    all_sel_types = [] 
    @func_aliases = {}
    @exceptions = @exception_paths.map { |x| REXML::Document.new(File.read(x)) }
    @exceptions.each do |doc|
      doc.get_elements('/signatures/ignored_headers/header').each do |element|
        path = element.text
        path_re = /#{path}/
        ignored = @headers.select { |x| path_re.match(x) }
        @headers -= ignored
        if @import_directive
          ignored.each { |x| @import_directive.gsub!(/#import.+#{File.basename(x)}>/, '') } 
        end
      end
      doc.get_elements('/signatures/ignored_defines/regex').each do |element|
        @ignored_defines_regexps << Regexp.new(element.text.strip)
      end
      doc.get_elements('/signatures/struct').each do |elem|
        @structs[elem.attributes['name']] = [elem.attributes['opaque'] == 'true', elem.attributes['only_in']]
      end
      doc.get_elements('/signatures/cftype').each do |elem|
        @cftypes[elem.attributes['name']] = [
          elem.attributes['gettypeid_func'], 
          elem.attributes['ignore_tollfree'] == 'true'
        ]
      end
      doc.get_elements('/signatures/opaque').each do |elem|
        name, type, ignore = elem.attributes['name'], elem.attributes['type'], elem.attributes['ignore']
        @opaques[name] = type 
        @opaques_to_ignore << name if ignore == 'true'
      end
      ['/signatures/class/method', '/signatures/function'].each do |path|
        doc.get_elements(path).each do |elem|
          ary = [elem.elements['retval']]
          ary.concat(elem.get_elements('arg'))
          ary.compact.each do |elem2|
            type = elem2.attributes['type']
            if @enable_64
              type64 = elem2.attributes['type64']
              if type64 == ''
                type = nil
              elsif type != type64
                type = type64
              end
            end
            @method_exception_types << type if type
            if sel_type = elem2.attributes['sel_of_type']
              all_sel_types << sel_type
            end
          end
        end
      end
      doc.get_elements('/signatures/function_alias').each do |elem|
        name, original = elem.attributes['name'], elem.attributes['original']
        @func_aliases[original.strip] = name.strip
      end
    end
    
    # Prepare and create fake methods for the future sel_of_type attributes. 
    @sel_types = {}
    origs = {}
    all_sel_types.uniq.each do |type| 
      stype = type.sub(/^\s*[-+]/, '').sub(';\s*$', '').strip
      origs["- #{stype};"] = type
    end
    unless origs.empty?
      fake_header = "@interface NSObject (FakeHeader) \n#{origs.keys.join("\n")}\n@end"
      OCHeaderAnalyzer.data(fake_header).informal_protocols['FakeHeader'].each do |method|
        type = origs[method.orig]
        @sel_types[type] = method  
      end
    end

    # Collect necessary elements from the dependencies bridge support files.
    @dep_cftypes = [] 
    @dependencies ||= []
    @dependencies.each do |path|
      doc = BridgeSupportGenerator.doc_for_dependency(path)
      next if doc.nil?
      doc.get_elements('/signatures/cftype').each do |elem|
        @dep_cftypes << elem.attributes['name']
      end 
    end

    # We are done!
    @prepared = true
  end

  def collect_enums
    @resolved_enums ||= {} 
    lines = @enums.map do |name, val|
      "printf(((int)#{name}) < 0 ? \"%s: %d\\n\" : \"%s: %u\\n\", \"#{name}\", #{name});" 
    end
    code = <<EOS
#{@import_directive}

int main (void) 
{
    char *fmt;
    #{lines.join("\n  ")}
    return 0;
}
EOS
    compile_and_execute_code(code).split("\n").each do |line|
      name, value = line.split(':')
      @resolved_enums[name.strip] = value.strip
    end
  end

  def collect_numeric_defines
    @resolved_enums ||= {} 
    code = <<EOS
#{@import_directive}
#import <objc/objc-class.h>

/* Tiger compat */
#ifndef _C_ULNG_LNG
#define _C_ULNG_LNG 'Q'
#endif

#ifndef _C_LNG_LNG
#define _C_LNG_LNG 'q'
#endif

static const char * 
printf_format (const char *str)
{
  if (str == NULL || strlen(str) != 1)
    return NULL;
  switch (*str) {
    case _C_SHT: return "%s: %hd\\n";
    case _C_USHT: return "%s: %hu\\n";
    case _C_INT: return "%s: %d\\n";
    case _C_UINT: return "%s: %u\\n";
    case _C_LNG: return "%s: %ld\\n";
    case _C_ULNG: return "%s: %lu\\n";
    case _C_LNG_LNG: return "%s: %lld\\n";
    case _C_ULNG_LNG: return "%s: %llu\\n";
    case _C_FLT: return "%s: %#.17g\\n";
    case _C_DBL: return "%s: %#.17g\\n";
  }
  return NULL;
}

int main (void) 
{
  const char *fmt;
  PRINTF_LINE_HERE 
  return 0;
}
EOS
    pure_numeric_lines = []
    numeric_re = /\)?\s*(0x[\da-fA-F]+|[\d\.]+)\s*\)*\s*$/
    skip_names = ['extern', 'return', '{', '}']
    emulate_ppc = false #!(IS_PPC or @enable_64 or TIGER_OR_BELOW)
    @defines.each do |name, value|
      name.strip!
      value.strip!
      next if name.strip[0] == ?_
      next if @ignored_defines_regexps.any? { |re| re.match(name) }
      next if value[0] == ?"
      next if value.include?('__attribute__')
      next if skip_names.include?(value)
      line = <<EOL
#if defined(#{name})
if ((fmt = printf_format(@encode(__typeof__(#{name})))) != NULL)
  printf(fmt, \"#{name}\", #{name});
#endif
EOL
      if numeric_re.match(value)
        pure_numeric_lines << line
      else
        begin
          code2 = code.sub(/PRINTF_LINE_HERE/, line)
          val = compile_and_execute_code(code2, true, emulate_ppc)
          if emulate_ppc
            name, le_value = val[0].split(':')
            name.strip!; le_value.strip!
            be_value = val[1].split(':')[1].strip
            value = [le_value, be_value]
          else
            name, value = val.split(':')
            name.strip!; value.strip!
          end
          @resolved_enums[name] = value
        rescue
        end
      end
    end
    unless pure_numeric_lines.empty?
      code2 = code.sub(/PRINTF_LINE_HERE/, pure_numeric_lines.join("\n"))
      val = compile_and_execute_code(code2, false, emulate_ppc)
      val.to_a.map { |d| d.split(/\n/) }.flatten.each do |line|
        name, value = line.split(':')
        name.strip!; value.strip!
        if emulate_ppc
          @resolved_enums[name] ||= []
          @resolved_enums[name] << value
        else
          @resolved_enums[name] = value
        end
      end
    end
  end

  def encoding_of(varinfo, try64=false)
    if /^(BOOL|Boolean)$/.match(varinfo.stripped_rettype)
      'B'
    elsif /^(BOOL|Boolean)\s*\*$/.match(varinfo.stripped_rettype)
      '^B'
    else
      v = @types_encoding[varinfo.stripped_rettype]
      if try64
        v.is_a?(Array) ? v.last : nil
      else
        v.is_a?(Array) ? v.first : v
      end
    end
  end

  def pointer_type?(varinfo)
    type = encoding_of(varinfo)
    if type and type[0] == ?^
      @pointer_types ||= {}
      return true if @pointer_types[varinfo.stripped_rettype]
      return false if cf_type?(varinfo.stripped_rettype)
      @pointer_types[varinfo.stripped_rettype] = true
    end
  end

  def bool_type?(varinfo)
    type = encoding_of(varinfo)
    type and type[-1] == ?B
  end

  def tagged_struct_type?(varinfo)
    type = encoding_of(varinfo)
    type and @tagged_struct_types.include?(type)
  end

  def function_pointer_type?(varinfo)
    varinfo.function_pointer?(@func_ptr_types)
  end

  def boolified_method_type(method, method_type)
    raise "method type of #{method.selector} is nil" if method_type.nil?
    offset = 0
    [method, *method.args].each do |arg|
      type = encoding_of(arg)
      if type == 'B' or type == 'c'
        offset = method_type.index('c', offset)
        method_type[offset] = type if type == 'B'
        offset += 1
      elsif type == '^B' or type == '^c'
        offset = method_type.index('^c', offset)
        method_type[offset..offset+1] = type if type == '^B'
        offset += 2 
      end
    end
    method_type 
  end

  def add_type_attributes(element, varinfo, varinfo64=nil)
    if varinfo.is_a?(OCHeaderAnalyzer::VarInfo)
      type = encoding_of(varinfo)
      element.add_attribute('type', type) if type
      type64 = encoding_of(varinfo, true)
      element.add_attribute('type64', type64) if type64 and type != type64
      if func_ptr_info = varinfo.function_pointer?(@func_ptr_types)
        element.add_attribute('function_pointer', 'true')
        func_ptr_info.args.each do |a| 
          func_ptr_elem = element.add_element('arg')
          add_type_attributes(func_ptr_elem, a)
        end
        func_ptr_retval = element.add_element('retval')
        add_type_attributes(func_ptr_retval, func_ptr_info)
      end
    else
      element.add_attribute('type', varinfo) if varinfo
      element.add_attribute('type64', varinfo64) if varinfo64 and varinfo != varinfo64
    end 
  end

  def __add_value_attributes__(element, value, is_64)
    suffix = is_64 ? '64' : ''
    if value.is_a?(Array)
      raise unless value.length == 2
      if value[0] != value[1]
        element.add_attribute('le_value' + suffix, value[0])
        element.add_attribute('be_value' + suffix, value[1])
        return
      end
      value = value[0]
    end
    element.add_attribute('value' + suffix, value)
  end

  def add_value_attributes(element, varinfo, varinfo64=nil)
    if varinfo
      __add_value_attributes__(element, varinfo, false)
    end
    if varinfo64 and varinfo.to_a.first != varinfo64
      __add_value_attributes__(element, varinfo64, true)
    end
  end

  def collect_cftypes_info
    @resolved_cftypes ||= {}
    lines = []
    @cftypes.each do |name, ary|
      gettypeid_func, ignore_tollfree = ary
      lines << if gettypeid_func and !ignore_tollfree
        "ref = _CFRuntimeCreateInstance(NULL, #{gettypeid_func}(), sizeof(#{name}), NULL); printf(\"%s: %s: %s\\n\", \"#{name}\", @encode(#{name}), ref != NULL ? object_getClassName((id)ref) : \"\");"
      else
        "printf(\"%s: %s: %s\\n\", \"#{name}\", @encode(#{name}), \"\");"
      end
    end
    code = <<EOS
#{@import_directive}
#import <objc/objc-class.h>

CFTypeRef _CFRuntimeCreateInstance(CFAllocatorRef allocator, CFTypeID typeID, #{TIGER_OR_BELOW ? 'uint32_t' : 'CFIndex'} extraBytes, unsigned char *category);

int main (void) 
{
    CFTypeRef ref;
    #{lines.join("\n  ")}
    return 0;
}
EOS
    compile_and_execute_code(code).split("\n").each do |line|
      name, encoding, tollfree = line.split(':')
      tollfree.strip!
      tollfree = nil if tollfree.empty? or tollfree == 'NSCFType'
      @resolved_cftypes[name.strip] = [encoding.strip, tollfree, @cftypes[name.strip].first]
    end
  end

  def collect_types_encoding
    @types_encoding ||= {}
    all_types = @functions.map { |x| 
      [x.stripped_rettype, *x.args.map { |y| y.stripped_rettype }] 
    }.flatten 
    all_types |= @constants.map { |x| x.stripped_rettype }
    all_types |= (@ocmethods.to_a | @inf_protocols.to_a).map { |c, m| 
      m.map { |x| [x.stripped_rettype, *x.args.map { |y| y.stripped_rettype }] } 
    }.flatten
    all_types |= @method_exception_types
    all_types |= @opaques.keys
    all_types |= @func_ptr_types.values.map { |x| 
      info = OCHeaderAnalyzer::FuncPointerInfo.new_from_type(x)
      [info.stripped_rettype, *info.args.map { |y| y.stripped_rettype }] 
    }.flatten

    lines = all_types.map do |type|
      "printf(\"%s -> %s\\n\", \"#{type}\", @encode(#{type}));"
    end
    code = <<EOS
#{@import_directive}

int main (void) 
{
    #{lines.join("\n  ")}
    return 0;
}
EOS
    compile_and_execute_code(code).split("\n").each do |line|
      name, value = line.split('->')
      @types_encoding[name.strip] = value.strip
    end

    @opaques.each do |name, type|
      next unless type
      next if type[0] != ?^ or type == '^v' 
      old_type = @types_encoding[name]
      @types_encoding.each do |n, t|
        next unless t == old_type
        @types_encoding[n] = type
      end
    end
  end

  def collect_structs_encoding
    @resolved_structs ||= {}
    ivar_st = []
    log_st = []
    @structs.each do |name, ary|
      is_opaque, only_in = ary
      if @enable_64
        next if only_in == '32'
      else
        next if only_in == '64'
      end
      ivar_st << "#{name} a#{name};"
      log_st << "printf(\"%s: %s\\n\", \"#{name}\", ivar_getTypeEncoding(class_getInstanceVariable(klass, \"a#{name}\")));"
    end
    code = <<EOS
#{@import_directive}
#import <objc/objc-class.h>

#{TIGER_OR_BELOW ? '#define ivar_getTypeEncoding(x) (x->ivar_type)' : ''}

@interface __MyClass : NSObject
{
#{ivar_st.join("\n")}
}
@end

@implementation __MyClass
@end

int main (void) 
{
  Class klass = objc_getClass("__MyClass");
  #{log_st.join("\n")}
  return 0;
}
EOS
    compile_and_execute_code(code).split("\n").each do |line|
      name, value = line.split(':')
      @resolved_structs[name.strip] = value.strip
    end
  end

  def collect_inf_protocols_encoding
    @resolved_inf_protocols_encoding ||= {}
    objc_impl_st = []
    log_st = []
    (@inf_protocols.map { |name, methods| methods }.flatten + @sel_types.values.uniq).each do |method| 
      defi = "#{method.orig} {}"
      objc_impl_st << "#{method.orig} {}" 
      log_st << if TIGER_OR_BELOW
          <<EOS
printf("%s -> %s\\n", "#{method.selector}", #{method.class_method? ? "class_getClassMethod" : "class_getInstanceMethod"}(klass, @selector(#{method.selector}))->method_types); 
EOS
      else
          <<EOS
printf("%s -> %s\\n", "#{method.selector}", method_getDescription(#{method.class_method? ? "class_getClassMethod" : "class_getInstanceMethod"}(klass, @selector(#{method.selector})))->types); 
EOS
      end
    end 
    code = <<EOS
#{@import_directive}
#import <objc/objc-class.h>

@interface __MyClass : NSObject
@end

@implementation __MyClass
#{objc_impl_st.join("\n")}
@end

int main (void) 
{
  Class klass = objc_getClass("__MyClass");
  #{log_st.join("\n  ")}
  return 0;
}
EOS
    compile_and_execute_code(code).split("\n").each do |line|
      name, value = line.split('->')
      @resolved_inf_protocols_encoding[name.strip] = value.strip
    end
  end

  def cf_type?(name)
    (@resolved_cftypes and @resolved_cftypes.has_key?(name)) or 
    (@cftype_names and @cftype_names.include?(name)) or
    cf_type_ref?(name) or @dep_cftypes.include?(name)
  end

  def cf_type_ref?(name)
    return true if name == 'CFTypeRef'
    orig = @typedefs[name]
    return false if orig.nil?
    cf_type_ref?(orig)
  end

  def fix_types
    @types_encoding.each do |name, type|
      next unless type == '^v'
      if cf_type_ref?(name)
        @types_encoding[name] = '@'
      end
    end
  end

  def fix_method_types
    (@inf_protocols.map { |name, methods| methods }.flatten + @sel_types.values).each do |method|
      type = @resolved_inf_protocols_encoding[method.selector]
      type = boolified_method_type(method, type)
      @resolved_inf_protocols_encoding[method.selector] = type 
    end
  end

  def fix_struct_tags
    @tagged_struct_types = []
    tagged_structs = {}
    @resolved_structs.sort { |x, y| 
      x[1].length <=> y[1].length 
    }.map { |name, type|
      old_type = type.dup
      type.sub!(/^\{\?=/, "{_#{name}=")
      tagged_structs.each do |old_type2, type2|
        type.gsub!(old_type2, type2)
      end
      if old_type != type
        tagged_structs[old_type] = type 
        [old_type, type].map { |s| s.gsub(/"[^"]+"/, '') }
      end
    }.compact.sort { |x, y|
      y[0].length <=> x[0].length
    }.each { |fieldless_types|
      @types_encoding.each do |name2, type2|
        if type2.sub!(*fieldless_types)
          @tagged_struct_types << type2
        end
      end
    }
  end

  def generate_dylib
    inline_functions = @functions.select { |x| x.inline? }
    if inline_functions.empty?
      $stderr.puts "No inline functions in the given framework/library, no need to generate a dylib."
      return
    end    
    code = "#{@import_directive}\n"
    inline_functions.each do |function|
      orig = function.orig.sub(/__attribute__\(\(always_inline\)\)/, '').strip
      new = orig.sub(function.name, '__dummy_' + function.name)
      ret = encoding_of(function) == 'v' ? '' : 'return '
      code << <<EOC
#{new} __asm__ ("_#{function.name}");
#{new} { 
  #{ret}#{function.name}(#{function.args.map { |x| x.name }.join(', ')});
} 
EOC
    end
    tmp_src = File.open(unique_tmp_path('src', '.m'), 'w')
    tmp_src.puts code
    tmp_src.close
    if File.extname(@out_file) != '.dylib'
      @out_file << '.dylib'
    end
    gcc = "#{GCC} #{ENV['CFLAGS']} #{tmp_src.path} -o #{@out_file} #{@compiler_flags} -dynamiclib -O3 -current_version #{VERSION} -compatibility_version #{VERSION}"
    unless system(gcc)
      raise "Can't compile dylib source file '#{tmp_src.path}'\nLine was: #{gcc}"
    end
    File.unlink(tmp_src.path)
  end

  def any_in_exceptions(xpath)
    @exceptions.each do |doc| 
      elem = doc.elements[xpath]
      return elem if elem
    end
    return nil
  end

  def all_in_exceptions(xpath)
    ary = []
    @exceptions.each do |doc|
      doc.elements.each(xpath) { |elem| ary << elem }
    end
    return ary
  end

  def generate_xml_document
    document = REXML::Document.new
    document << REXML::XMLDecl.new
    # REXML normalize DTD location 1.8.6p40 or later
    if RUBY_VERSION < "1.8.6" || (RUBY_VERSION == "1.8.6" && RUBY_PATCHLEVEL < 40) then
      document << REXML::DocType.new(['signatures', 'SYSTEM', '"file://localhost/System/Library/DTDs/BridgeSupport.dtd"'])
    else
      document << REXML::DocType.new(['signatures', 'SYSTEM', 'file://localhost/System/Library/DTDs/BridgeSupport.dtd'])
    end
    root = document.add_element('signatures')
    root.add_attribute('version', VERSION)

    case @generate_format
    when FORMAT_TEMPLATE
      # Generate the exception template file.
      all_in_exceptions("/signatures/ignored_defines").each { |elem| root.add_element(elem) }
      all_in_exceptions("/signatures/ignored_headers").each { |elem| root.add_element(elem) }
      @cftype_names.sort.each do |name|
        element = any_in_exceptions("/signatures/cftype[@name='#{name}']")
        if element
          root.add_element(element)
        else
          element = root.add_element('cftype')
          element.add_attribute('name', name) 
          gettypeid_func = name.sub(/Ref$/, '') + 'GetTypeID'
          ok = @functions.find { |x| x.name == gettypeid_func }
          if !ok and gettypeid_func.sub!(/Mutable/, '')
            ok = @functions.find { |x| x.name == gettypeid_func }
          end
          element.add_attribute('gettypeid_func', ok ? gettypeid_func : '?')
        end
      end
      @struct_names.sort.each do |struct_name|
        element = any_in_exceptions("/signatures/struct[@name='#{struct_name}']")
        if element
          root.add_element(element)
        else
          element = root.add_element('struct')
          element.add_attribute('name', struct_name)
        end
      end
      all_in_exceptions("/signatures/opaque").each { |elem| root.add_element(elem) }
      all_in_exceptions("/signatures/constant").each { |elem| root.add_element(elem) }
      all_in_exceptions("/signatures/function").each { |elem| root.add_element(elem) }
      @functions.sort.each do |function|
        pointer_arg_indexes = []
        function.args.each_with_index do |arg, i| 
          pointer_arg_indexes << i if pointer_type?(arg)
        end
        next if pointer_arg_indexes.empty?

        element = root.elements["/signatures/function[@name='#{function.name}']"]
        unless element
          element = root.add_element('function')
          element.add_attribute('name', function.name)
        end
        pointer_arg_indexes.each do |i|
          unless element.elements["arg[@index='#{i}']"]
            arg_element = element.add_element('arg')
            arg_element.add_attribute('index', i.to_s)
            arg_element.add_attribute('type_modifier', 'o')
            arg_element.add_attribute('NEW', '1')
          end
        end
      end
      all_in_exceptions("/signatures/class").each { |elem| root.add_element(elem) }
      @ocmethods.sort.each do |class_name, methods|
        method_elements = []
        class_element = root.elements["/signatures/class[@name='#{class_name}']"]
        methods.sort.each do |method|
          pointer_arg_indexes = []
          method.args.each_with_index do |arg, i|
            pointer_arg_indexes << i if pointer_type?(arg)
          end
          next if pointer_arg_indexes.empty?
 
          element = class_element.elements["method[@selector='#{method.selector}'#{method.class_method? ? ' and @class_method=\'true\'' : ''}]"] if class_element
          if element
            next if element.attributes['ignore'] == 'true'
          else
            element = REXML::Element.new('method')
            element.add_attribute('selector', method.selector)
            element.add_attribute('class_method', 'true') if method.class_method?
          end
          pointer_arg_indexes.each do |i|
            unless element.elements["arg[@index='#{i}']"]
              arg_element = element.add_element('arg')
              arg_element.add_attribute('index', i.to_s)
              arg_element.add_attribute('type_modifier', 'o')
              arg_element.add_attribute('NEW', '1')
            end
          end
          method_elements << element
        end
        if !method_elements.empty? and !class_element
          element = root.add_element('class')
          element.add_attribute('name', class_name)
          method_elements.each { |x| element.add_element(x) }
        end
      end
    when FORMAT_FINAL, FORMAT_COMPLETE
      # Generate the final metadata file.
      @dependencies.each do |fpath|
        element = root.add_element('depends_on')
        element.add_attribute('path', fpath)
      end
      @resolved_structs.sort.each do |name, type|
        element = root.add_element('struct')
        element.add_attribute('name', name)
        add_type_attributes(element, *type)
        element.add_attribute('opaque', 'true') if @structs[name].first
        if @generate_format == FORMAT_COMPLETE
          type.to_a.first[1..-2].gsub(/\{[^}]+\}/, '').scan(/"([^"]+)"/).flatten.each do |name|
            field_elem = element.add_element('field')
            field_elem.add_attribute('name', name)
          end
        end
      end
      @resolved_cftypes.sort.each do |name, ary|
        type, tollfree, gettypeid_func, type64 = ary
        element = root.add_element('cftype')
        element.add_attribute('name', name) 
        add_type_attributes(element, type, type64)
        element.add_attribute('gettypeid_func', gettypeid_func) if gettypeid_func 
        element.add_attribute('tollfree', tollfree.to_s) if tollfree 
      end
      @opaques.keys.sort.each do |name|
        next if @opaques_to_ignore.include?(name)
        raise "encoding of opaque type '#{name}' not resolved" unless @types_encoding.has_key?(name)
        element = root.add_element('opaque')
        element.add_attribute('name', name.sub(/\s*\*+$/, '')) 
        add_type_attributes(element, *@types_encoding[name])
      end
      @constants.sort.each do |constant| 
        element = root.add_element('constant')
        element.add_attribute('name', constant.name)
        add_type_attributes(element, constant)
      end
      @defines.sort.each do |name, value|
        if value.is_a?(Array)
          if value.first == value.last
            value = value.first
          else
            value = (value.first or value.last)
          end
        end
        value.strip!
        c_str = objc_str = false
        if value[0] == ?" and value[-1] == ?"
          value = value[1..-2]
          c_str =  true
        elsif value[0] == ?@ and value[1] == ?" and value[-1] == ?"
          value = value[2..-2]
          objc_str = true
        elsif md = /^CFSTR\s*\(\s*([^)]+)\s*\)\s*$/.match(value)
          if md[1][0] == ?" and md[1][-1] == ?"
            value = md[1][1..-2]
            objc_str = true
          end
        end
        next if !c_str and !objc_str
        element = root.add_element('string_constant')
        element.add_attribute('name', name.strip)
        element.add_attribute('value', value)
        element.add_attribute('nsstring', objc_str.to_s) if objc_str
      end
      @resolved_enums.sort.each do |enum, value| 
        element = root.add_element('enum')
        element.add_attribute('name', enum)
        add_value_attributes(element, *value)
      end
      @functions.uniq.sort.each do |function|
        element = root.add_element('function')
        element.add_attribute('name', function.name)
        element.add_attribute('variadic', 'true') if function.variadic?
        element.add_attribute('inline', 'true') if function.inline?
        function.args.each do |arg|
          arg_elem = element.add_element('arg')
          add_type_attributes(arg_elem, arg)
          if @generate_format == FORMAT_COMPLETE
            arg_elem.add_attribute('name', arg.name)
          end
        end
        rettype = encoding_of(function)
        if rettype != 'v'
          retval_element = element.add_element('retval')
          add_type_attributes(retval_element, function)
          retval_element.add_attribute('already_retained', 'true') \
            if cf_type?(function.stripped_rettype) \
            and /(Create|Copy)/.match(function.name)
        end
      end
      @func_aliases.sort.each do |original, name|
        element = root.add_element('function_alias')
        element.add_attribute('name', name)
        element.add_attribute('original', original)
      end
      @ocmethods.sort.each do |class_name, methods|
        elements = methods.sort.map { |method| 
          if @generate_format == FORMAT_FINAL
            custom_retval = (bool_type?(method) or tagged_struct_type?(method))
            custom_args = []
            method.args.each_with_index do |a, i|
              if bool_type?(a) or tagged_struct_type?(a) or function_pointer_type?(a)
                custom_args << i
              end
            end
          else
            custom_retval = true
            custom_args = (0..method.args.length - 1).to_a
          end 
          next if !custom_retval and custom_args.empty? and !method.variadic?
          element = REXML::Element.new('method')
          element.add_attribute('selector', method.selector)
          element.add_attribute('class_method', 'true') if method.class_method?
          element.add_attribute('variadic', 'true') if method.variadic?
          custom_args.each do |i|
            arg_elem = element.add_element('arg')
            arg_elem.add_attribute('index', i.to_s)
            add_type_attributes(arg_elem, method.args[i])
            if @generate_format == FORMAT_COMPLETE
              arg_elem.add_attribute('name', method.args[i].name)
            end
          end
          if custom_retval
            retval_elem = element.add_element('retval')
            add_type_attributes(retval_elem, method)
          end
          element
        }.compact
        next if elements.empty?
        class_element = root.add_element('class')
        class_element.add_attribute('name', class_name)           
        elements.each { |x| class_element.add_element(x) }
      end
      @inf_protocols.sort.each do |name, methods|
        next if methods.empty?
        prot_element = root.add_element('informal_protocol')
        prot_element.add_attribute('name', name)
        methods.sort.each do |method|
          element = prot_element.add_element('method')
          method_types = @resolved_inf_protocols_encoding[method.selector].to_a
          element.add_attribute('selector', method.selector)
          element.add_attribute('class_method', 'true') if method.class_method?
          add_type_attributes(element, *method_types)
          if @generate_format == FORMAT_COMPLETE
            method.args.each_with_index do |arg, i|
              arg_elem = element.add_element('arg')
              arg_elem.add_attribute('index', i.to_s)
              arg_elem.add_attribute('name', arg.name)
            end
          end
        end
      end

      # Merge with exceptions.
      @exceptions.each { |x| merge_document_with_exceptions(document, x) }
    end
    return document
  end

  def generate_xml
    if @out_file
      File.open(@out_file, 'w') { |io| xml_document.write(io, 0) }
    else
      xml_document.write(STDOUT, 0)
    end
  end

  def merge_arg_exception_attributes(orig_element, element, keep_index=true)
    element.attributes.each do |name, value|
      next if name == 'index' and !keep_index
      if name == 'type'
        value = @types_encoding[value]
        raise "encoding of '#{element}' not resolved" if value.nil?
      elsif name == 'sel_of_type'
        sel = @sel_types[value].selector
        types = @resolved_inf_protocols_encoding[sel].to_a.uniq
        raise "selector type of '#{element}' not resolved" if types.empty?
        value = types[0]
        orig_element.add_attribute('sel_of_type64', types[1]) if types.size > 1
      end
      orig_element.add_attribute(name, value)
    end
  end

  def merge_document_with_exceptions(document, exception_document)
    # Merge constants.
    errors = []
    exception_document.elements.each('/signatures/constant') do |const_element|
      const_name = const_element.attributes['name']
      orig_const_element = document.elements["/signatures/constant[@name='#{const_name}']"]
      if orig_const_element.nil?
        errors << "Constant '#{const_name}' is described in an exception file but it has not been discovered by the final generator"
        next
      end
      magic_cookie = const_element.attributes['magic_cookie']
      # Append the magic_cookie attribute.
      if magic_cookie == 'true'
        orig_const_element.add_attribute('magic_cookie', 'true')
      end
    end
    # Merge enums.
    exception_document.elements.each('/signatures/enum') do |enum_element|
      enum_name = enum_element.attributes['name']
      orig_enum_element = document.elements["/signatures/enum[@name='#{enum_name}']"]
      if orig_enum_element.nil?
        if @defines.has_key?(enum_name)
          document.root.add_element(enum_element) 
        else
          errors << "Enum '#{enum_name}' is described in an exception file but it has not been discovered by the final generator" 
        end
      else
        ignore = enum_element.attributes['ignore']
        # Append the ignore/suggestion attributes.
        if ignore == 'true'
          orig_enum_element.add_attribute('ignore', 'true')
          suggestion = enum_element.attributes['suggestion']
          orig_enum_element.add_attribute('suggestion', suggestion) if suggestion
          orig_enum_element.delete_attribute('value')
        end
      end
    end
    # Merge functions.
    exception_document.elements.each('/signatures/function') do |func_element|
      func_name = func_element.attributes['name']
      orig_func_element = document.elements["/signatures/function[@name='#{func_name}']"]
      if orig_func_element.nil?
        errors << "Function '#{func_name}' is described in an exception file but it has not been discovered by the final generator"
        next
      end
      orig_func_args = orig_func_element.get_elements('arg')
      func_element.elements.each('arg') do |arg_element|
        idx = arg_element.attributes['index'].to_i
        orig_arg_element = orig_func_args[idx]
        if orig_arg_element.nil?
          errors << "Function '#{func_name}' is described with more arguments than it should"
          next
        end
        merge_arg_exception_attributes(orig_arg_element, arg_element, false)
      end
      retval_element = func_element.elements['retval']
      if retval_element
        orig_retval_element = orig_func_element.elements['retval']
        if orig_retval_element.nil?
          errors << "Function '#{func_name}' is described with a return value in an exception file but the return value has not been discovered by the final generator"
        else
          merge_arg_exception_attributes(orig_retval_element, retval_element)
        end
      end
    end
    # Merge class/methods.
    exception_document.elements.each('/signatures/class') do |class_element|
      class_name = class_element.attributes['name']
      if @ocmethods[class_name].nil?
        errors << "Class '#{class_name}' is described in an exception file but it has not been discovered by the final generator"
        next
      end
      orig_class_element = document.elements["/signatures/class[@name='#{class_name}']"]
      if orig_class_element.nil?
        # Class is not defined in the original document, we can append it with its methods.
        orig_class_element = document.root.add_element(class_element)
      end
      # Merge methods.
      class_element.elements.each('method') do |element|
        selector = element.attributes['selector']
        orig_element = orig_class_element.elements["method[@selector='#{selector}']"]
        if orig_element.nil?
          # Method is not defined in the original document, we can append it.
          orig_element = orig_class_element.add_element(element)
        end
        # Smart merge of attributes.  
        element.attributes.each do |name, value|
          orig_value = orig_element.attributes[name]
          if orig_value != value                        
            $stderr.puts "Warning: attribute '#{name}' of method '#{selector}' of class '#{class_name}' has a different value in the exception file -- using the latter value" unless orig_value.nil?
            orig_element.add_attribute(name, value)
          end
        end
        # Merge the arg elements.
        orig_retval = orig_element.elements['retval']
        element.elements.each('arg') do |child| 
          index = child.attributes['index']
          orig_arg = orig_element.elements["arg[@index='#{index}']"]
          if orig_arg.nil?
            orig_arg = if orig_retval
              orig_element.insert_before(orig_retval, child)
              child
            else
              orig_element.add_element(child)
            end
          end
          merge_arg_exception_attributes(orig_arg, child)        
        end
        # Merge the retval element.
        retval = element.elements['retval']
        if retval
          if orig_retval.nil?
            orig_retval = orig_element.add_element(retval)
          end
          merge_arg_exception_attributes(orig_retval, retval)
        end
      end
    end
    unless errors.empty?
      raise "Error(s) when merging exception data:\n#{errors.join("\n")}"
    end
  end

  def scan_headers
    @functions = [] 
    @constants = [] 
    @enums = {}
    @defines = {} 
    @struct_names = []
    @cftype_names = []
    @inf_protocols = {} 
    @ocmethods = {}
    @func_ptr_types = {}
    @typedefs = {}
    @headers.map { |path|
      raise "Given header file `#{path}' doesn't exist" unless File.exist?(path)
      OCHeaderAnalyzer.path(path, !@private, @enable_64, @cpp_flags)
    }.each do |analyzer|
      case @generate_format
      when FORMAT_DYLIB
        @functions.concat(analyzer.functions(true))
      when FORMAT_TEMPLATE
        @functions.concat(analyzer.functions)
        @functions.concat(analyzer.functions(true))
        @struct_names.concat(analyzer.struct_names)
        @cftype_names.concat(analyzer.cftype_names)
      when FORMAT_FINAL, FORMAT_COMPLETE 
        @functions.concat(analyzer.functions)
        @functions.concat(analyzer.functions(true))
        @constants.concat(analyzer.constants)
        @enums.merge!(analyzer.enums)
        @defines.merge!(analyzer.defines)
        @inf_protocols.merge!(analyzer.informal_protocols)
        @func_ptr_types.merge!(analyzer.function_pointer_types)
        @typedefs.merge!(analyzer.typedefs)
      end
      @ocmethods.merge!(analyzer.ocmethods) { |key, old, new| old.concat(new) }
    end
    to_not_delete = @func_aliases.keys
    [@functions, @constants, @defines, @enums].each do |c|
      c.delete_if do |*a|
        n = a[0]
        n = n.name if n.is_a?(OCHeaderAnalyzer::VarInfo)
        !to_not_delete.include?(n) and n[0] == ?_ 
      end
    end
    [@constants, @struct_names, @cftype_names].each { |c| c.uniq! }
    all_inf_protocol_signatures = @inf_protocols.values.map { |ary| ary.map { |m| m.selector } }.flatten
    @inf_protocols.each do |name, methods|
      methods.delete_if do |method|
        s = method.selector
        all_inf_protocol_signatures.select { |s2| s2 == s }.length > 1
      end
    end
  end

  def handle_framework(val)
    path = framework_path(val)
    raise "Can't locate framework '#{val}'" if path.nil?
    (@framework_paths ||= []) << File.dirname(path)
    raise "Can't find framework '#{val}'" if path.nil?
    parent_path, name = path.scan(/^(.+)\/(\w+)\.framework\/?$/)[0]
    if @private
      headers_path = File.join(path, 'PrivateHeaders')
      raise "Can't locate private framework headers at '#{headers_path}'" unless File.exist?(headers_path) 
      headers = Dir.glob(File.join(headers_path, '**', '*.h'))
      public_headers_path = File.join(path, 'Headers')
      public_headers = if File.exist?(public_headers_path)
        OCHeaderAnalyzer::CPPFLAGS << " -I#{public_headers_path} "
        Dir.glob(File.join(headers_path, '**', '*.h'))
      else
        []
      end
    else
      headers_path = File.join(path, 'Headers')
      raise "Can't locate public framework headers at '#{headers_path}'" unless File.exist?(headers_path) 
      public_headers = headers = Dir.glob(File.join(headers_path, '**', '*.h'))
    end
    # We can't just "#import <x/x.h>" as the main Framework header might not include _all_ headers.
    # So we are tricking this by importing the main header first, then all headers.
    header_basenames = (headers | public_headers).map { |x| x.sub(/#{headers_path}\/*/, '') } 
    if idx = header_basenames.index("#{name}.h")
      header_basenames.delete_at(idx)
      header_basenames.unshift("#{name}.h")
    end
    @import_directive = header_basenames.map { |x| "#import <#{name}/#{x}>" }.join("\n")
    @compiler_flags ||= "-F\"#{parent_path}\" -framework #{name}"
    @cpp_flags ||= ''
    @cpp_flags << "-F\"#{parent_path}\" "
    @headers.concat(headers)
    # Memorize the dependencies.
    @dependencies = BridgeSupportGenerator.dependencies_of_framework(path)
  end
 
  def framework_path(val)
    return val if File.exist?(val)
    val += '.framework' unless /\.framework$/.match(val)
    paths = ['/System/Library/Frameworks',
     '/Library/Frameworks',
     "#{ENV['HOME']}/Library/Frameworks"
    ]
    paths << '/System/Library/PrivateFrameworks' if @private
    paths.each do |dir|
      path = File.join(dir, val)
      return path if File.exist?(path)
    end
    return nil
  end

  def unique_tmp_path(base, extension='', dir=Dir.tmpdir)
    i = 0
    loop do
      p = File.join(dir, "#{base}-#{i}-#{Process.pid}" + extension)
      return p unless File.exist?(p)
      i += 1
    end
  end

  def compile_and_execute_code(code, cleanup_when_fail=false, emulate_ppc=false)
    tmp_src = File.open(unique_tmp_path('src', '.m'), 'w')
    tmp_src.puts code
    tmp_src.close

    tmp_bin_path = unique_tmp_path('bin')
    tmp_log_path = unique_tmp_path('log')

    arch_flag =     
      if @enable_64
        " -arch #{IS_PPC ? 'ppc64' : 'x86_64'}"
      elsif emulate_ppc
        ' -arch ppc -arch i386'
      else
        '' # nothing, by default the compiler choose the 32-bit arch
      end

    line = "#{GCC} #{arch_flag} #{tmp_src.path} -o #{tmp_bin_path} #{@compiler_flags} 2>#{tmp_log_path}"
    unless system(line)
      msg = "Can't compile C code... aborting\ncommand was: #{line}\n\n#{File.read(tmp_log_path)}"
      $stderr.puts "Code was:\n<<<<<<<\n#{code}>>>>>>>\n" if $DEBUG
      File.unlink(tmp_log_path)
      File.unlink(tmp_src.path) if cleanup_when_fail
      raise msg
    end
    
    env = ''
#    if @framework_paths
#      env << "DYLD_FRAMEWORK_PATH=\"#{@framework_paths.join(':')}\""
#    end
    env = 'DYLD_ROOT_PATH=/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator2.0.sdk'

    fn = unique_tmp_path('shell','.sh')
    File.open(fn, 'w') do |f|
#      f.puts 'export DYLD_ROOT_PATH=/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator2.0.sdk'
#      f.puts tmp_bin_path
      f.puts "#{env} #{tmp_bin_path}"
    end

#    line = "#{env} #{tmp_bin_path}"
#    out = `#{line}`
    line = "sh #{fn}"
    out = `#{line}`
    unless $?.success?
      p out
      raise "Can't execute compiled C code... aborting\nline was: #{line}\n"#binary is #{tmp_bin_path}"
    end


    if emulate_ppc
      line = "#{env} /usr/libexec/oah/translate #{tmp_bin_path}"
      out = [out]
      out <<  `#{line}`
      unless $?.success?
        raise "Can't execute compiled C code under PPC mode... aborting\nline was: #{line}\nbinary is #{tmp_bin_path}"
      end
    end

    File.unlink(tmp_log_path)
    File.unlink(tmp_src.path)
    File.unlink(tmp_bin_path)

    return out
  end

  def generate_precompiled_header
    return if @import_directive.nil? or @compiler_flags.nil?
    return unless @pch_files.nil?

    tmp_header = File.open(unique_tmp_path('src', '.h'), 'w')
    tmp_header.puts @import_directive
    tmp_header.close

    tmp_log_path = unique_tmp_path('log')
    tmp_pch_path = "#{tmp_header.path}.gch"

    line = "#{GCC} -c -x objective-c-header #{tmp_header.path} -o #{tmp_pch_path} #{@compiler_flags} 2>#{tmp_log_path}"
    unless system(line)
      msg = "Can't precompile header... aborting\ncommand was: #{line}\n\n#{File.read(tmp_log_path)}"
      File.unlink(tmp_log_path)
      File.unlink(tmp_header.path)
      raise msg
    end
    @pch_files = [ tmp_pch_path, tmp_header.path ]

    @import_directive_before_pch = @import_directive
    @compiler_flags_before_pch = @compiler_flags
    @import_directive = ""
    @compiler_flags << " -include #{tmp_header.path} "

    File.unlink(tmp_log_path)
  end
  
  def delete_precompiled_header
    return unless @pch_files
    @pch_files.each { |filepath| File.unlink(filepath) }
    @import_directive = @import_directive_before_pch if @import_directive_before_pch
    @compiler_flags = @compiler_flags_before_pch if @compiler_flags_before_pch
    @pch_files = nil
  end
end

def die(*msg)
  $stderr.puts msg
  exit 1
end


if __FILE__ == $0
  require 'pp'
  path = "/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS2.0.sdk/System/Library/Frameworks/UIKit.framework/Headers/UITableView.h"
  analyzer = OCHeaderAnalyzer.path(path)#, !@private, @enable_64, @cpp_flags)
#  pp analyzer.functions
#  pp analyzer.functions(true)
#  pp analyzer.constants
#  pp analyzer.enums
#  pp analyzer.defines
#  pp analyzer.informal_protocols
#  pp analyzer.function_pointer_types
  pp analyzer.typedefs
#  pp analyzer.ocmethods 
end


__END__

if __FILE__ == $0
  g = BridgeSupportGenerator.new
  OptionParser.new do |opts|
    opts.banner = "Usage: #{File.basename(__FILE__)} [options] <headers...>"
    opts.separator ''
    opts.separator 'Options:'

    opts.on('-f', '--framework FRAMEWORK', 'Generate metadata for the given framework.') do |opt|
      g.frameworks << opt
    end

    opts.on('-p', '--private', 'Support private frameworks headers.') do 
      g.private = true
    end

    formats = BridgeSupportGenerator::FORMATS
    opts.on('-F', '--format FORMAT', formats, {}, "Select metadata format.") do |opt|
      g.generate_format = opt
    end

    opts.on('-e', '--exception EXCEPTION', 'Use the given exception file.') do |opt|
      g.exception_paths << opt
    end

    enable_64 = false
    opts.on(nil, '--64-bit', 'Write 64-bit annotations.') do
      enable_64 = true
    end

    opts.on('-c', '--cflags FLAGS', 'Specify custom compiler flags.') do |flags|
      g.compiler_flags ||= ''
      g.compiler_flags << ' ' + flags + ' '
    end

    compiler_flags_64 = nil
    opts.on('-C', '--cflags-64 FLAGS', 'Specify custom 64-bit compiler flags.') do |flags|
      compiler_flags_64 ||= ''
      compiler_flags_64 << ' ' + flags + ' '
    end

    opts.on('-o', '--output FILE', 'Write output to the given file.') do |opt|
      die 'Output file can\'t be specified more than once' if @out_file
      g.out_file = opt
    end

    help_msg = "Use the `-h' flag or consult gen_bridge_metadata(1) for help."
    opts.on('-h', '--help', 'Show this message.') do
      puts opts, help_msg
      exit
    end

    opts.on('-d', '--debug', 'Turn on debugging messages.') do
      $DEBUG = true
    end

    opts.on('-v', '--version', 'Show version.') do
      puts BridgeSupportGenerator::VERSION
      exit
    end

    opts.separator ''

    if ARGV.empty?
      die opts.banner
    else
      begin
        opts.parse!(ARGV)
        ARGV.each { |header| g.add_header(header) }
        g.collect
        if enable_64
          g2 = g.duplicate
          g2.enable_64 = true
          if compiler_flags_64 != g.compiler_flags
            g2.compiler_flags = compiler_flags_64
          end
          g2.collect
          g.merge_64_metadata(g2)
        end
        g.write
        g.cleanup
      rescue => e
        msg = e.message
        msg = 'Internal error' if msg.empty?
        if $DEBUG
          $stderr.puts "Received exception: #{e}:"
          $stderr.puts e.backtrace.join("\n")
        end
        die msg, opts.banner, help_msg
      end
    end
  end
end
