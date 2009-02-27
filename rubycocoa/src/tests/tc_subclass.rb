#
#  $Id: tc_subclass.rb 979 2006-05-29 01:18:25Z hisa $
#
#  Copyright (c) 2005-2006 kimura wataru
#  Copyright (c) 2001-2002 FUJIMOTO Hisakuni
#

require 'test/unit'
require 'osx/cocoa'

class SubClassA < OSX::NSObject

  DESCRIPTION = "Overrided 'description' Method !"

  ib_outlet :dummy_outlet
  ns_override :description

  def description() DESCRIPTION end

end

class TC_SubClass < Test::Unit::TestCase

  def test_s_new
    err = nil
    begin
      SubClassA.new
    rescue => err
    end
    assert_kind_of( RuntimeError, err )
    assert_equal( OSX::NSBehaviorAttachment::ERRMSG_FOR_RESTRICT_NEW, err.to_s )
  end

  def test_ocid
    obj = SubClassA.alloc.init
    assert_not_nil( obj.__ocid__ )
    assert_kind_of( Integer, obj.__ocid__ )
  end

  def test_override
    obj = SubClassA.alloc.init
    assert_equal( SubClassA::DESCRIPTION, obj.description )
  end

  def test_outlet
    obj = SubClassA.alloc.init
    assert_nothing_thrown { obj.dummy_outlet = 12345 }
    assert_equal( 12345, obj.instance_eval{ @dummy_outlet } )
    assert_nothing_thrown { obj.dummy_outlet = 12345.to_s }
    assert_equal( 12345.to_s, obj.instance_eval{ @dummy_outlet } )
  end

  def test_addmethod
    obj = SubClassA.alloc.init
    assert_raise( NameError ) { obj.unknownMethod('dummy') }
    SubClassA.module_eval <<-EOS
      addRubyMethod_withType('unknownMethod:', 'i4@8@12' )
      def unknownMethod(text) return 123 end
    EOS
    assert_equal( 123, obj.unknownMethod('dummy') )
  end

  # testunit-0.1.8 has "assert_raises" not "assert_raise"
  unless method_defined? :assert_raise
    alias :assert_raise :assert_raises
  end

end
