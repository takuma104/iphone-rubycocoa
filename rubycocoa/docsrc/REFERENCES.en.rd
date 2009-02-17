# -*-rd-*-
= RubyCocoa References

== (({OSX::ObjcID})) class

The wrapper of an Objective-C object. It becomes the owner of one
certain Objective-C object, and it is wrapped. Usually, you don't need
to be conscious that this class exists.

=== Instance methods of OSX::ObjcID class

--- OSX::ObjcID#inspect

      Returns a string describing the object.

--- OSX::ObjcID#__ocid__

      The integer value of the (({id})) of the wrapped Objective-C object is
      returned.

--- OSX::ObjcID#__inspect__

      Same as (({OSX::ObjcID#inspect})).


== (({OSX::OCObjWrapper})) module

(({OSX::OCObjWrapper})) is the mixin module which implements the facility to send a message (method call) to an Objective-C object. RubyCocoa attaches Cocoa objects with this module, making it possible to invoke methods on Cocoa objects.

Since the Objective-C object set as the object of operation is
specified, the object attached with this module needs to fulfill one
of the following conditions:

  * It is the instance of ((<(({OSX::ObjcID})) class>)).
  * The method of the same specification as ((<(({OSX::ObjcID#__ocid__}))>)) is implemented.

Usually, although you don't need to be conscious of the existence of
this module itself, when you understand a function of RubyCocoa, such as
a mechanism of message invocation, it is also the most important
portion.


=== Sending a message to an Objective-C object

The (({OSX::OCObjWrapper})) module has invoked a message to the Objective-C
object for operation using the structure to which the method call
which has not processed an object turns to ((|method_missing|)).


=== Conversion to an Objective-C message selector from a Ruby method name

In order to carry out the map of the message invocation (method call)
in the world of Ruby to message invocation in the world of
Objective-C, it is necessary to change the method name of Ruby into
the message selector of Objective-C.

It is the method name in Ruby which transposed ':' of a message
selector to '_'.

This is the basic rule of conversion. For example, message selector
When invoking the message of ((|doSomething:with:with:|)), it is a
method name in Ruby. It becomes ((|doSomething_with_with_|)).

In fact, in order to improve appearance other than a basic rule, the
variation of expression as shown below exists.

  (1) Omit '_' of an end
  (2) A keyword is mixed into an arguments

Although it thinks that he cannot understand only now, since it is
also difficult to explain, an example shows.

  [rcv doSomething: a with: b with: c]      /* Objective-C */
  rcv.doSomething_with_with_ (a, b, c)      # the basic rule
  rcv.doSomething_with_with (a, b, c)       # variation (1)
  rcv.doSomething (a, :with, b, :with, c)   # variation (2)


=== "oc_" prefix of a method name

As for the method from which a name begins in "oc_", a message is
directly invoked to the Objective-C object for operation. It is used
mainly when an identically-named method exists in both Ruby and Objective-C
environments.


=== "?" suffix of a method name

At the last of a name the message which attached "?" and invoked
confirms whether the value to which it came on the contrary is 0, and
returns a logical value. This is used at the time of the method call
which returns a logical value.

Because the method of Objective-C returns a logical value as a mere
numerical value (0 is false, not 0 is true), it cannot judge that the
meaning of the value is a numerical or logical in Ruby. 

Furthermore, in Ruby, since 0 and 1 serve both like ((|true|)), if it
uses as it is, logic will collapse. Therefore, when calling the method
which returns a logical value, it is. It is necessary to use the "?"
suffix.


=== instance methods of the OSX::OCObjWrapper module

--- OSX::OCObjWrapper#to_s

      Expression by the Ruby String of the Objective-C object is
      returned.

--- OSX::OCObjWrapper#to_a

      Expression by the Ruby Array of the Objective-C object is
      returned.

--- OSX::OCObjWrapper#to_i

      Expression by the Ruby Integer of the Objective-C object is
      returned.

--- OSX::OCObjWrapper#to_f

      Expression by the Ruby Float of the Objective-C object is
      returned.

--- OSX::OCObjWrapper#objc_methods

      return an array of Objective-C method names.

--- OSX::OCObjWrapper#objc_method_type (name)

      return a type of Objective-C method as string.

--- OSX::OCObjWrapper#ocm_responds? (name)

      The Objective-C object for operation returns the logical value
      which shows whether the method specified by Argument ((|name|))
      can be responded. ((|name|)) must be the message selector itself
      or a thing according to the basic rule. Usually, it is not
      necessary to use this method.

--- OSX::OCObjWrapper#ocm_send (name ...)

      The method specified by Argument ((|name|)) is invoked with the
      remaining arguments to the Objective-C object for
      operation. ((|name|)) must be the message selector itself or a
      thing according to the basic rule. Usually, it is not necessary
      to use this method.


== OSX::OCObject class

A general-purpose Objective-C object wrapper. The Objective-C object
belonging to no Cocoa class defined below as the OSX module is
generated as an instance of this class. Usually, it is not necessary
to generate the instance of this class clearly or to define an
inherited class.


=== superclass
((<OSX::ObjcID class>))

=== include module
((<OSX::OCObjWrapper module>))


== Cocoa class

All Cocoa classes, such as NSObject, NSString, and NSApplication, are
defined as a class of Ruby which belongs to an OSX module like
OSX::NSObject, OSX::NSString, and OSX::NSApplication.

The Cocoa class itself is attached with ((<OSX::OCObjWrapper module>))
as a Cocoa object.


=== include module
((<OSX::OCObjWrapper module>))

=== extend module
((<OSX::OCObjWrapper module>))

=== class methods of Cocoa class

--- {COCOA_CLASS}.__ocid__

      The integer value of id of the Cocoa's class object is returned.


== Cocoa inherited class

=== class methods of Cocoa inherited class

--- {COCOA_INHERITED_CLASS}.ns_overrides (...)

      An override is declared for the method of a super class. This
      declaration is needed when carrying out the override of the
      method directly called from the world of Objective-C. As a
      typical example, the override of ((|drawRect:|)) may be carried
      out by the inherited class of NSView. To an argument, the method
      names according to the basic rule are enumerated.

--- {COCOA_INHERITED_CLASS}.ib_overrides (...)

      the alias of ((|ns_overrides|))

--- {COCOA_INHERITED_CLASS}.ns_outlets (...)

      An outlet is declared. being actual ((|attr_writer|)) -- it is
      calling it is .

--- {COCOA_INHERITED_CLASS}.ib_outlets (...)

      the alias of ((|ns_outlets|))


=== instance method prefix "super_"

For the method which is declared with ns_overrides, if you want to use
the implementation of super class, use "super_" prefix.

  ns_overrides :drawRect_
  def drawRect (frame)
    super_drawRect (frame)   # invoke SuperClass#drawRect
  end


== OSX::OCException class

When an exception ((|NSException|)) occurs by the method call to a
Objective-C object in the world of Objective-C, the exception of this
class will be raised.


=== instance methods of OSX::OCException class

--- OSX::OCException#name

      the exception name (NSException#name) is returned.

--- OSX::OCException#reason

      the reason string (NSException#reason) is returned.

--- OSX::OCException#userInfo

      the user information (NSException#userInfo) is returned.

--- OSX::OCException#nsexception

      NSException is returned.


== OSX::NSPoint class

It is a class for treating the data type ((|NSPoint|)) defined by the
Foundation framework in the Ruby world.

=== class methods of OSX::NSPoint class

--- OSX::NSPoint.new(x,y)

=== instance methods of OSX::NSPoint class

--- OSX::NSPoint#x
--- OSX::NSPoint#y
--- OSX::NSPoint#x= (val)
--- OSX::NSPoint#y= (val)

--- OSX::NSPoint#to_a

      Array ((|[x, y]|)) is returned.


== OSX::NSSize class

It is a class for treating the data type ((|NSSize|)) defined by the
Foundation framework in the Ruby world.

=== class methods of OSX::NSSize class

--- OSX::NSSize.new(width, height)

=== instance methods of OSX::NSSize class

--- OSX::NSSize#width
--- OSX::NSSize#height
--- OSX::NSSize#width= (val)
--- OSX::NSSize#height= (val)

--- OSX::NSSize#to_a

      Array ((|[width, height]|)) is returned.


== OSX::NSRect class

It is a class for treating the data type ((|NSRect|)) defined by the
Foundation framework in the Ruby world.

=== class methods of OSX::NSRect class

--- OSX::NSRect.new(origin, size)
--- OSX::NSRect.new(x, y, width, height)

=== instance methods of OSX::NSRect class

--- OSX::NSRect#origin
--- OSX::NSRect#size
--- OSX::NSRect#origin= (val)
--- OSX::NSRect#size= (val)

--- OSX::NSRect#to_a

      Array ((|[[x, y], [width, height]]|)) is returned.


== OSX::NSRange class

It is a class for treating the data type ((|NSRange|)) defined by the
Foundation framework in the Ruby world.

=== class methods of OSX::NSRange class

--- OSX::NSRange.new(range)
--- OSX::NSRange.new(location, length)

=== instance methods of OSX::NSRange class

--- OSX::NSRect#location
--- OSX::NSRect#length
--- OSX::NSRect#location= (val)
--- OSX::NSRect#length= (val)

--- OSX::NSRect#to_a

      Array ((|[ location, length ]|)) is returned.

--- OSX::NSRect#to_range

      Ruby's Range object is returned.


$Date: 2003-01-23 13:59:21 +0900 (木, 23  1 2003) $
$Revision: 627 $
