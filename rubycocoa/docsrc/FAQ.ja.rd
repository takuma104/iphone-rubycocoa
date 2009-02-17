# -*-rd-*-
= RubyCocoa FAQ

== ¥¤¥ó¥¹¥È¡¼¥ë

=== Q: RubyCocoa¤ò"dl file"¤È¤¤¤¦¥Õ¥©¥ë¥À¤Ë¥À¥¦¥ó¥í¡¼¥É¤·¤Æ¥¤¥ó¥¹¥È¡¼
¥ë¤·¤¿¤é¼ºÇÔ¤·¤Þ¤·¤¿¡£

==== A: ´Ö¤Ë¥¹¥Ú¡¼¥¹¤ò´Þ¤à¥Ç¥£¥ì¥¯¥È¥ê¤ËÆþ¤ì¤ÆÅ¸³«¤¹¤ë¤Èconfig¤ÎÅÓÃæ¤Ç
¥¨¥é¡¼¤¬½Ð¤ë¤è¤¦¤Ç¤¹¡£º£¤Þ¤ÇMac¥ª¥ó¥ê¡¼¤Ç¤­¤¿Êý¤ÏÆÃ¤Ë¤´Ãí°Õ¤¯¤À¤µ¤¤¡£
(sawada ¤µ¤ó¤É¤¦¤â)


== ¥¤¥ó¥¹¥È¡¼¥ë´°Î»¸å

=== Q: ¥¤¥ó¥¹¥È¡¼¥ë¤¬´°Î»¤·¤Æ¥µ¥ó¥×¥ë¥¹¥¯¥ê¥×¥È¤ò¼Â¹Ô¤·¤è¤¦¤È¤¹¤ë¤È

  % ruby fontnames.rb
  dyld: ruby Undefined symbols:
  _init_NSDistributedNotificationCenter
  _init_NSScriptStandardSuiteCommands

¤È¤¤¤¦¥¨¥é¡¼¤¬µ¯¤³¤ê¡¢osx/cocoa ¤¬ require ¤Ç¤­¤Þ¤»¤ó¡£

==== A: RubyCocoa¤Îtgz¥Õ¥¡¥¤¥ë¤òStuffIt¤ÇÅ¸³«¤·¤Þ¤·¤¿¤«¡©

RubyCocoa¤Îtgz¥Õ¥¡¥¤¥ë¤òStuffIt¤ÇÅ¸³«¤·¤¿¾ì¹ç¡¢¥½¡¼¥¹¥Õ¥¡¥¤¥ë¤Ë´Þ¤Þ¤ì
¤ë31Ê¸»ú¤ò±Û¤¨¤ëÄ¹¤¤¥Õ¥¡¥¤¥ëÌ¾¤¬ÀÚ¤êµÍ¤á¤é¤ì¤Æ¤·¤Þ¤¤¡¢RubyCocoa¤òÀµ¤·
¤¯ºî¤ë¤³¤È¤¬¤Ç¤­¤Þ¤»¤ó¡£¥¤¥ó¥¹¥È¡¼¥ë¤Î¥É¥­¥å¥á¥ó¥È¤Î¼ê½ç¤É¤ª¤ê¤Ë¥·¥§¥ë
(Terminal¥¢¥×¥ê¥±¡¼¥·¥ç¥ó)¤«¤étar¥³¥Þ¥ó¥É¤ò»È¤Ã¤Æ

  % tar zxf rubycocoa-0.1.0.tgz

¤ÈÆþÎÏ¤·¤Ætgz¥Õ¥¡¥¤¥ë¤òÅ¸³«¤·RubyCocoa¤òºî¤êÄ¾¤·¤Æ¤¯¤À¤µ¤¤¡£

(»ÖÂ¼¤µ¤ó¡¢¾ðÊó¤É¤¦¤â)


== ¤½¤ÎÂ¾

