#
#  $Id: gen_dummy_handler.rb 450 2002-12-12 07:05:17Z hisa $
#
#  Copyright (c) 2001 FUJIMOTO Hisakuni <hisa@imasy.or.jp>
#
#  This program is free software.
#  You can distribute/modify this program under the terms of
#  the GNU Lesser General Public License version 2.
#

if `uname -r`.to_f >= 6.0 then
  require '../../../tool/och_analyzer3'
else
  require '../../../tool/och_analyzer'
end

def collect_src_headers(src_path, re_pat)
  File.open(src_path) {|f|
    f.map {|s|
      if m = re_pat.match(s) then
	      path = File.join(File.dirname(src_path), m[1])
	      if FileTest.file?(path)
	        path
	      else
	        nil
        end
      end
    }.compact.uniq
  }
end

def collect_appkit_headers
  path = "/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS2.0.sdk/System/Library/Frameworks/UIKit.framework/Headers/UIKit.h"
  re = %r{^\s*#import\s*<UIKit/(\w+\.h)>}
  collect_src_headers(path, re)
end

def collect_foundation_headers
  path = '/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS2.0.sdk/System/Library/Frameworks/Foundation.framework/Headers/Foundation.h'
  re = %r{^\s*#import\s*<Foundation/(\w+\.h)>}
  collect_src_headers(path, re)
end

def gen_impl(type)
  case type
  when 'void' then ""
  when 'BOOL' then "return NO;"
  when /^(id|Class)$/ then "return nil;"
  when 'NSRect' then "NSRect r = {{0.0,0.0},{0.0,0.0}}; return r;"
  when 'NSPoint' then "NSPoint r = {0.0,0.0}; return r;"
  when 'NSSize' then "NSSize r = {0.0,0.0}; return r;"
  when 'NSDecimal' then "NSDecimal r = {0,0,0,0,0,{0}}; return r;"
  when 'NSRange' then "NSRange r = {0,0}; return r;"
  when /\*$/ then "return nil;"
  else "return (#{type})0;"
  end
end

def proto_ignore?(proto)
  proto.base != 'NSObject'
end

def main
  headers = collect_foundation_headers + collect_appkit_headers
  selector_dic = Hash.new
  
  headers.each do |hpath|
    och = OCHeaderAnalyzer.new(hpath)
    protos = och.informal_protocols
    if protos.size > 0 then
      puts "/**** #{och.filename} ****/"
      protos.each do |proto|
	next if proto_ignore?(proto)
	puts "// #{proto.orig}"
	proto.entries.each do |i|
	  if selector_dic[i.selector] then
	    puts "// #{i.orig};"
	  else
	    puts "#{i.orig} { #{gen_impl(i.type)} }"
	    selector_dic[i.selector] = true
	  end
	end
	puts
      end
    end
  end
end

if __FILE__ == $0 then
  main
end
