#
#  $Id: ruby_addition.rb 979 2006-05-29 01:18:25Z hisa $
#
#  Copyright (c) 2001 FUJIMOTO Hisakuni
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
