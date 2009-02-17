# RubyController

require 'osx/cocoa'

class RubyController < OSX::NSObject

  ib_outlets :textField

  def btnClicked(sender)
    @textField.setStringValue "#{sender.title} !!"
  end

end