=== Q: ABAddressBook¤Î¤è¤¦¤ËNS¤Ç»Ï¤Þ¤é¤Ê¤¤¥¯¥é¥¹¤Ë¤ÏÂÐ±þ¤·¤Æ¤Ê¤¤¤Î¤Ç¤¹¤«? (2002-09-30)

==== A: 

¤Þ¤º³ÎÇ§¤·¤Æ¤ª¤¯¤Ù¤­¤³¤È¤È¤·¤Æ¡¢RubyCocoa ¤Ï¥Ç¥Õ¥©¥ë¥È¤Ç¤Ï Foundation 
¤È AppKit °Ê³°¤Î¥Õ¥ì¡¼¥à¥ï¡¼¥¯¤ËÆþ¤Ã¤Æ¤ë¥¯¥é¥¹¤ò import ¤·¤Æ¤¤¤Þ¤»¤ó¡£
¤³¤Î¤è¤¦¤Ê¥¯¥é¥¹¤ò»È¤¦¤¿¤á¤Ë¤Ï OSX::NSBundle ¤ò»È¤Ã¤Æ¥Õ¥ì¡¼¥à¥ï¡¼¥¯¤ò
¥í¡¼¥É¤· OSX.ns_import ¤Ç¥¯¥é¥¹¤ò¥¤¥ó¥Ý¡¼¥È¤·¤Þ¤¹¡£

AddressBook.framework ¤Ë´Ø¤·¤Æ¤Ï 0.3.2 ¤Ç¤Ï

  require 'osx/cocoa'
  require 'osx/addressbook'
  abook = OSX::ABAddressBook.sharedAddressBook

¤Ç»ÈÍÑ²ÄÇ½¤Ë¤Ê¤ê¤Þ¤¹¡£¤½¤ì°ÊÁ°¤Î¥Ð¡¼¥¸¥ç¥ó¤Ç¤Ï°Ê²¼¤Î¤è¤¦¤Ë»È¤¦¤³¤È¤¬¤Ç
¤­¤Þ¤¹¡£

  require 'osx/cocoa'
  OSX::NSBundle.bundleWithPath("/System/Library/Frameworks/AddressBook.framework").load
  OSX.ns_import :ABAddressBook
  abook = OSX::ABAddressBook.sharedAddressBook


== ²áµî¤ÎFAQ (2002-12-23¸½ºß)

=== Q: Cocoa¥¢¥×¥ê¼Â¹Ô»þ¤ËConsole¤Ëmalloc¤Ë´Ø¤¹¤ë·Ù¹ð¤¬½Ð¤Þ¤¹

Cocoa¥¢¥×¥ê¼Â¹Ô»þ¡¢Console¤Ë¥á¥â¥ê¥¢¥í¥±¡¼¥·¥ç¥ó¤Ë´Ø¤¹¤ë°Ê²¼¤Î¤è¤¦¤Ê·Ù
¹ð¥á¥Ã¥»¡¼¥¸¤¬½Ð¤ë¤È¤­¤¬¤¢¤ê¤Þ¤¹¡£

  malloc[2461]: Deallocation of a pointer not malloced: 0x2718b20;
  This could be a double free(), or free() called with the middle of
  an allocated block; Try setting environment variable MallocHelp to
  see tools to help debug

==== A: ¸¶°øÉÔÌÀ¤Ç¤Þ¤ÀÌ¤²ò·è¤Ç¤¹ (2002-01-08)

¥ê¥ê¡¼¥¹ 0.1.2¤Ç²ò·è¤·¤¿¤Ä¤â¤ê¤Ç¤·¤¿¤¬¡¢¤Þ¤ÀÈ¯À¸¤·¤Þ¤¹¡£¡Ö¤³¤Î¥Ñ¥¿¡¼¥ó
¤ÇÉ¬¤ºÈ¯À¸¤¹¤ë¡×¤Ê¤É²¿¤«»²¹Í¤Ë¤Ê¤ê¤½¤¦¤Ê¾ðÊó¤¬¤¢¤ì¤ÐÃÎ¤é¤»¤Æ¤¯¤À¤µ¤¤¡£


