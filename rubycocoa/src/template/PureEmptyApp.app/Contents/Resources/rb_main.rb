#
# $Id: rb_main.rb 490 2002-12-18 00:15:16Z hisa $
#

require 'osx/cocoa'

app = OSX::NSApplication.sharedApplication
app.setMainMenu(OSX::NSMenu.alloc.init)
OSX.NSApp.run
