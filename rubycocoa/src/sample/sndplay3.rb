require 'osx/cocoa'

INTERVAL = 0.1

snd_files =
  if ARGV.size == 0 then
    `ls /System/Library/Sounds/*.aiff`.split
  else
    ARGV
  end

OSX.ruby_thread_switcher_start(0.001, 0.1)
Thread.start { OSX::NSRunLoop.currentRunLoop.run }

thr = nil

snd_files.each do |path|
  thr = Thread.start do
    snd = OSX::NSSound.alloc.initWithContentsOfFile(path,:byReference,true)
    snd.play
    sleep 1 while snd.isPlaying?
  end
  sleep INTERVAL
end

thr.join
