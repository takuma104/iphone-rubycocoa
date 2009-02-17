#
#  $Id: tc_rubystring.rb 712 2004-12-11 11:54:39Z hisa $
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

class TC_RubyString < Test::Unit::TestCase
  include OSX

  def setup
    @rbstr = "オブジェクト指向スクリプト言語Ruby".toeuc
    @nsstr = NSString.stringWithRubyString( @rbstr )
  end

  def test_nsencoding
    assert_equal( NSJapaneseEUCStringEncoding, @rbstr.nsencoding )
    assert_equal( NSShiftJISStringEncoding, @rbstr.tosjis.nsencoding )
    assert_equal( NSISO2022JPStringEncoding, @rbstr.tojis.nsencoding )
  end

  def test_to_nsstring
    str = @rbstr.toeuc.to_nsstring
    assert( str.isEqualToString?( @nsstr ))
    str = @rbstr.tosjis.to_nsstring
    assert( str.isEqualToString?( @nsstr ))
    str = @rbstr.tojis.to_nsstring
    assert( str.isEqualToString?( @nsstr ))
  end

  def test_to_nsmutablestring
    str = @rbstr.toeuc.to_nsmutablestring
    assert( str.isEqualToString?( @nsstr ))
    str = @rbstr.tosjis.to_nsmutablestring
    assert( str.isEqualToString?( @nsstr ))
    str = @rbstr.tojis.to_nsmutablestring
    assert( str.isEqualToString?( @nsstr ))
  end

end
