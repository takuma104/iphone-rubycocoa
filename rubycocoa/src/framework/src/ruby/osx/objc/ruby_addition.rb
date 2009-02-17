#
#  $Id: ruby_addition.rb 713 2005-01-06 13:40:46Z kimuraw $
#
#  Copyright (c) 2001 FUJIMOTO Hisakuni <hisa@imasy.or.jp>
#
#  This program is free software.
#  You can distribute/modify this program under the terms of
#  the GNU Lesser General Public License version 2.
#
require 'osx/cocoa'

class String

  def nsencoding
    OSX::NSString.guess_nsencoding(self)
  end

  def to_nsstring
    OSX::NSString.stringWithRubyString(self)
  end

  def to_nsmutablestring
    OSX::NSMutableString.stringWithRubyString(self)
  end

end
