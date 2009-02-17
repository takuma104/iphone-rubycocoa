# -*-rd-*-
= Changes

== changes from 0.4.1 (0.4.2)

=== new features

: CocoaBindings support

  on Mac OS X 10.3 or later, CocoaBindings is avalable for a subclass of 
  Cocoa class defined in a ruby script.

  see samples CurrencyConverter and RubySpotlight.

: CoreData support

  on Mac OS X 10.4, CoreData classes and constants are avalable with 
  osx/coredata.rb.

: ease to build test

  after `ruby install.rb setup', test script runs with following command:

    % ruby install.rb test

=== bug fixes

: a ruby object becomes an instance of OSX::OCObject

  A ruby object becomes an instance of OSX::OCObject when the ruby object is 
  passed from a Cocoa object.

  for example:

    obj = RubyClass.new
    nsary = OSX::NSArray.arrayWithObjects(obj, nil)
    nsary.objectAtIndex(0) # => a instance of OSX::OCObject(not RubyClass)

: itunes_albums.rb fails with NSCharacterConversionException

  itunes_albums.rb crashes with following error.

    Uncaught exception: 
    <NSCharacterConversionException> Conversion to encoding ...

  new version of RubyCocoa converts a ruby string to NSString with encoding 
  from $KCODE.
  

: a ruby script with sub-subclass of a Cocoa class crashes

  for example:

    class A < OSX::NSObject
    end

    class B < A
    end

    b = B.alloc.init # => crash

== changes from 0.4.0 (0.4.1)

: Fix LoadError on running ruby script

  Fix following error, it occurs when ruby build without --enable-shared option.

    osx/cocoa.rb:12:in `require': No such file to load -- osx/objc/cocoa (LoadError)

: Mac OS X 10.3 and Xcode support

  change some install process to build on Mac OS X 10.3(Panther).
  install Xcode templates for RubyCocoa.

== changes from 0.4.0 (0.4.1d9)

: ruby 1.8.0 support

  Fix some warning and errors that came to go with ruby 1.8.0.

== changes from 0.4.0 (0.4.1d8)

: enable bundling RubyCocoa.framework within an application bundle

  Change a build configration of RubyCocoa.framework project, to
  execute a RubyCocoa application on the environment which is not
  installed RubyCocoa. It allows that RubyCocoa application itself
  bundles with RubyCocoa.framework.

: Support WebKit.framework

  add a library for WebKit.framework written by kimura wataru. ((-
  Thanks to kimura wataru and s.sawada -))

: Fix a bug about "init" method and ns_override

  It is fixed an exception is raised when "super_init" is invoked in
  definition of method "init" as ns_override.

: misc

  define module RCDataAttachment. define some class methods for class
  NSData and NSStrng.

== changes from 0.3.2 (0.4.0)

: support Ruby 1.8

  RubyCocoa supports Ruby 1.8. It has been fixed such that there are
  no warning messages with '-w' option.

: revived RubyCocoa.framework

  All of the basic implementation of RubyCocoa is included in RubyCocoa
  framework. It contains also code written with Ruby. Libruby itself
  is linked statically to RubyCocoa framework in the binary distribution.
  It would make you easy to distribute a RubyCocoa application.

: renamed extended library

  Name of the extended library was changed from 'osx_objc.bundle' into
  'rubycocoa.bundle'.
  This library has become a 'stub' extended library for using RubyCocoa
  framework from commands such as (({ruby})), (({irb})), etc.

: relocated some libraries

  All of the libraries included in the directory 'osx/objc' were moved inside
  the RubyCocoa framework.
  In addition, the libraries included in the 'osx' directory have become a
  'stub' library for using RubyCocoa framework from commands such as
  (({ruby})), (({irb})), etc.


== changes from 0.3.1 (0.3.2)

=== added library for AddressBook.framework

e.g.:

  require 'osx/addressbook'
  ab = OSX::ABAddressBook.sharedAddressBook
  ab.people.to_a.each {|i| puts i.compositeName.to_s }


== changes from 0.3.0 (0.3.1)

=== [IMPROVE] reflection facility for an Objective-C object

defined OCObjWrapper#objc_methods, OCObjWrapper#objc_method_type.

=== [IMPROVE] exception message

A message of exception which is related with method invocation of
Objective-C object contains method or function name.

Raise OSX::OCException when NSException occurred in NS-function call.

=== [BUGFIX] unexpected garbage collection

Fix a bug that a Ruby object which was instantiated in a NIB file may
be removed by GC.

