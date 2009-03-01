#!/usr/bin/env ruby -wKU
require 'rubycocoa'

module AppUtils
  class Untar
    def initialize(file, root_directory)
      @root = root_directory
      @f = file
      loop do
        name, size = read_header
        break if name.nil? or name.length == 0
        if name =~ /.*\/$/
          create_directory(name)
        else
          save_file(name, size)
        end
      end
    end

  private
    def read_header
      name = @f.read(100).unpack('A*')[0]
      @f.seek(8*3, IO::SEEK_CUR)
      size = @f.read(12).unpack('A*')[0].oct
      @f.seek(512-100-8*3-12, IO::SEEK_CUR)
      [name, size]
    end

    def create_directory(name)
      fn = File.join(@root, name)
      p fn
      begin
        Dir.mkdir(fn)
      rescue 
      end
    end

    def save_file(name, size)
      fn = File.join(@root, name)
      p fn
      File.open(fn, 'w') {|f| f.write(@f.read(size)) }
  #    @f.seek(size, IO::SEEK_CUR)
      m = size % 512
      if m != 0
        @f.seek(512-m, IO::SEEK_CUR)
      end
    end
  end

  def AppUtils.untar_resource(tar_name, to)
  	lib = File.join(OSX.NSHomeDirectory.to_s, to)
  	unless FileTest.exist?(lib)
  		Dir.mkdir(lib)
  		tar = OSX::NSBundle.mainBundle.pathForResource_ofType(tar_name, "tar").to_s
  		File.open(tar) do |f|
  			Untar.new(f, lib)
  		end
  	end
  	lib
  end
  
  def AppUtils.load_rubylibs
    lib = AppUtils.untar_resource('rubylib', 'Library/Ruby/')
    lib = File.join(lib, 'lib/')
    $: << lib
  end

end