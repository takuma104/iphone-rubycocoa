# create appkit.rb and foundation.rb
load 'tool/create-appkit-and-foundation.rb'
GC.start

# create osx_ruby.h and osx_intern.h
# avoid `ID' and `T_DATA' confict headers between Cocoa and Ruby.
new_filename_prefix = 'osx_'
ruby_h = "#{Config::CONFIG['archdir']}/ruby.h"
intern_h = "#{Config::CONFIG['archdir']}/intern.h"
[ ruby_h, intern_h ].each do |src_path|
  dst_fname = new_filename_prefix + File.basename(src_path)
  dst_fname = "src/objc/" + dst_fname
  $stderr.puts "create #{File.expand_path(dst_fname)} ..."
  File.open(dst_fname, 'w') do |dstfile|
    IO.foreach(src_path) do |line|
      line.gsub!( /\b(ID|T_DATA)\b/, 'RB_\1' )
      line.gsub!( /\bintern\.h\b/, "#{new_filename_prefix}intern.h" )
      dstfile.puts( line )
    end
  end
end

curdir = Dir.pwd
Dir.chdir('src/objc/cocoa')
command 'ruby gen_cocoa_wrapper.rb'
Dir.chdir(curdir)
