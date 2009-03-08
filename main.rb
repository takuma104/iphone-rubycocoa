p $:

require 'osx/cocoa'

# require 'remote_irb'
# RemoteIRB.new(6000).start
 
class MyAppDelegate < OSX::NSObject

	attr_accessor :window
	attr_accessor :textView
	
	def initialize
		p self
	end
		
	def applicationDidFinishLaunching(application)
		@window = OSX::UIWindow.alloc.initWithFrame(OSX::UIScreen.mainScreen.bounds)
		@window.setBackgroundColor(OSX::UIColor.darkGrayColor)
		@window.makeKeyAndVisible

		@textView = OSX::UILabel.alloc.initWithFrame(OSX::UIScreen.mainScreen.bounds)
		@textView.setText("hello RubyCocoa world")
		@textView.setTextAlignment(OSX::UITextAlignmentCenter)
		@textView.setFont(OSX::UIFont.boldSystemFontOfSize(24))
		@textView.setTextColor(OSX::UIColor.whiteColor)
		@textView.setBackgroundColor(OSX::UIColor.clearColor)

		@window.addSubview(@textView)
		
		p @window
		p @textView
	end
end

OSX.UIApplicationMain(0, nil, nil, "MyAppDelegate")
