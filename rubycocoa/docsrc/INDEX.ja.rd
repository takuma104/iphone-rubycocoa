# -*-rd-*-

== RubyCocoa¤È¤Ï¡©

RubyCocoa¤Ï¡¢
¥ª¥Ö¥¸¥§¥¯¥È»Ø¸þ¥¹¥¯¥ê¥×¥È¸À¸ì((<Ruby|URL:http://www.ruby-lang.org/>))¤Ç¤Î
((<Cocoa|URL:http://developer.apple.com/cocoa/>))¥×¥í¥°¥é¥ß¥ó¥°¤ò²ÄÇ½¤È¤¹¤ë¡¢
((<Mac OS X|URL:http://www.apple.co.jp/macosx/>))¤Î¥Õ¥ì¡¼¥à¥ï¡¼¥¯¤Ç¤¹¡£

RubyCocoa¤ò»È¤Ã¤Æ¡¢Cocoa¥¢¥×¥ê¥±¡¼¥·¥ç¥ó¤òRuby¤Ç½ñ¤¤¤¿¤ê¡¢Ruby¥¹¥¯¥ê¥×¥È¤Ç
Cocoa¥ª¥Ö¥¸¥§¥¯¥È¤òÀ¸À®¤·¤Æµ¡Ç½¤òÍøÍÑ¤¹¤ë¤³¤È¤¬¤Ç¤­¤Þ¤¹¡£
Cocoa¥¢¥×¥ê¥±¡¼¥·¥ç¥ó¤Ç¤Ï¡¢Ruby¤ÈObjective-C¤Î¥½¡¼¥¹¤¬º®ºß¤¹¤ëCocoa
¥¢¥×¥ê¥±¡¼¥·¥ç¥ó¤òºî¤ë¤³¤È¤â²ÄÇ½¤Ç¤¹¡£

¼¡¤Î¤è¤¦¤Ê¤È¤­¤ËRubyCocoa¤ò»È¤¨¤Þ¤¹:

  * irb¤ÇÂÐÏÃÅª¤ËCocoa¥ª¥Ö¥¸¥§¥¯¥È¤ÎÀ­¼Á¤òÃµµá
  * Cocoa¥¢¥×¥ê¥±¡¼¥·¥ç¥ó¤Î¥Ö¥í¥È¥¿¥¤¥Ô¥ó¥°¡¦³«È¯
  * Ruby¤ÈObjective-CÁÐÊý¤ÎÄ¹½ê¤ò³è¤«¤·¤¿Cocoa¥¢¥×¥ê¥±¡¼¥·¥ç¥ó
  * Ruby¥¹¥¯¥ê¥×¥È¤ËMac OS XÉ÷¤Î¥æ¡¼¥¶¥¤¥ó¥¿¡¼¥Õ¥§¡¼¥¹¤ò¤«¤Ö¤»¤ë


== ¥¹¥¯¥ê¡¼¥ó¥·¥ç¥Ã¥È

Ruby¥¹¥¯¥ê¥×¥È¤ÈInterface Builder¤ÎNib¥Õ¥¡¥¤¥ë¤Î¤ß¤Ç½ñ¤«¤ì¤¿RubyCocoa
¥¢¥×¥ê¥±¡¼¥·¥ç¥ó¤¬Æ°ºî¤·¤Æ¤¤¤ë¤È¤³¤í¤Î¥¹¥¯¥ê¡¼¥ó¥·¥ç¥Ã¥È¤Ç¤¹¡£
<<< img_simpleapp

== ¥¹¥¯¥ê¥×¥ÈÎã

°Ê²¼¤ÎÎã¤Ï¥·¥¹¥Æ¥à¤Î²»¤ò½çÈÖ¤ËÌÄ¤é¤¹¥¹¥¯¥ê¥×¥È¤Ç¤¹¡£

  require 'osx/cocoa'
  snd_files =`ls /System/Library/Sounds/*.aiff`.split
  snd_files.each do |path|
    snd = OSX::NSSound.alloc.
      initWithContentsOfFile_byReference (path, true)
    snd.play
    sleep 0.5
  end

°Ê²¼¤ÎÎã¤Ï¥Þ¥Ã¥¯¤Ë¥Æ¥­¥¹¥È¤òÆÉ¤ß¾å¤²¤µ¤»¤ë¥¹¥¯¥ê¥×¥È¤Ç¤¹(OSX 10.2°Ê¹ßÍÑ)¡£

  require 'osx/cocoa'
  include OSX
  def speak (str)
    str.gsub! (/"/, '\"')
    src = %(say "#{str}")
    NSAppleScript.alloc.initWithSource(src).executeAndReturnError(nil)
  end
  speak "Hello World!"
  speak "Kon nich Wah. Ogan key desu ka?" # "Hi. How are you." in Japanese
  speak "Fuji Yamah, Nin Jya, Sukiyaki, Ten pora, Sushi."

°Ê²¼¤ÎÎã¤Ï¥¤¥ó¥¿¡¼¥Õ¥§¡¼¥¹¥Ó¥ë¥À¡¼¤ÇºîÀ®¤·¤¿nib¥Õ¥¡¥¤¥ëÆâ¤Î¥¯¥é¥¹¤È´Ø
Ï¢¤Å¤±¤é¤ì¤¿¥¯¥é¥¹ÄêµÁ¤Î¥µ¥ó¥×¥ë¤Ç¤¹¡£

  require 'osx/cocoa'

  class AppCtrl < OSX::NSObject

    ib_outlets :monthField, :dayField, :mulField

    def awakeFromNib
      @monthField.setIntValue  Time.now.month
      @dayField.setIntValue Time.now.day
      convert
    end

    def convert (sender = nil)
      val = @monthField.intValue * @dayField.intValue
      @mulField.setIntValue (val)
      @monthField.selectText (self)
    end

    def windowShouldClose (sender = nil)
      OSX.NSApp.stop (self)
      true
    end    

  end

== ¥é¥¤¥»¥ó¥¹

((<GNU Lesser General Public License version 2. LGPL
|URL:http://www.gnu.org/licenses/lgpl.html>))


== ¼Õ¼­

¤Þ¤ºChris Thomas¤µ¤ó¡¢Luc "lucsky" Heinrich¤µ¤ó¡¢S.Sawada¤µ¤ó¤Ë´¶¼Õ¤¤¤¿¤·¤Þ¤¹¡£

¤µ¤é¤Ë

Gesse Gam, Hiroyuki Shimura, John Platte, kimura wataru, Masaki Yatsu,
Masatoshi Seki, Michael Miller, Ogino Junya, Ralph Broom, Rich Kilmer,
Shirai Kaoru, Tetsuhumi Takaishi, Tosh, Matthew Fero, Rod Schmidt,
Jonathan Paisley, Norberto Ortigoza

¤ò¤Ï¤¸¤á¤È¤¹¤ëÂ¿¤¯¤ÎÊý¡¹¤Ë´¶¼Õ¤¤¤¿¤·¤Þ¤¹¡£


== ¥³¥ó¥¿¥¯¥È

¥Ð¥°¥ê¥Ý¡¼¥È¡¢¤³¤ó¤Ê¥¢¥¤¥³¥óºî¤ê¤Þ¤·¤¿¡¢¥³¥á¥ó¥È¤Ê¤É¤ªµ¤·Ú¤Ë
¤ª´ó¤»¤¯¤À¤µ¤¤¡£

ºî¼Ô¤Ï»Å»ö¤òÃµ¤·¤Æ¤¤¤Þ¤¹¡£

* RubyCocoa¤Î³«È¯¡¦±þÍÑ³«È¯¡¦¥µ¥Ý¡¼¥È³èÆ°¤Î»Ù±ç¡¦»ö¶È²½
* RubyCocoa¤Î¥¹¥Ý¥ó¥µ¡¼¤Ë¤Ê¤ê¤¿¤¤
* RubyCocoa¥Ù¡¼¥¹¤Î³«È¯¥Ä¡¼¥ë¤Î³«È¯
* ¤½¤ÎÂ¾¤Ê¤ó¤Ç¤â (RubyCocoa¤¸¤ã¤Ê¤¯¤Æ¤â)
* ²¿¤«»Å»ö¤ò°ÍÍê¤·¤¿¤¤

¤Ê¤É¤Ë´Ø¿´¤Î¤¢¤ë´ë¶È¡¦ÃÄÂÎ¡¦¸Ä¿Í¤ÎÊý¤¬¤¤¤é¤Ã¤·¤ã¤ì¤Ð¡¢¤ªµ¤·Ú¤Ë 
((<¤³¤Á¤é|URL:mailto:contact.rubycocoa@fobj.com>)) 
¤Þ¤Ç¤´Ï¢Íí¤¯¤À¤µ¤¤¡£

Æ£ËÜ¾°Ë®, <hisa at fobj.com>, $Date: 2005-10-28 20:03:05 +0900 (é‡‘, 28 10 2005) $
