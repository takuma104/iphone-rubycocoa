#
# $Id: AppCtrl.rb 490 2002-12-18 00:15:16Z hisa $
#
require 'osx/cocoa'

class AppCtrl < OSX::NSObject

  ib_outlets :monthField, :dayField, :mulField

  def awakeFromNib
    @close_cnt = 3
    @monthField.setIntValue  Time.now.month
    @dayField.setIntValue Time.now.day
    convert
  end

  def convert (sender = nil)
    val = @monthField.intValue * @dayField.intValue
    @mulField.setIntValue(val)
    @monthField.selectText(self)
  end

  def windowShouldClose (sender = nil)
    @close_cnt -= 1
    @close_cnt == 0
  end    

end
