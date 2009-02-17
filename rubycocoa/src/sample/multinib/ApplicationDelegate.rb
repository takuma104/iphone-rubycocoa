require 'osx/cocoa'
require 'WindowAController'
require 'WindowBController'

class ApplicationDelegate < OSX::NSObject

  def createWindowA (sender)
    controller = WindowAController.alloc.init
    controller.showWindow(self)
  end

  def createWindowB (sender)
    controller = WindowBController.alloc.init
    controller.showWindow
  end

end
