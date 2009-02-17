# -*-rd-*-
= RubyCocoa Programming

== INDEX

* ((<(({irb})) - Interactive Ruby>))
* ((<Load libraries>))
* ((<A first example with sensory appeal>))
* ((<Cocoa classes are Ruby classes>))
* ((<Creating a Cocoa object>))
* ((<Ownership and memory management>))
* ((<Return value of methods>))
* ((<Representing Objective-C message selectors>))
* ((<Convert Ruby object method arguments when possible>))
* ((<Handling method name conflicts>))
* ((<Inheriting from Cocoa>))
* ((<Defining a Cocoa-inherited class>))
* ((<Defining Interface Builder outlets>))
* ((<Overriding a method>))
* ((<Instantiating a Cocoa-inherited class>))
* ((<Where should initialization code be written?>))
* ((<Debugging a RubyCocoa application>))


== (({irb})) - Interactive Ruby

You may want to use (({irb})) to try the script snippets in this document.
(({irb})) is a command that lets you use a Ruby interpreter interactively from
the command line. You can start an interactive session with RubyCocoa using the
following command:

  % irb -r osx/cocoa

(NOTE) In Mac OS X 10.1, bus errors often occur when using (({irb})) with
RubyCocoa. Mac OS X 10.2 or later is recommended.


== Load libraries

  require 'osx/cocoa'      # classes defined in Foundation and AppKit.

or

  require 'osx/foundation' # classes defined in Foundation
  require 'osx/appkit'     # classes defined in AppKit


== A first example with sensory appeal

Let's start with a simple example that will delight your senses -- this script
will play a sound. Try this with (({irb})):

  include OSX
  files = `ls /System/Library/Sounds/*.aiff`.split
  NSSound.alloc.initWithContentsOfFile_byReference (files[0], true).play
  NSSound.alloc.initWithContentsOfFile_byReference (files[1], true).play
  NSSound.alloc.initWithContentsOfFile_byReference (files[2], true).play


== Cocoa classes are Ruby classes

