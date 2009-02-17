# -*-rd-*-
= RubyCocoa¤ò¥½¡¼¥¹¤«¤é¹½ÃÛ¡¦¥¤¥ó¥¹¥È¡¼¥ë¤¹¤ë

¤³¤ÎÊ¸½ñ¤Ç¤ÏRubyCocoa 0.4.2¤ò¥½¡¼¥¹¤«¤é¹½ÃÛ¡¦¥¤¥ó¥¹¥È¡¼¥ë¤¹¤ëÊýË¡¤Ë¤Ä¤¤¤Æ
ÀâÌÀ¤·¤Þ¤¹¡£¥Ð¥¤¥Ê¥êÇÛÉÕ¤ò¥¤¥ó¥¹¥È¡¼¥ë¤·¤Æ»È¤¦¾ì¹ç¤Ë¤Ï¤È¤¯¤ËÆÉ¤àÉ¬Í×¤Ï¤¢¤ê¤Þ¤»¤ó¡£

¹½ÃÛ¡¦¥¤¥ó¥¹¥È¡¼¥ëºî¶È¤Ï¡¢Terminal¥¢¥×¥ê¥±¡¼¥·¥ç¥ó¤Ê¤É¤«¤é¥·¥§¥ë¥³¥Þ¥ó¥É
¤òÆþÎÏ¤·¤Æ¹Ô¤¤¤Þ¤¹¡£¥·¥§¥ë¥³¥Þ¥ó¥ÉÆþÎÏÎã¤Ë¤Ïbash¤òÁÛÄê¤·¤Æµ­½Ò¤·¤Æ¤¤¤Þ¤¹¡£
¤½¤ÎÂ¾¤Î¥·¥§¥ë(Îã¤¨¤Ðtcsh)¤ò»È¤Ã¤Æ¤¤¤ë¾ì¹ç¡¢Å¬Åö¤ËÆÉ¤ßÊÑ¤¨¤Æ¤¯¤À¤µ¤¤¡£


== ¹½ÃÛ¡¦¥¤¥ó¥¹¥È¡¼¥ë¤Î¼ê½ç

¹½ÃÛ¡¦¥¤¥ó¥¹¥È¡¼¥ë¤Ï¡¢¤ª¤ª¤è¤½°Ê²¼¤Î¤è¤¦¤Ê¼ê½ç¤Ç¹Ô¤¤¤Þ¤¹¡£

  * ((<Ruby¤Î¹½ÃÛ¡¦¥¤¥ó¥¹¥È¡¼¥ë>))
  * ((<RubyCocoa¤Î¹½ÃÛ>))
  * ((<RubyCocoa¤ÎÃ±ÂÎ¥Æ¥¹¥È>))
  * ((<RubyCocoa¤Î¥¤¥ó¥¹¥È¡¼¥ë>))

¤¢¤é¤«¤¸¤á¤É¤³¤«¤ËRubyCocoa¤Î¥½¡¼¥¹¤òÅ¸³«¤·¤Æ¤ª¤¤¤Æ¤¯¤À¤µ¤¤¡£

  $ cd {¤É¤³¤«}
  $ tar zxf rubycocoa-0.4.2.tar.gz

((*Ãí°Õ*)) StuffIt¤ò»È¤¦¤È¥Õ¥¡¥¤¥ëÌ¾¤ÎÄ¹¤µ¤ÎÌäÂê¤ÇRubyCocoa¤¬Àµ¤·¤¯
¥¤¥ó¥¹¥È¡¼¥ë¤µ¤ì¤Ê¤¤¤Î¤Çtar¥³¥Þ¥ó¥É(Mac OS X 10.2¤Ç¤Ïgnutar¥³¥Þ¥ó¥É)¤ò
»È¤Ã¤Æ¤¯¤À¤µ¤¤¡£


== Ruby¤Î¹½ÃÛ¡¦¥¤¥ó¥¹¥È¡¼¥ë