=== Q: ¥¹¥ì¥Ã¥É¤ò»È¤¦¤È¤¦¤Þ¤¯Æ°¤«¤Ê¤¤¤è¤¦¤Ç¤¹¡£

==== A: 0.2.1 °Ê¹ß¤ò»È¤Ã¤Æ¤¤¤Þ¤¹¤«?

¥ê¥ê¡¼¥¹ 0.2.1 ¤«¤é RubyCocoa ¥¢¥×¥ê¥±¡¼¥·¥ç¥ó¤Ç Ruby ¥¹¥ì¥Ã¥É¤òÆ°¤«¤¹
¤¿¤á¤Î»ÅÁÈ¤ß¤ò¼ÂÁõ¤·¤Æ¤¤¤Þ¤¹¡£0.2.1 °ÊÁ°ÍÑ¤Ëºî¤Ã¤¿ RubyCocoa ¥¢¥×¥ê¤Ç 
Ruby¥¹¥ì¥Ã¥É¤ò»È¤¤¤¿¤¤¾ì¹ç¤Ë¤Ï¡¢rb_main.rb ¤Î ns_app_main ¤ò°Ê²¼¤Î¤è¤¦
¤Ë½¤Àµ¤·¤Æ¤¯¤À¤µ¤¤¡£

  def ns_app_main
    OSX.ruby_thread_switcher_start (0.05)  # switching interval sec
    app = OSX::NSApplication.sharedApplication
    OSX::NSBundle.loadNibNamed_owner (BUNDLE_NAME.to_s, app)
    OSX.NSApp.run
  end

=== Q: ¡Ö¥¢¥×¥ê¥±¡¼¥·¥ç¥ó¤ÏÍ½´ü¤»¤ÌÆ°ºî¤Î¤¿¤á½ªÎ»¡×¥À¥¤¥¢¥í¥°¤¬½Ð¤Þ¤¹

fontname.rb ¤ä sndplay.rb ¤ÏÆ°¤¤¤¿¤Î¤Ç¤¹¤¬¡¢¥µ¥ó¥×¥ë¤ÎRubyCocoa¥¢¥×¥ê
¤ò¼Â¹Ô¤¹¤ë¤È¡Ö¥¢¥×¥ê¥±¡¼¥·¥ç¥ó¤ÏÍ½´ü¤»¤ÌÆ°ºî¤Î¤¿¤á½ªÎ»¤·¤Þ¤·¤¿¡×¤È¤¤¤¦
¥À¥¤¥¢¥í¥°¤¬É½¼¨¤µ¤ì¤Þ¤¹¡£¥³¥ó¥½¡¼¥ë¤ò¸«¤ë¤È

  dyld: /Users/kazusan/rubycocoa-0.1.1/sample/SimpleApp1.app/
  Contents/MacOS/SimpleApp1 Undefined symbols:
  _dlclose
  _dlerror
  _dlopen
  _dlsym

¤È¤¤¤¦¥¨¥é¡¼¥á¥Ã¥»¡¼¥¸¤¬½Ð¤Æ¤¤¤Þ¤¹¡£

==== A: EasyPackage¤Ê¤É¤ÇUNIX·Ï¥½¥Õ¥È¤ò¥¤¥ó¥¹¥È¡¼¥ë¤·¤¿¤³¤È¤Ï¤¢¤ê¤Þ¤¹¤«¡©

