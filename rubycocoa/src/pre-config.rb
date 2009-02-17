# create a real project.pbxproj file by applying libruby
# configuration.

target_files = %w[
  ext/rubycocoa/extconf.rb
  ext/rubycocoa/rubycocoa.m
  framework/RubyCocoa.pbproj/project.pbxproj
  framework/src/objc/RBObject.h
  framework/src/objc/RBSlaveObject.h
  framework/src/objc/RubyCocoa.h
  framework/src/objc/Version.h
]

config_ary = [
  [ :frameworks,      @config['frameworks'] ],
  [ :framework_name,  @config['framework-name'] ],
  [ :ruby_header_dir, @config['ruby-header-dir'] ],
  [ :libruby_path,    @config['libruby-path'] ],
  [ :libruby_path_dirname,  File.dirname(@config['libruby-path']) ],
  [ :libruby_path_basename, File.basename(@config['libruby-path']) ],
  [ :rubycocoa_version,      @config['rubycocoa-version'] ],
  [ :rubycocoa_release_date, @config['rubycocoa-release-date'] ],
  [ :build_dir, framework_obj_path ],
]

target_files.each do |dst_name|
  src_name = dst_name + '.in'
  data = File.open(src_name) {|f| f.read }
  config_ary.each do |sym, str|
    data.gsub!( "%%%#{sym}%%%", str )
  end
  File.open(dst_name,"w") {|f| f.write(data) }
  $stderr.puts "create #{dst_name}"
end