RubyCocoa¤ò¹½ÃÛ¤¹¤ë¤¿¤á¤Ë¤Ï¡¢ºÇÄã¸Âlibruby¤ÈRuby¤ËÉÕ¿ï¤¹¤ëC¸À¸ì¤Î
¥Ø¥Ã¥À¡¼¥Õ¥¡¥¤¥ë¤¬É¬Í×¤È¤Ê¤ê¤Þ¤¹¡£¤³¤³¤Ç¤Ï¼¡¤Ë¼¨¤¹¾ì¹ç¤òÎã¤Ë¡¢
RubyCocoa¤Î¥Ù¡¼¥¹¤È¤Ê¤ëRuby¤Î¹½ÃÛ¼ê½ç¤òÀâÌÀ¤·¤Þ¤¹¡£

  * ¥½¡¼¥¹¤«¤é¥¤¥ó¥¹¥È¡¼¥ë¤·¤¿Ruby 1.8.3
  * Mac OS XÉÕÂ°¤ÎRuby
    * Ruby 1.6.8(Mac OS X 10.3)
    * Ruby 1.6.7(Mac OS X 10.2)

RubyCocoa 0.4.2¥Ð¥¤¥Ê¥ê¥Ñ¥Ã¥±¡¼¥¸¤Ï¡¢2ÈÖÌÜ¤ÎÊýË¡¤Çºî¤é¤ì¤¿¤â¤Î¤Ç¤¹¡£
((<Fink|URL:http://fink.sf.net/>))¤Ê¤É¤Î¥Ñ¥Ã¥±¡¼¥¸¤ò»È¤Ã¤ÆRuby¤ò
¥¤¥ó¥¹¥È¡¼¥ë¤·¤Æ¤¤¤ë¾ì¹ç¤Ê¤É¤Ï¡¢¤½¤ì¤Ë¹ç¤ï¤»¤ÆÆÉ¤ßÊÑ¤¨¤Æ¤¯¤À¤µ¤¤¡£

=== ¥¤¥ó¥¹¥È¡¼¥ë¤µ¤ì¤Æ¤¤¤ëMac OS X¥Ñ¥Ã¥±¡¼¥¸¤Î³ÎÇ§

Mac OS X¤ò¥¤¥ó¥¹¥È¡¼¥ë¤·¤¿»þ¤Î¥ª¥×¥·¥ç¥óÀßÄê¼¡Âè¤Ç¤Ï¡¢É¬Í×¤Ê
¥Ñ¥Ã¥±¡¼¥¸(BSD.pkg¤ÈBSDSDK.pkg)¤¬¥¤¥ó¥¹¥È¡¼¥ë¤µ¤ì¤Æ¤¤¤Ê¤¤²ÄÇ½À­¤¬¤¢¤ê¤Þ¤¹¡£
¤Þ¤º¤Ï¥Ñ¥Ã¥±¡¼¥¸¤¬¥¤¥ó¥¹¥È¡¼¥ë¤µ¤ì¤Æ¤¤¤ë¤«³ÎÇ§¤·¤Æ¡¢É¬Í×¤Ç¤¢¤ì¤Ð¥¤¥ó¥¹¥È¡¼¥ë
¤·¤Æ¤¯¤À¤µ¤¤¡£

  $ ls -dF /Library/Receipts/BSD*.pkg   # ³ÎÇ§
  /Library/Receipts/BSD.pkg/   /Library/Receipts/BSDSDK.pkg/


=== ¥½¡¼¥¹¤«¤é¥¤¥ó¥¹¥È¡¼¥ë¤·¤¿Ruby 1.8.3

Ruby 1.8.3¤Î¥½¡¼¥¹¥Ç¥£¥ì¥¯¥È¥ê¤Ë°ÜÆ°¤·¤Æ¡¢°Ê²¼¤Î¤è¤¦¤Ë¹½ÃÛ¡¦¥¤¥ó¥¹¥È¡¼¥ë
¤·¤Þ¤¹¡£¥ª¥×¥·¥ç¥ó¤ÏÉ¬Í×¤Ë±þ¤¸¤ÆÊÑ¹¹¤·¤Æ¤¯¤À¤µ¤¤¡£
((- CFLAGS¤Ë'-fno-common'¥ª¥×¥·¥ç¥ó¤ò»ØÄê¤·¤Ê¤¤¤È¡¢RubyCocoa.framework
¤¬¥ê¥ó¥¯¤Ç¤­¤Ê¤¤¤è¤¦¤Ç¤¹ -))

  $ CFLAGS='-g -O2 -fno-common' ./configure
  $ make
  $ make test
  $ sudo make install
  $ sudo ranlib /usr/local/lib/libruby-static.a  # 

=== Mac OS X 10.3ÉÕÂ°¤ÎRuby 1.6.8

¤È¤¯¤Ëºî¶È¤ÏÉ¬Í×¤¢¤ê¤Þ¤»¤ó¡£

=== Mac OS X 10.2ÉÕÂ°¤ÎRuby 1.6.7

Mac OS X 10.2¤Ë¤ÏRuby¤¬´Þ¤Þ¤ì¤Æ¤¤¤Þ¤¹¤¬¡¢¤É¤¦¤¤¤¦¤ï¤±¤«libruby
¤¬´Þ¤Þ¤ì¤Æ¤¤¤Þ¤»¤ó¡£¤·¤¿¤¬¤Ã¤Æ¡¢RubyCocoa¤ò¹½ÃÛ¤¹¤ë¤¿¤á¤Ë¤Ï¡¢
Ruby 1.6.7¤Î¥½¡¼¥¹¤«¤élibruby¤òºî¤ëÉ¬Í×¤¬¤¢¤ê¤Þ¤¹¡£

==== Ruby 1.6.7¤Î¥½¡¼¥¹¤Ë¥Ñ¥Ã¥Á¤ò¤¢¤Æ¤ë

¤Þ¤ººÇ½é¤ËRuby 1.6.7¤Îtarball¤òÅ¸³«¤·¤Æ¡¢RubyCocoa¤ËÉÕÂ°¤Î
Ruby 1.6.7ÍÑ¥Ñ¥Ã¥Á¤ò¤¢¤Æ¤Þ¤¹¡£

  $ cd {¤É¤³¤«}
  $ tar zxf ruby-1.6.7.tar.gz
  $ cd ruby-1.6.7
  $ patch -p1 < {RubyCocoa¥½¡¼¥¹}/misc/ruby-1.6.7-osx10.2.patch

==== libruby¤Î¹½ÃÛ¡¦¥¤¥ó¥¹¥È¡¼¥ë

Mac OS XÉÕÂ°Ruby¤Î´Ä¶­¤Ë¹ç¤ï¤»¤ÆRuby 1.6.7¤ò¹½ÃÛ¤·¤Þ¤¹¡£
((- CFLAGS¤Ë'-fno-common'¥ª¥×¥·¥ç¥ó¤ò»ØÄê¤·¤Ê¤¤¤È¡¢RubyCocoa.framework
¤¬¥ê¥ó¥¯¤Ç¤­¤Ê¤¤¤è¤¦¤Ç¤¹ -))

  $ rbhost=`ruby -r rbconfig -e "print Config::CONFIG['host']"`
  $ CFLAGS='-g -O2 -fno-common' ./configure --prefix=/usr --host=$rbhost
  $ make
  $ make test

libruby.a¤Î¤ß¤ò¥¤¥ó¥¹¥È¡¼¥ë¤·¤Þ¤¹¡£

  $ rubyarchdir=`ruby -r rbconfig -e 'print Config::CONFIG["archdir"]'`
  $ sudo install -m 0644 libruby.a $rubyarchdir
  $ sudo ranlib $rubyarchdir/libruby.a


== RubyCocoa¤Î¹½ÃÛ

¼¡¤Î¤è¤¦¤ËÆþÎÏ¤·¤ÆRubyCocoa¤ò¹½ÃÛ¤·¤Þ¤¹¡£

  $ ruby install.rb --help   # ¥ª¥×¥·¥ç¥ó¤Î³ÎÇ§
  $ ruby install.rb config
  $ ruby install.rb setup

((% ruby install.rb config %))¤Ë¤Ï¤¤¤¯¤Ä¤«RubyCocoaÍÑ¤Î¥ª¥×¥·¥ç¥ó¤¬¤¢¤ê¤Þ¤¹¡£
É¬Í×¤Ê¤éconfig¥Õ¥§¡¼¥º¤Î¤È¤­¤Ë¥ª¥×¥·¥ç¥ó¤ò»ØÄê¤·¤Æ¤¯¤À¤µ¤¤¡£

== RubyCocoa¤ÎÃ±ÂÎ¥Æ¥¹¥È

  $ cd {¥½¡¼¥¹}/tests
  $ DYLD_FRAMEWORK_PATH=../framework/build ruby -I../lib -I../ext/rubycocoa testall.rb

Ã±ÂÎ¥Æ¥¹¥È¤Ë¤Ï
((<"Test::Unit"|URL:http://raa.ruby-lang.org/list.rhtml?name=testunit>))
¤¬É¬Í×¤Ç¤¹¡£¤³¤Î¥×¥í¥»¥¹¤Ï¾ÊÎ¬²ÄÇ½¤Ç¤¹¡£
(Test::Unit¤Ï¸½ºßRAA¤«¤é¼èÆÀ¤¹¤ë¤³¤È¤¬¤Ç¤­¤Þ¤»¤ó¡£RubyCocoa¥×¥í¥¸¥§¥¯¥È¤Ç 
((<testunit-0.1.8.tar.gz|URL:http://rubycocoa.sourceforge.net/files/testunit-0.1.8.tar.gz>))
¤Ë¥³¥Ô¡¼¤òÍÑ°Õ¤·¤Æ¤¤¤Þ¤¹¡£)

Test::Unit¤ÏRuby 1.8¤Ç¤ÏÉ¸½àÅºÉÕ¤µ¤ì¤Æ¤¤¤Þ¤¹¡£


== RubyCocoa¤Î¥¤¥ó¥¹¥È¡¼¥ë

  $ sudo ruby install.rb install

°Ê¾å¤Ç¥¤¥ó¥¹¥È¡¼¥ë¤Ï´°Î»¤Ç¤¹¡£¤³¤³¤Þ¤Ç¤Î¼ê½ç¤Ç°Ê²¼¤Î¤â¤Î¤¬¥¤¥ó¥¹¥È¡¼¥ë
¤µ¤ì¤Þ¤·¤¿¡£¡ÊMac OS X 10.3ÉÕÂ°¤ÎRuby 1.6.8¤Ç¹½ÃÛ¤·¤¿¾ì¹ç¡£Ruby¤ª¤è¤Ó
¥·¥¹¥Æ¥à¤Î¥Ð¡¼¥¸¥ç¥ó¤Ë¤è¤ê¡¢¥¤¥ó¥¹¥È¡¼¥ëÀè¤¬Â¿¾¯°Û¤Ê¤ê¤Þ¤¹¡Ë

: /Library/Frameworks/RubyCocoa.framework
  RubyCocoa¥Õ¥ì¡¼¥à¥ï¡¼¥¯ (ËÜÂÎ)

: /usr/lib/ruby/site_ruby/1.6/osx/ ¤ÎÃæ
  RubyCocoa¥é¥¤¥Ö¥é¥ê (stub) 
  - addressbook.rb, appkit.rb, cocoa.rb, foundation.rb

: /usr/lib/ruby/site_ruby/1.6/powerpc-darwin7.0/rubycocoa.bundle
  RubyCocoa³ÈÄ¥¥é¥¤¥Ö¥é¥ê (stub)

: '/Library/Application Support/Apple/Developer Tools/' ¤ÎÃæ
  Xcode¤Î¥Æ¥ó¥×¥ì¡¼¥È
  * 'File Templates/Ruby'
  * 'Project Templates/Application/Cocoa-Ruby Document-based Application'
  * 'Project Templates/Application/Cocoa-Ruby Application'

: '/Developer/ProjectBuilder Extras/' ¤ÎÃæ
  ProjectBuilder¤Î¥Æ¥ó¥×¥ì¡¼¥È
  * 'File Templates/Ruby'
  * 'Project Templates/Application/Cocoa-Ruby Document-based Application'
  * 'Project Templates/Application/Cocoa-Ruby Application'

: /Developer/Documentation/RubyCocoa
  ¥É¥­¥å¥á¥ó¥È (HTML)

: /Developer/Examples/RubyCocoa
  ¥µ¥ó¥×¥ë¥×¥í¥°¥é¥à


((<¡ÖÉÕÂ°¥µ¥ó¥×¥ë¤ò»î¤·¤Æ¤ß¤ë¡×|URL:trysamples.ja.html>)) ¤ò»²¹Í¤Ë
Æ°ºî³ÎÇ§¤·¤Æ¤ß¤Æ¤¯¤À¤µ¤¤¡£


== [FYI] ¥Ð¥¤¥Ê¥ê¥Ñ¥Ã¥±¡¼¥¸¥ó¥°¤ËÊØÍø¤Ê¥¤¥ó¥¹¥È¡¼¥ë¥ª¥×¥·¥ç¥ó

RubyCocoa¤Î¥Ð¥¤¥Ê¥ê¥Ñ¥Ã¥±¡¼¥¸¤òºî¤ë¤È¤­¤ËÊØÍø¤Ê'ruby install.rb
config'¤Î¥ª¥×¥·¥ç¥ó¤¬¤¢¤ê¤Þ¤¹¡£

  * --install-prefix : 
    ³ÈÄ¥¥é¥¤¥Ö¥é¥ê¤È¥é¥¤¥Ö¥é¥ê¤Î¥¤¥ó¥¹¥È¡¼¥ëÀè¤Ë±Æ¶Á
  * --install-root :
    ¥Õ¥ì¡¼¥à¥ï¡¼¥¯¡¦¥Æ¥ó¥×¥ì¡¼¥È¡¦¥É¥­¥å¥á¥ó¥È¡¦¥µ¥ó¥×¥ë¤Î¥¤¥ó¥¹¥È¡¼¥ëÀè¤Ë±Æ¶Á

=== Îã

  $ ruby -r rbconfig -e 'p Config::CONFIG["prefix"]'
  "/usr"
  $ ruby install.rb config \
      --install-prefix=/tmp/build/usr --install-root=/tmp/build
  $ ruby install.rb setup
  $ sudo ruby install.rb install

·ë²Ì¤È¤·¤Æ°Ê²¼¤Î¾ì½ê¤Ë(µ¿»÷)¥¤¥ó¥¹¥È¡¼¥ë¤µ¤ì¤Þ¤¹¡£

  /tmp/build/usr/lib/ruby/site_ruby/1.6/osx/addressbook.rb
  /tmp/build/usr/lib/ruby/site_ruby/1.6/osx/appkit.rb
  /tmp/build/usr/lib/ruby/site_ruby/1.6/osx/cocoa.rb
  /tmp/build/usr/lib/ruby/site_ruby/1.6/osx/foundation.rb
  /tmp/build/usr/lib/ruby/site_ruby/1.6/powerpc-darwin6.0/rubycocoa.bundle
  /tmp/build/Library/Frameworks/RubyCocoa.framework
  /tmp/build/Developer/ProjectBuilder Extras/File Templates/Ruby
  /tmp/build/Developer/ProjectBuilder Extras/Project Templates/ \
          Application/Cocoa-Ruby Application
  /tmp/build/Developer/ProjectBuilder Extras/Project Templates/ \
          Application/Cocoa-Ruby Document-based Application
  /tmp/build/Developer/Examples/RubyCocoa
  /tmp/build/Developer/Documentation/RubyCocoa


== ³«È¯Æ°ºî³ÎÇ§´Ä¶­

°Ê²¼¤Î´Ä¶­¤Ç³«È¯Æ°ºî³ÎÇ§¤ò¤·¤Æ¤¤¤Þ¤¹¡£

* iBook G3/900/640MB
* Mac OS X 10.4.2
  * XcodeTools 2.0/2.1
  * ruby-1.8.2 (pre-installed in Mac OS X 10.4)
  * ruby-1.8.3
* Mac OS X 10.3.8
  * XcodeTools 1.5
  * ruby-1.6.8 (pre-installed in Mac OS X 10.3)
  * ruby-1.8.3
* Mac OS X 10.2.8
  * DevTools 10.2
  * ruby-1.6.7 (pre-installed in Mac OS X 10.2)
  * ruby-1.8.3

== ¤Ç¤Ï¤ª³Ú¤·¤ß¤¯¤À¤µ¤¤

´¶ÁÛ¡¢¥¢¥¤¥Ç¥¢¡¢Äó°Æ¡¢µ¿Ìä¡¢¼ÁÌä¤Ê¤É¤Ê¤ó¤Ç¤âµ¤·Ú¤Ë¶µ¤¨¤Æ¤¯¤À¤µ¤¤¡£


$Date: 2005-11-06 16:49:17 +0900 (æ—¥, 06 11 2005) $