=== [CHANGE] ruby thread switching

Start thread switching when load of osx_objc.bundle
(ruby_thread_switcher_start). This facility is implemented using
NSTimer, so thread switching doesn't work while NSRunLoop doesn't run.

=== [CHANGE] rb_main.rb

Loaded all ".rb" file in bundle resource. So it is not necessary to
modify rb_main.rb in RubyCocoa application development.


== Changes from 0.2.7

=== [IMPROVE] Now RubyAEOSA have become Jaguar (Mac OS X 10.2) aware!

* executable with only pre-installed Ruby 1.6.7 on Jaguar.
* buildable with only Developer Tools which is contained Jaguar.
* dispose LibRuby.framework
* dispose RubyCocoa.framework
* no need the Ruby configure option "--enabled-shared" any more.

(NOTE) Libruby.a is required to build document based application
working normally. Source distribution does not include the library.
Make the library by yourself from source of ruby. Or download
((<libruby.a.gz|URL:../rubyosx/files/libruby.a.gz>)).

=== [IMPROVE] improved NS-constans and NS-functions wrapper generator

script (using cpp3). Not implemented of NS-constants and NS-functions
decreased.

=== [IMPROVE] Implement to handle argument and return value of C pointer

* OSX::ObjcPtr - C pointer wrapper class
* Function/Method return an OSX::ObjcPtr instance as C pointer
* Use OSX::ObjcPtr or String as C pointer argument instead of C
  pointer argument

