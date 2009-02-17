# -*-rd-*-
= Try RubyCocoa Samples

Let's try scripts and applications of samples.

== RubyCocoa Application

First, try to execute a RubyCocoa application which has already
been built. In Finder, open '/Developer/Examples/RubyCocoa' folder and
double-click SimpleApp.  Or type following on command line:

  % cd /Developer/Examples/RubyCocoa
  % open SimpleApp.app


== on command line (Terminal)

You can write a script for command line with RubyCocoa.  Now, let's
try to execute a simple script in sample directory.

  % cd /Developer/Examples/RubyCocoa
  % ruby fontnames.rb # fontname print to stdout.
  % ruby sndplay.rb   # system sounds play in order.
  % ruby sndplay2.rb  # system sounds play in order with short interval.

For Mac OS X 10.2 users, furthermore:

  % echo Hello World | ruby speak.rb
  % head -5 speak_me.txt | ruby speak.rb

This will be interesting. When you execute speak.rb without arguments, the Mac
will read all the text you type until 'control-D' is input.  This script uses
the AppleScript (and AppleEvent) interface which has been implemented since Mac
OS X 10.2.

Next, try scripts with windowing.

  $ ruby HelloWorld.rb                       # window and buttons
  $ ruby TransparentHello.rb                 # transparency!
  $ (cd Hakoiri-Musume && ruby rb_main.rb )  # puzzle game


== Build a Makefile-based RubyCocoa application

The next example is Makefile-based. Type this to build: 

  % cd /Developer/Examples/RubyCocoa/Hakoiri-Musume
  % make

Now launch the application:

  % open CocoHako.app

or double-click 'CocoHako' in the Finder. 


== Build a Project Builder-based RubyCocoa application

The next example is Project Builder-based. Type this to build it:

  % cd /Developer/Examples/RubyCocoa/simpleapp
  % pbxbuild
  % open build/SimpleApp.app

You can build and run the application in Project Builder, too. Launch the
application:


== Next...

There are various other samples. Please read and try them. Have fun!


== Supplement

* HelloWorld.rb is a sample script for ((<PyObjc|URL:http://pyobjc.sf.net/>))
  that was translated from Python into Ruby.

* TransparentHello.rb appears in the article of
  ((<'Dr. Dobbs Journal, May 2002'|URL:http://www.ddj.com/articles/2002/0205/>))
  written by Chris Thomas.

* RubyRaiseMan and RubyTypingTutor is a tutorial application in
  ((<'Mac OS X Cocoa Programming'|URL:http://www.amazon.com/exec/obidos/tg/detail/-/0201726831>))
  that was translated from Objective-C into Ruby.

* MyViewer is a sample in Japanese book
  ((<'Guide of Mac OS X Programming - Objective-C'|URL:http://www.amazon.co.jp/exec/obidos/ASIN/4877780688>))
  that was translated from Objective-C into Ruby.


$Date: 2004-12-03 21:26:03 +0900 (金, 03 12 2004) $
