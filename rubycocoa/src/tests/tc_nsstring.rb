#
#  $Id: tc_nsstring.rb 871 2005-11-02 13:17:46Z kimuraw $
#
#  Copyright (c) 2001 FUJIMOTO Hisakuni <hisa@imasy.or.jp>
#
#  This program is free software.
#  You can distribute/modify this program under the terms of
#  the GNU Lesser General Public License version 2.
#

require 'test/unit'
require 'osx/cocoa'
require 'kconv'

class TC_NSString < Test::Unit::TestCase
  include OSX

  def setup
    @teststr = "Hello World".freeze
    @eucstr = "オブジェクト指向スクリプト言語Ruby".toeuc.freeze
    $KCODE = 'NONE'
  end

  def teardown
    $KCODE = 'NONE'
  end

  def test_s_alloc
    obj = NSString.alloc.init
    assert( obj.isKindOfClass?(NSString) )
  end

  def test_s_stringWithString
    obj = NSString.stringWithString(@teststr)
    assert_equal(@teststr, obj.to_s)
  end

  def test_initWithString
    obj = NSString.alloc.initWithString(@teststr)
    assert_equal(@teststr, obj.to_s)
  end

  def test_stringWithRubyString_euc
    $KCODE = 'EUC'
    nsstr = NSString.stringWithRubyString( @eucstr )
    assert_equal( @eucstr, nsstr.to_s.toeuc )
  end

  def test_stringWithRubyString_sjis
    $KCODE = 'EUC'
    nsstr = NSString.stringWithRubyString( @eucstr.tosjis )
    assert_equal( @eucstr, nsstr.to_s.toeuc )
  end

  def test_stringWithRubyString_jis
    $KCODE = 'EUC'
    nsstr = NSString.stringWithRubyString( @eucstr.tojis )
    assert_equal( @eucstr, nsstr.to_s.toeuc )
  end

  def test_dataUsingEncoding_euc
    nsstr = NSString.stringWithRubyString( @eucstr )
    data = nsstr.dataUsingEncoding( NSJapaneseEUCStringEncoding )
    bytes = "." * data.length
    data.getBytes( bytes )
    assert_equal( @eucstr, bytes )
  end

  def test_dataUsingEncoding_sjis
    nsstr = NSString.stringWithRubyString( @eucstr )
    data = nsstr.dataUsingEncoding( NSShiftJISStringEncoding )
    bytes = "." * data.length
    data.getBytes( bytes )
    assert_equal( @eucstr.tosjis, bytes )
  end

  def test_dataUsingEncoding_jis
    nsstr = NSString.stringWithRubyString( @eucstr )
    data = nsstr.dataUsingEncoding( NSISO2022JPStringEncoding )
    bytes = "." * data.length
    data.getBytes( bytes )
    assert_equal( @eucstr.tojis, bytes )
  end

end