To use this feature, you should understand the meaning of accessing
memory space directly using C pointer. It's dangerous if not so.
There is the case which is not usable in a Ruby level virtually so
that the point that C pointer of return value shows is disturbed
already by NSAutoreleasePool#release.
(example - NSString#availableStringEncodings)

=== [IMPROVE] NSDictionary argument

available to use Hash when argument of function / method is a
NSDictionary.

=== misc topic about Jaguar

Bus Error occurred frequently when RubyCocoa is used with irb
formerly. Now it's considerably stable and usable.

It's seemed to get possible to execute GUI app in Jaguar from command
line without an application bundle.

  % cd {RubyCocoa sample}/Hokoiri-Musume
  % ruby rb_main.rb

This is enable. opened Hakoiri-Musume window and you can play the
game.


== Changes from 0.2.6

[IMPROVE] Mac OS X 10.2 support of NS functions and constants for
example NSAppleScript.

[CHANGES] Mac OS X 10.2 support of a sample using NSSound.

[BUGFIX] Solved the problem that cannot make instance of derived class
of Cocoa defined besides a TOP level:

  exp...
  module MyModule
    class AppController < OSX::NSObject
    end
  end

[BUGFIX] When string conversion with NSString, handle string which
included "\0" midway justly.

[CHANGES] raise OSX::OCDataConvException when data conversion failed
between Objective-C and Ruby.


== Changes from 0.2.5

[BUGFIX] fixed a bug that an override method which return BOOL is
wrong.

[IMPROVE] Improve auto generator script for Cocoa global functions and
variables. So "not implemented" functions and variables was
decreased. These of new supported include a series of
'NSGenericException' and 'NSUnionRange'.

[IMPROVE] added a ProjectBuilder template for Document-based
application.

[CHANGE] changed some directory names for ProjectBuilder templates.

[CHANGE] changed the behavior that argument type of Objective-C method
is Objective-C object for passing pure Ruby object as argument.

[IMPROVE] better sheet panel support. The callback method needs to
have the name end with "_returnCode_contextInfo."

[IMPROVE] define module functions for a localized string.

  OSX::NSLocalizedStringFromTableInBundle
  OSX::NSLocalizedStringFromTable
  OSX::NSLocalizedString

[IMPROVE] support invocation of a method that a selector name is start
with '_' such as "_transparency".

[IMPROVE] support version information.

  OSX::RUBYCOCOA_VERSION
  OSX::RUBYCOCOA_RELEASE_DATE


== Changes from 0.2.4

[BUGFIX] fix the bug which NSString.availableStringEncodings is
missing.

[BUGFIX] The bug which will down if the method which does not exist in
a super class is passed to the argument of ns_overrides was fixed.

[IMPROVE] support sheet panel of NSOpenPanel, NSSavePanel and
NSPrintPanel.

[CHANGE] added a new template PureEmptyApp.app. This removes the
contents about a NIB file from EmptyApp.app.


== Changes from 0.2.3

[BUGFIX] The bug about the treatment of the argument of a override
method is fixed. (thanks Chris-san)

[BUGFIX] The bug which returns ((|self|)) from the override method
fixed. The following codes came to move as expected:

  class MyView < OSX::NSView

    ns_overrides :initWithFrame_
    
    def initWithFrame (frame)
      suuper_initWithFrame (frame)
      self
    end


== Changes from 0.2.2

[BUGFIX] The bug which was destroying 4 bytes of memory at the time of
object instantiation is fixed. (thanks Chris-san)

[CHANGE] Ruby thread switching(OSX.ruby_thread_switcher_start)
improved.


== Changes from 0.2.1

[BUGFIX] fix serious bug of installing script. (thanks Rich-san)

[CHANGE] change the config option to specify the location of the
RubyCocoa framework as follows:

  % ruby install.rb config --frameworks=/Network/Library/Frameworks


== Changes from 0.2.0

[IMPROVE] implement the facility of Ruby thread switching in RubyCocoa
Application. (experimental implementation) (thanks Takaishi-san)

[IMPROVE] Implement the facility of super method invocation in
override method definition. (experimental implementation)

  def drawRect (frame)
    super_drawRect (frame)
  end

[BUGFIX] fix a bug of return-values from ns_override methods. (thanks
Chris-san)

[IMPROVE] add config option to specify the location of the RubyCocoa
framework.

  % ruby install.rb config -- --frameworks=/Network/Library/Frameworks


== Changes from 0.1.3

=== Spec/Implementation

[CHANGE] The role of OSX::OCObject became a stagehand.

[CHANGE] A Cocoa class is defined as a Ruby class.

  OSX::NSObject.is_a? Class # => true
  OSX::NSObject.name        # => "OSX::NSObject"

[CHANGE] OSX::OCObject#ib_loadable is obsolete. It changes so that the
definition of the inherited class of Cocoa may be applied by the same
method as the definition of the inherited class of Ruby.

  class Hoge < OSX::NSView
    ns_outlets   :hoge
    ns_overrides :drawRect_
    ...
  end

[CHANGE] Use of a symbol was enabled at the argument of
"COCOA_CLASS#ns_overrides". However, the abbreviation of "_"
corresponding to an argument cannot be performed (drawRect of the
above-mentioned example).

[CHANGE] add an OSX::ObjcID class, an OSX::OCObjWrapper module as a
base of above modification (these are not things to use directly
usually)

[CHANGE] make directory "lib/osx/objc" for the location of Ruby side
libraries.

[CHANGE] rename Objective-C side library "osxobjc.bundle" to
"osx_objc.bundle". Unification for RubyAEOSA and RubyCocoa.

=== Documents

add the References Manual. The description about a class definition
was added to "Using RubyCocoa".


== Changes from 0.1.2

=== Implementation

[IMPROVE] compiling great speed-up. (thanks Chris-san)

[IMPROVE] implement a facility that raise a Cocoa exception
(NSException) as Ruby native exception. (thanks Chris-san)

=== Misc.

add some items in FAQ.


== Changes from 0.1.1

=== Implementation

[BUGFIX] revise a bug about a memory allotment of the case when
dynamic forms a class of Objective-C in ib_loadalbe.

[CHANGE] obsolete "the method (({initialize})) for class extended
(({ib_lodable}))" in 0.1.0. Not pass arguments of "initXXX" of
Objective-C side in "initialize" of Ruby side.

[IMPROVE] implement conversion for NSRange(Cocoa) and
Range(Ruby). (Thanks Chris-san)

=== Misc.

add multinib sample. (Thanks Lucsky-san)


== Changes from 0.1.0

=== Implementation

[IMPROVE] Converting Ruby's Numeric to Cocoa's NSDeccimalNumber if
required. (For "Learning Cocoa" CH.9)

[IMPROVE] (obsoleted by 0.1.2) the method (({initialize})) for class
extended (({ib_lodable})). add mechanism for argument
passing. Actually, this facility is only (({ib_loadable :NSView}))
that use.

=== Misc.

Rewrite the sample dotview with reading "Learning Cocoa" CH.8

Add sample Expenses.app in  "Learning Cocoa" CH.9

Move templates to template directory from sample directory.

Add template Empty.app. Using copy of this, you can create a Cocoa
application by Ruby scripting and some contents modification only.

$Date: 2005-10-28 23:53:26 +0900 (金, 28 10 2005) $
$Revision: 864 $
