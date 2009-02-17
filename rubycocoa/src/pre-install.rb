install_root = @config['install-root']

# If required, backup files create here.
backup_dir = '/tmp/rubycocoa_backup'

# Install ProjectBuilder Templates 
pbextras_dir = 
  @config['projectbuilder-extras'] ?
    File.expand_path("#{install_root}#{@config['projectbuilder-extras']}") : nil
xcodeextras_dir = 
  @config['xcode-extras'] ?
    File.expand_path("#{install_root}#{@config['xcode-extras']}") : nil
pbtmpldir = "template/ProjectBuilder"

[pbextras_dir, xcodeextras_dir].compact.each do |extras_dir|
  [
    [ "#{pbtmpldir}/File",
      "#{extras_dir}/File Templates/Ruby" ],

    [ "#{pbtmpldir}/Application/Cocoa-Ruby Application",
      "#{extras_dir}/Project Templates/Application/Cocoa-Ruby Application" ],

    [ "#{pbtmpldir}/Application/Cocoa-Ruby Document-based Application",
      "#{extras_dir}/Project Templates/Application/Cocoa-Ruby Document-based Application" ],

    [ "#{pbtmpldir}/Application/Cocoa-Ruby Core Data Application",
      "#{extras_dir}/Project Templates/Application/Cocoa-Ruby Core Data Application" ],

    [ "#{pbtmpldir}/Application/Cocoa-Ruby Core Data Document-based Application",
      "#{extras_dir}/Project Templates/Application/Cocoa-Ruby Core Data Document-based Application" ],

  ].each do |srcdir, dstdir|
    if FileTest.exist?( dstdir ) then
      backupname = File.basename( dstdir )
      command "rm -rf '#{backup_dir}/#{backupname}'"
      command "mkdir -p '#{backup_dir}'"
      command "mv '#{dstdir}' '#{backup_dir}/'"
    end
    command "mkdir -p '#{File.dirname(dstdir)}'"
    command "cp -R '#{srcdir}' '#{dstdir}'"
  end
end

# Install Examples & Document
[
  [ 'sample', "#{install_root}#{@config['examples']}", 'g+w' ],
  [ 'doc',    "#{install_root}#{@config['documentation']}", nil ],

].each do |srcdir, dstdir, chmod|
  if File.exist?( "#{dstdir}/RubyCocoa" ) then
    command "rm -rf '#{backup_dir}/#{srcdir}'"
    command "mkdir -p '#{backup_dir}'"
    command "mv '#{dstdir}/RubyCocoa' '#{backup_dir}/#{srcdir}'"
  end
  command "mkdir -p '#{dstdir}'"
  command "cp -R '#{srcdir}' '#{dstdir}/RubyCocoa'"
  command "chmod -R #{chmod} '#{dstdir}/RubyCocoa'" if chmod
end
