#
#  $Id: tc_objcptr.rb 610 2003-01-15 05:21:56Z hisa $
#
#  Copyright (c) 2001 FUJIMOTO Hisakuni <hisa@imasy.or.jp>
#
#  This program is free software.
#  You can distribute/modify this program under the terms of
#  the GNU Lesser General Public License version 2.
#

require 'test/unit'
require 'osx/cocoa'

class TC_ObjcPtr < Test::Unit::TestCase
  include OSX

  def test_s_new
    length = 123456
    cptr = ObjcPtr.new( length )
    assert_kind_of( ObjcPtr, cptr )
    assert_equal( length, cptr.allocated_size )
    assert( ! cptr.tainted? )
  end

  def test_s_allocate_as_int8
    cptr = ObjcPtr.allocate_as_int8
    assert_kind_of( ObjcPtr, cptr )
    assert_equal( 1, cptr.allocated_size )
    assert( ! cptr.tainted? )
  end

  def test_s_allocate_as_int16
    cptr = ObjcPtr.allocate_as_int16
    assert_kind_of( ObjcPtr, cptr )
    assert_equal( 2, cptr.allocated_size )
    assert( ! cptr.tainted? )
  end

  def test_s_allocate_as_int32
    cptr = ObjcPtr.allocate_as_int32
    assert_kind_of( ObjcPtr, cptr )
    assert_equal( 4, cptr.allocated_size )
    assert( ! cptr.tainted? )
  end

  def test_s_allocate_as_bool
    cptr = ObjcPtr.allocate_as_bool
    assert_kind_of( ObjcPtr, cptr )
    assert_equal( 1, cptr.allocated_size )
    assert( ! cptr.tainted? )
  end

  def test_s_allocate_as_int
    cptr = ObjcPtr.allocate_as_int
    assert_kind_of( ObjcPtr, cptr )
    assert_equal( 4, cptr.allocated_size )
    assert( ! cptr.tainted? )
  end

  def test_cptr_as_returned_value_of_method_call
    cptr = NSData.dataWithContentsOfFile('/etc/passwd').bytes
    assert_kind_of( ObjcPtr, cptr )
    assert_equal( 0, cptr.allocated_size )
    assert( cptr.tainted? )
  end

  def test_cptr_as_param_of_method_call
    src = 'hello world'
    data = NSData.dataWithRubyString( src )
    cptr = ObjcPtr.new( src.size )
    data.getBytes( cptr )
    assert_equal( src.size, cptr.allocated_size )
  end

  def test_bytestr_at
    src = 'hello world'
    cptr = NSData.dataWithRubyString(src).bytes
    bstr = cptr.bytestr_at(3,4)
    assert_equal( src[3,4], bstr )
    assert( bstr.tainted? )
  end

  def test_bytestr
    src = 'hello world'
    cptr = NSData.dataWithRubyString(src).bytes
    bstr = cptr.bytestr(src.size)
    assert_equal( src, bstr )
    assert( bstr.tainted? )
  end

#   rb_define_method (_kObjcPtr, "int8_at", rb_objcptr_int8_at, 1);
#   rb_define_method (_kObjcPtr, "uint8_at", rb_objcptr_uint8_at, 1);
#   rb_define_method (_kObjcPtr, "int16_at", rb_objcptr_int16_at, 1);
#   rb_define_method (_kObjcPtr, "uint16_at", rb_objcptr_uint16_at, 1);
#   rb_define_method (_kObjcPtr, "int32_at", rb_objcptr_int32_at, 1);
#   rb_define_method (_kObjcPtr, "uint32_at", rb_objcptr_uint32_at, 1);
#   rb_define_alias (_kObjcPtr, "int_at", "int32_at");
#   rb_define_alias (_kObjcPtr, "uint_at", "uint32_at");
#   rb_define_alias (_kObjcPtr, "bool_at", "uint8_at");

#   rb_define_method (_kObjcPtr, "int8", rb_objcptr_int8, 0);
#   rb_define_method (_kObjcPtr, "uint8", rb_objcptr_uint8, 0);
#   rb_define_method (_kObjcPtr, "int16", rb_objcptr_int16, 0);
#   rb_define_method (_kObjcPtr, "uint16", rb_objcptr_uint16, 0);
#   rb_define_method (_kObjcPtr, "int32", rb_objcptr_int32, 0);
#   rb_define_method (_kObjcPtr, "uint32", rb_objcptr_uint32, 0);
#   rb_define_alias (_kObjcPtr, "int", "int32");
#   rb_define_alias (_kObjcPtr, "uint", "uint32");
#   rb_define_alias (_kObjcPtr, "bool", "uint8");

end
