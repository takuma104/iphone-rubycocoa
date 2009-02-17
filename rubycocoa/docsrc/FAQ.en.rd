# -*-rd-*-
= RubyCocoa FAQ

== Installation

=== Q: Installation failed when downloading and installing RubyCocoa in the
folder "dl file."

==== A: It seems that an error will occur when invoking 'ruby install.rb
config' if it is installed into a directory whose name contains a space.
Especially those who have only used Macintosh until now should be careful.

== After Installation

=== Q: I tried to execute a sample script, but I received the error:

  % ruby fontnames.rb
  dyld: ruby Undefined symbols:
  _init_NSDistributedNotificationCenter
  _init_NSScriptStandardSuiteCommands

==== A: Did you use StuffIt to extract the tgz file of RubyCocoa ?

When using StuffIt, long file names in excess of 31 characters are truncated.
Building RubyCocoa with truncated filenames will fail. You must use
the "tar" command in the shell (Terminal application) when extracting
the tgz file:

  % tar zxf rubycocoa-0.1.0.tgz

And reinstall RubyCocoa.

(thanks Shimura-san)


== Misc.

=== Q: How can I use ABAddressBook class ? (2002-09-30)

==== A:

By default, any class which isn't contained in Foundation or AppKit is
not imported. For using such a class, load a appropriate framework with
OSX_NSBundle and import a class with OSX_ns_import.

For AddressBook.framework, you can use it in RubyCocoa 0.3.2 or later
as following:

  require 'osx/cocoa'
  require 'osx/addressbook'
  abook = OSX::ABAddressBook.sharedAddressBook

You can use it in older RubyCocoa as follows:

  require 'osx/cocoa'
  OSX::NSBundle.bundleWithPath("/System/Library/Frameworks/AddressBook.framework").load
  OSX.ns_import :ABAddressBook
  abook = OSX::ABAddressBook.sharedAddressBook

(thanks tosh-san)


== obsolete FAQ (2002-12-23)

=== Q: I see a warning on the console when running a RubyCocoa application.

When running a Cocoa application, sometimes a warning message about 
memory allocation appears on the Console: 

  malloc[2461]: Deallocation of a pointer not malloced: 0x2718b20;
  This could be a double free(), or free() called with the middle of
  an allocated block; Try setting environment variable MallocHelp to
  see tools to help debug

==== A: Its cause is unknown and is unsolved at this time. (2002-01-08)

Although I thought that this problem was solved in version 0.1.2, it
still occurs.  If there is information which you think is likely to be
helpful in tracking down this problem, such as "I can always cause it
by performing these steps", please email me with your configuration,
what I must do to reproduce the error and, if possible, the script you
were running when it happend.


=== Q: Threads do not seem to work properly.

==== A: Are you using release 0.2.1 or later ?

RubyCocoa release 0.2.1 or later supports Ruby threads. To use a Ruby
thread in an application with an older release of RubyCocoa, change
"ns_app_main" in the file "rb_main.rb" as follows:

  def ns_app_main
    OSX.ruby_thread_switcher_start (0.05)  # switching interval sec
    app = OSX::NSApplication.sharedApplication
    OSX::NSBundle.loadNibNamed_owner (BUNDLE_NAME.to_s, app)
    OSX.NSApp.run
  end


=== Q: I launched SimpleApp1, which results in the message "SimpleApp1 closed unexpectedly."

I am having problems getting RubyCocoa working. I built and installed
ruby-1.6.5 and RubyCocoa-0.1.2 with no problems.

Following the instructions on:
<http://www.fobj.com/rubycocoa/doc/install.en.html> I encountered
an error when i tried executing: "open SimpleApp1.app", which results in
an "SimpleApp1 closed unexpectedly." The error it quits with is:

  bash-2.05# ./SimpleApp1.app/Contents/MacOS/SimpleApp1
  dyld: ./SimpleApp1.app/Contents/MacOS/SimpleApp1 Undefined symbols:
  _dlclose
  _dlerror
  _dlopen
  _dlsym

I run into the same error trying to build the other examples.
fontnames.rb and sndplay?.rb worked with no problems.  What is causing
this?


==== A: Have you installed any unix-tools packages ?

I am guessing a dyld library is installed by some unix-tool package in
your MacOS X system. This problem seems to occur when the old
EasyPackage is installed on the system.

If my guess is right, two solutions exist. The first is to remove the
dyld library named 'libdl*.bundle' in '/usr/local/lib'. The second is
setting "-ldl" as a linker option in each PB project or Makefile.

The first way may produce unwanted side effects in other installed
commands. The second way is time-consuming.

You can use 'otool -L' command for printing shared library names that
are required by a RubyCocoa application binary.

The thread
((<[ruby-talk:29708]|URL:http://www.ruby-talk.com/cgi-bin/scat.rb/ruby/ruby-talk/29708>))
also has some references to this problem.


=== Q: I want to select a RubyCocoa application template in PB.

I want to select a RubyCocoa application template in the
ProjectBuilder new Project menu.

==== A: Create a subdirectory of  "/Developer/ProjectBuilder Extras" named
"RubyCocoa Application", and copy the subdirectories of "template" whose names
start with "tmpl_pb_" into it.

  % cd "/Developer/ProjectBuilder Extras/Project Templates/Application"
  % cp -R {rubycocoa srcdir}/template/tmpl_pb_RubyCocoaApp "RubyCocoa Application"
  % cp -R {rubycocoa srcdir}/template/tmpl_pb_RubyCocoaDocApp "RubyCocoa Doc Application"
  % cd "../../File Templates"
  % cp -R {rubycocoa srcdir}/template/tmpl_pb_RubyFiles Ruby

(thanks Shimura-san)

$Date: 2004-06-28 14:19:05 +0900 (月, 28  6 2004) $
$Revision: 693 $