In the following code examples, the comments starting with (({# =>})) show the
string Ruby will output when it executes that line of code.

  p OSX::NSObject # => OSX::NSObject
  nsstr = OSX::NSObject.description
  p nsstr         # => #<OSX::OCObject:0x5194e8 class='NSCFString' id=A97910>
  nsobj = OSX::NSObject.alloc.init
  p nsobj         # => #<OSX::NSObject:0x51f5b4 class='NSObject' id=976D90>

In RubyCocoa (after 0.2.0), a Cocoa class is defined as a Ruby class under the
(({OSX})) module. A Cocoa class is a Ruby class and behaves as a Cocoa object.


== Creating a Cocoa object

The normal Cocoa methods are used for creation of Cocoa objects.

  obj = OSX::NSObject.alloc.init
  str = OSX::NSString.stringWithString "hello"
  str = OSX::NSString.alloc.initWithString "world"

Inside RubyCocoa, the created Cocoa object is wrapped in the object of a class
called (({OSX::ObjcID})). Usually, you don't need to be conscious of the
existence of an (({OSX::ObjcID})) class.


== Ownership and memory management

The instance of (({OSX::ObjcID})) is the real owner of the Cocoa object which
(({self})) has wrapped. Ownership is automatically lost when the instance of
(({OSX::ObjcID})) is cleaned by Ruby's garbage collection. Therefore, it is not
necessary to worry about memory management issues such as ownership in
RubyCocoa.

  str = OSX::NSString.stringWithString "hello"
  str = OSX::NSString.alloc.initWithString "world"

Although in Objective-C the two lines above differ as to whether ownership is
generated or delegated, in RubyCocoa there is no need to be conscious of
ownership; the difference between the two techniques shown above
is not such an important issue. In principle, it is not necessary to call
methods such as (({release})), (({autorelease})), and (({retain})), and you do
not need to create (({NSAutoreleasePool}))s.

* Use Cocoa methods to create Cocoa objects.
* Don't worry about ownership and memory management.


== Return value of methods

  nstr = OSX::NSString.description
  p nstr      # => #<OCObject:0x7233e class='NSCFString' id=687610>
  p nstr.to_s # => "NSString"

  nstr = OSX::NSString.stringWithString "Hello World !"
  p nstr      # => #<OCObject:0x71970 class='NSCFString' id=688E90>
  p nstr.to_s # => "Hello World !"

  nstr = OSX::NSString.stringWithString(`pwd`.chop)
  nary = nstr.pathComponents
  p nary      # => #<OCObject:0x6bb2e class='NSCFArray' id=3C0150>

  ary = nary.to_a
  p ary       # => [#<OCObject:0x6a9b8 class='NSCFString' id=3C2B50>,...]

  ary.map! {|i| i.to_s }
  p ary       # => ["/", "Users", "hisa", "src", "ruby", "osxobjc"]

In RubyCocoa, methods that return Objective-C objects such as (({NSString}))
and (({NSArray})) return Cocoa objects, as you might have guessed from these
examples.  The return value is not automatically converted to the corresponding
Ruby class ((({String})), for example). For (({NSString})) and (({NSArray})),
(({to_s})) and (({to_a})) are defined and can be used.


== Representing Objective-C message selectors

  # play system sounds (2)
  sndfiles.each do |path|
    snd = OSX::NSSound.alloc.initWithContentsOfFile(path, :byReference, true)
    snd.play
    sleep 0.25 while snd.isPlaying?
  end

This is another version of "playing system sounds". This shows the other way
Objective-C message selectors can be represented in the Ruby world.

In Objective-C:

  [obj hogeAt: a0 withParamA: a1 withParamB: a2]

RubyCocoa provides several ways to specify message selectors. The simplest way
is to substitute "(({:}))" with "(({_}))".

  obj.hogeAt_withParamA_withParamB_ (a0, a1, a2)

But because this looks awkward, you can omit the last underscore.

  obj.hogeAt_withParamA_withParamB (a0, a1, a2)

When the method name is very long, the relationship between the message
selector keyword and each argument is unclear. In order to improve this:

  obj.hogeAt (a0, :withParamA, a1, :withParamB, a2)


For Cocoa methods that return the (({BOOL})) type (predicate method), use
the method name suffix "?" to return a Ruby boolean. If this suffix is omitted,
the method will return the value (({0})) (NO) or (({1})) (YES). These values
behave as (({true})) in the Ruby world, so you will get unexpected results.

  nary = OSX::NSMutableArray.alloc.init
  p nary.containsObject("hoge")   # => 0
  p nary.containsObject?("hoge")  # => false
  nary.addObject("hoge")
  p nary.containsObject("hoge")   # => 1
  p nary.containsObject?("hoge")  # => true


== Convert Ruby object method arguments when possible

It seems to be usual containsObject of the top and, in case of method
to catch Objective-C object as a value of argument, tries conversion
even if it just hands Ruby object so long as it is possible.


== Handling method name conflicts

  klass = OSX::NSObject.class
  p klass     # => OSX::OCObject
  klass = OSX::NSObject.oc_class
  p klass     # => #<OCObject:0x82f22 class='NSObject' id=80819B0C>

When the same method name exists in Ruby and Objective-C, like in the case of
(({Object#class})), prefix the method name with "(({oc_}))".

== Inheriting from Cocoa

So far, we've discussed existing Cocoa classes and their
instances. From this point, we'll discuss the definition and
instantiation of derived class of Cocoa, which is also needed when
writing RubyCocoa applications. Since the implementation of derived
class mechanism for RubyCocoa is a little tricky, there are some
restrictions and peculiarities.


== Defining a Cocoa-inherited class

The class of the Cocoa objects set up in the GUI definition file (nib file)
created by Interface Builder is defined as an inherited class (after 0.2.0).
For example, the Controller of the MVC model as described in many Cocoa
tutorials is defined in Ruby like this:

  class AppController < OSX::NSObject

    ib_outlets :messageField

    def btnClicked(sender)
      @messageField.setStringValue "Merry Xmas !"
    end

  end

The inherited class definition of Cocoa in RubyCocoa is similarly
described to be the inherited class definition by the usual Ruby in
this way.


== Defining Interface Builder outlets

The outlet set as the class in the nib file is written to be:

  ns_outlets :rateField, :dollerField

in the definition of an inherited class. In fact, (({ns_outlets})) is the same
as (({Module#attr_writer})). Therefore, a definition can alternatively be given
this way:

  def rateField= (new_val)
    @rateField = new_val
  end

(({ns_outlets})) also has an alias called (({ib_outlets})).


== Overriding a method

When overriding a method defined by the parent class, it is necessary to
declare the override using (({ns_overrides})) (alias (({ib_overrides}))).

  class MyCustomView < OSX::NSView

    ns_overrides :drawRect_, 'mouseUp:'

    def drawRect(frame)
    end

    ...
  end

In the argument of (({ns_overrides})) what expressed the message selector of
Objective-C as the string or the symbol is given. However, the
notation for omitting ":" and "_" of the end explained previously
cannot be used. It is necessary to describe correctly according to the
number of arguments.

To invoke the superclass method in an overriding method, prefix the method name
with "(({super_}))".

  class MyCustomView < OSX::NSView

    ns_overrides :drawRect_

    def drawRect (frame)
      p frame
      super_drawRect(frame)   # invoke the implementation of NSView#drawRect
    end

  end


== Instantiating a Cocoa-inherited class

When an instance of a Cocoa-inherited class needs to be created in a Ruby
script, it writes like:

  AppController.alloc.init  # use this

like the case of the existing Cocoa class. The usual Ruby idiom:

  AppController.new    # don't use this

cannot be used (it raises an exception). Although there are various situations
in this, since it becomes long, a detailed explanation is omitted here.

These restrictions have deep relation in instance generation being
performed in the turn:

  * alloc (in Objective-C world)
  * in alloc, create a Ruby object (initialize method is called here)


== Where should initialization code be written?

In Ruby an initialization procedure is written in the
"(({initialize}))" method generally. But you should be careful in
doing so.  When the "initialize" method is invoked, a Cocoa object in
the Objective-C space is just only given memory. And it is not
initialized yet. Therefore, in the "initialize" method, you must not
invoke a method implemented in Objective-C space. You should use only
a method by Ruby at the point.

If the object needs to be loaded from a nib file, initializing by the
"awakeFromNib" method is safest. Doesn't it seem that it is also
necessary to actually define the inherited class of Cocoa in most of
these cases?

In other cases, initialization is done in the style of Cocoa's (({init})).
It is probably a good idea to write to a method with a prefix.

Please do not forget to return (({self})) from initialization methods.


== Debugging a RubyCocoa application

Currently (as of 2003-01-05), it is impossible for you to use a ruby
debugger in ProjectBuilder, because a plug-in module for a RubyCocoa
application doesn't exist.

But, you can debug with a debugger (e.g. debug.rb) by launching an
application with appropriate options in the shell. If you like Emacs,
you can also use a (({rubydb})) command which is contained in a ruby
source distribution.

The following shows a sequence in which the debugger breaks execution of a
RubyCocoa application (simpleapp in samples).

  $ cd sample/simpleapp/
  $ pbxbuild
  $ build/SimpleApp.app/Contents/MacOS/SimpleApp -r debug
  (rdb:1) b AppController.rb:24    # set a break point
  Set breakpoint 1 at AppController.rb:24
  (rdb:1) c
  Breakpoint 1, aboutApp at AppController.rb:24
  AppController.rb:24:
  (rdb:1) l
  [19, 28] in AppController.rb
     19      @myView.set_alpha(@slider.floatValue)
     20      @myView.set_color(@colorWell.color)
     21    end
     22  
     23    def aboutApp (sender)
  => 24      NSApp().orderFrontStandardAboutPanelWithOptions(
     25        "Copyright" => "RubyCocoa #{RUBYCOCOA_VERSION}",
     26        "ApplicationVersion" => "Ruby #{VERSION}")
     27    end
     28  
     29    def colorBtnClicked (sender)
  (rdb:1) sender
  #<OSX::NSMenuItem:0xd439e class='NSMenuItem' id=0x3e27d0>
  (rdb:1) q
  Really quit? (y/n) y


$Date: 2005-09-01 01:10:34 +0900 (木, 01  9 2005) $
