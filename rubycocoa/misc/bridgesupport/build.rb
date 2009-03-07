require 'gen_bridge_metadata'
require 'pathname'
require 'fileutils'

include FileUtils

SLF = '/System/Library/Frameworks'
SLPF = '/System/Library/PrivateFrameworks'

frameworks = {}
%w{
  CoreFoundation
  Foundation
  AppKit
  CoreData
  WebKit
  AddressBook
  InstantMessage
  QuartzCore
  SyncServices
  OpenGL
  QTKit
  Cocoa
  Quartz
  ApplicationServices
}.each { |n| frameworks[n] = "#{SLF}/#{n}.framework" }

frameworks['CoreGraphics'] = "#{SLF}/ApplicationServices.framework/Frameworks/CoreGraphics.framework"
frameworks['ImageIO'] = "#{SLF}/ApplicationServices.framework/Frameworks/ImageIO.framework"
frameworks['PDFKit'] = "#{SLF}/Quartz.framework/Frameworks/PDFKit.framework"
frameworks['QuartzComposer'] = "#{SLF}/Quartz.framework/Frameworks/QuartzComposer.framework"

special_flags_32 = {
}

special_flags = {
  'AppKit' => '-include /System/Library/Frameworks/QuickTime.framework/Headers/Movies.h -framework ApplicationServices',

  'CoreGraphics' => '-framework ApplicationServices -F/System/Library/Frameworks/ApplicationServices.framework/Frameworks -include /System/Library/Frameworks/OpenGL.framework/Headers/CGLTypes.h',

  'ImageIO' => '-framework ApplicationServices -F/System/Library/Frameworks/ApplicationServices.framework/Frameworks',

  'QuartzCore' => '-framework QuartzCore -include /System/Library/Frameworks/OpenGL.framework/Headers/CGLTypes.h'
}

frameworks.delete_if { |fname, path| !ARGV.include?(fname) } unless ARGV.empty?

def measure(something)
  elapsed = Time.now
  yield
  $stderr.puts "    #{something} (#{Time.now - elapsed} seconds)"
end

unless out_dir = ENV['BSROOT']
  out_dir = '/Library/BridgeSupport'
  if dstroot = (ENV['DSTROOT'] or '')
    out_dir = File.join(dstroot, out_dir)
  end
end
mkdir_p(out_dir)

frameworks.sort { |ary, ary2|
  # Sort the frameworks by dependency order, using a naive-but-working algorithm.
  deps = [ary, ary2].map { |a|
    BridgeSupportGenerator.dependencies_of_framework(a[1]).map { |fpath|
      BridgeSupportGenerator.dependencies_of_framework(fpath)
    }.flatten
  }
  len1 = deps[0].reject { |x| deps[1].include?(x) }.length
  len2 = deps[1].reject { |x| deps[0].include?(x) }.length
  len1 <=> len2
}.each do |fname, path|
  # Check if the bridge support file isn't already in the DSTROOT. 
  exceptions = "exceptions/#{fname}.xml"
  out_file = File.join(out_dir, "#{fname}.bridgesupport")
  if File.exist?(out_file) and File.size(out_file) > 0
    out_file_mtime = File.mtime(out_file)
    if File.mtime(__FILE__) < out_file_mtime 
      next if !File.exist?(exceptions) \
        or File.mtime(exceptions) < out_file_mtime
    end
  end

  # We have work!
  $stderr.puts "Generating BridgeSupport metadata for: #{fname} ..."
  elapsed = Time.now
  
  # Create a new generator object, configure it accordingly for a first 32-bit pass.
  gen = BridgeSupportGenerator.new
  gen.frameworks << path

  if File.exist?(exceptions)
    gen.exception_paths << exceptions
  end

  if flags = (special_flags_32[fname] or special_flags[fname])
    gen.compiler_flags = flags 
  end

  # Collect 32-bit metadata.
  measure('Collect metadata') { gen.collect }

  # Merge both metadata in the first generator object, and write it.
  measure('Write final metadata') do
    gen.out_file = out_file
    gen.write
  end

  # Validate.
  measure('Validate XML') do
    unless system("xmllint --dtdvalid ./BridgeSupport.dtd --nowarning --noout \"#{out_file}\"")
      $stderr.puts "Error: `#{out_file}' doesn't validate against BridgeSupport.dtd"
      exit 1
    end
  end

  # Generate inline dynamic library if required.
  if gen.has_inline_functions?
    measure('Generate dylib file') do
      gen.generate_format = BridgeSupportGenerator::FORMAT_DYLIB
      gen.out_file = "#{out_dir}/#{fname}.dylib"
      gen.write
    end
  end
  gen.cleanup

  $stderr.puts "Done (#{Time.now - elapsed} seconds)."
end
