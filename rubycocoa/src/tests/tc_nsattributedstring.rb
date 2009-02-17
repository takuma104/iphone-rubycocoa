#
#  $Id: tc_nsattributedstring.rb 511 2002-12-22 09:31:34Z hisa $
#
#  Copyright (c) 2001 FUJIMOTO Hisakuni <hisa@imasy.or.jp>
#
#  This program is free software.
#  You can distribute/modify this program under the terms of
#  the GNU Lesser General Public License version 2.
#

require 'test/unit'
require 'osx/cocoa'

class TC_NSAttributedString < Test::Unit::TestCase

  STR = 'Hello World'
  HTML_A = "<h1>#{STR}</h1>".freeze # 
  HTML_B = "<a href='hello'>#{STR}</a>".freeze #

  def test_s_alloc
    obj = OSX::NSAttributedString.alloc.init
    assert_equal( true, obj.isKindOfClass?( OSX::NSAttributedString ))
  end

  def test_initWithHTML
    # 2nd arg nil
    data = OSX::NSData.dataWithBytes_length(HTML_A, HTML_A.size)
    obj = OSX::NSAttributedString.alloc.initWithHTML_documentAttributes(data, nil)
    assert_match(/^#{STR}/, obj.to_s) #

    # 2nd arg assign
    data = OSX::NSData.dataWithBytes_length(HTML_B, HTML_B.size)
    arg1 = OSX::OCObject.new
    obj = OSX::NSAttributedString.alloc.initWithHTML_documentAttributes(data, arg1)
    assert_match(/^#{STR}/, obj.to_s) #
    assert_equal(true, arg1.isKindOfClass?(OSX::NSDictionary))

    # illegal 2nd arg
    data = OSX::NSData.dataWithBytes_length(HTML_B, HTML_B.size)
    arg1 = Object.new
    assert_raises(OSX::OCDataConvException) do
      obj = OSX::NSAttributedString.alloc.initWithHTML_documentAttributes(data, arg1)
    end
  end

end
