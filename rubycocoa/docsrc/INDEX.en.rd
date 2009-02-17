# -*-rd-*-

== What is RubyCocoa ?

RubyCocoa is a framework for ((<Mac OS X|URL:http://www.apple.com/macosx/>))
that allows ((<Cocoa|URL:http://developer.apple.com/cocoa/>)) programming
in the object-oriented scripting language ((<Ruby|URL:http://www.ruby-lang.org/>)).

RubyCocoa lets you write a Cocoa application in Ruby. It allows you to create
and use a Cocoa object in a Ruby script. It's possible to write a
Cocoa application that mixes Ruby and Objective-C code.

Some useful applications of RubyCocoa:

  * Exploration of a Cocoa object's features with (({irb})) interactively
  * Prototyping of a Cocoa application
  * Writing a Cocoa application that combines good features of Ruby and Objective-C
  * Wrapping Mac OS X's native GUI for a Ruby script


== Screenshot

The following screenshot is of a RubyCocoa application which consists of only
Ruby scripts and a nib file created in Mac OS X's Interface Builder.
<<< img_simpleapp


== Script Examples

The next script plays all the system sounds.

  require 'osx/cocoa'
  snd_files =`ls /System/Library/Sounds/*.aiff`.split
  snd_files.each do |path|
    snd = OSX::NSSound.alloc.
      initWithContentsOfFile_byReference (path, true)
    snd.play
    sleep 0.5
  end

The following examples are scripts that read a text aloud.
(for OS X 10.2 or later)

  require 'osx/cocoa'
  include OSX
  def speak (str)
    str.gsub! (/"/, '\"')
    src = %(say "#{str}")
    NSAppleScript.alloc.initWithSource(src).executeAndReturnError(nil)
  end
  speak "Hello World!"
  speak "Kon nich Wah. Ogan key desu ka?" # "Hi. How are you." in Japanese

The next script is a class definition that connects to a nib file created in
Interface Builder.

  require 'osx/cocoa'

  class AppCtrl < OSX::NSObject

    ib_outlets :monthField, :dayField, :mulField

    def awakeFromNib
      @monthField.setIntValue  Time.now.month
      @dayField.setIntValue Time.now.day
      convert
    end

    def convert (sender = nil)
      val = @monthField.intValue * @dayField.intValue
      @mulField.setIntValue (val)
      @monthField.selectText (self)
    end

    def windowShouldClose (sender = nil)
      OSX.NSApp.stop (self)
      true
    end

  end


== LICENSE

((<GNU Lesser General Public License version 2. LGPL
|URL:http://www.gnu.org/licenses/lgpl.html>))


== ACKNOWLEDGEMENT

Special thanks to Chris Thomas, Luc "lucsky" Heinrich and S. Sawada.

And thanks to:

Gesse Gam, Hiroyuki Shimura, John Platte, kimura wataru, Masaki Yatsu,
Masatoshi Seki, Michael Miller, Ogino Junya, Ralph Broom, Rich Kilmer,
Shirai Kaoru, Tetsuhumi Takaishi, Tosh, Matthew Fero, Rod Schmidt,
Jonathan Paisley, Norberto Ortigoza


== Contact

Feel free to send comments, icon designs, bug reports and patches for
RubyCocoa. I want to ask kind native English speakers to correct my strange
English errors. Thanks.

An author looks for a job (an income source).  Is there a supporter
(sponsor, investor, etc.) with interest in the development of RubyCocoa or
other software?

Contact ((<me|URL:mailto:contact.rubycocoa@fobj.com>)) freely please.


FUJIMOTO, Hisakuni <hisa at fobj.com> $Date: 2005-10-28 20:03:05 +0900 (金, 28 10 2005) $