¸Å¤¤EasyPackage¤ò¥¤¥ó¥¹¥È¡¼¥ë¤·¤Æ¤¤¤¿¾ì¹ç¤Ê¤É¤Ë /usr/local/lib ¤Ë 
libdl*.bundle ¤È¤¤¤¦Ì¾Á°¤Ç¶¦Í­¥é¥¤¥Ö¥é¥ê¤ò¥ê¥ó¥¯¤¹¤ë¤¿¤á¤Î´Ø¿ô¤ò»ý¤Ä¥é
¥¤¥Ö¥é¥ê¤¬Æþ¤Ã¤Æ¤¤¤Æ¡¢¤½¤Á¤é¤Ë¥ê¥ó¥¯¤µ¤ì¤¿¤ê¤·¤ÆÌäÂê¤¬µ¯¤­¤ë¤è¤¦¤Ç¤¹¡£
²ò·èÊýË¡¤È¤·¤Æ¤Ï

* /usr/local/lib ¥Ç¥£¥ì¥¯¥È¥ê¤«¤é libdl*.bundle ¥Õ¥¡¥¤¥ë¤òºï½ü
* ¤½¤ì¤¾¤ì¤ÎPB¥×¥í¥¸¥§¥¯¥È¤äMakefile¤Î¥ê¥ó¥«¥ª¥×¥·¥ç¥ó¤Ë"-ldl"¤ò»ØÄê

¤Ê¤É¤¬¤¢¤ê¤Þ¤¹¡£

"otool -L"¥³¥Þ¥ó¥É¤ò»È¤Ã¤ÆRubyCocoa¥¢¥×¥ê¥±¡¼¥·¥ç¥ó¤Î¥Ð¥¤¥Ê¥ê¤¬¤É¤Î¶¦
Í­¥é¥¤¥Ö¥é¥ê¤òÉ¬Í×¤È¤¹¤ë¤«³ÎÇ§¤¹¤ë¤³¤È¤¬¤Ç¤­¤ë¤Î¤ÇÌäÂê¤¬È¯À¸¤¹¤ë¤è¤¦¤Ê
¤é³ÎÇ§¤·¤Æ¤ß¤Æ¤¯¤À¤µ¤¤¡£

((<[ruby-talk:29708](±Ñ¸ì)
|URL:http://www.ruby-talk.com/cgi-bin/scat.rb/ruby/ruby-talk/29708>)) 
¤â²ò·è¤Î»²¹Í¤Ë¤Ê¤ë¤«¤â¤·¤ì¤Þ¤»¤ó¡£

=== Q: Project Builder¤Î¿·µ¬¥×¥í¥¸¥§¥¯¥È¤ÇRubyCocoa¥¢¥×¥ê¥±¡¼¥·¥ç¥ó

ÍÑ¤Î¥×¥í¥¸¥§¥¯¥È¤òÁª¤Ó¤¿¤¤¤Î¤Ç¤¹¤¬¡©

==== A: template¥Ç¥£¥ì¥¯¥È¥êÆâ¤ÎÌ¾Á°¤¬"tmpl_pb_"¤Ç»Ï¤Þ¤ë¥Ç¥£¥ì¥¯¥È¥ê

¤ò"/Developer/ProjectBuilder Extras/Project Templates/Application/"¤Î
²¼¤Ë¥³¥Ô¡¼¤·¤Æ"RubyCocoa Application"¤È¤¤¤¦¤è¤¦¤ÊÌ¾Á°¤ËÊÑ¤¨¤Æ¤¯¤À¤µ¤¤¡£

  % cd "/Developer/ProjectBuilder Extras/Project Templates/Application"
  % cp -R {rubycocoa srcdir}/template/tmpl_pb_RubyCocoaApp "RubyCocoa Application"
  % cp -R {rubycocoa srcdir}/template/tmpl_pb_RubyCocoaDocApp "RubyCocoa Doc Application"
  % cd "../../File Templates"
  % cp -R {rubycocoa srcdir}/template/tmpl_pb_RubyFiles Ruby

(»ÖÂ¼¤µ¤ó¡¢¾ðÊó¤É¤¦¤â)


$Date: 2002-12-29 19:36:19 +0900 (æ—¥, 29 12 2002) $
$Revision: 554 $
