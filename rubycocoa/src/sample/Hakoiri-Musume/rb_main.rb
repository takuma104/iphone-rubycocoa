#!/usr/bin/ruby
#
# $Id: rb_main.rb 372 2002-09-11 09:34:45Z hisa $
#

require 'hako'
require 'cocoa_hako'

lang = 
  if /ja/ =~ ENV['LANG'] then 'ja' else nil end

Hako::Game.new(CocoaHako.alloc.init(nil, 64), lang)
OSX.NSApp.run
