# -*-rd-*-
= RubyCocoaе╫еэе░еще▀еєе░

== ╠▄╝б

* ((<irb - едеєе┐б╝ещепе╞еге╓ Ruby>))
* ((<ещеде╓ещеъд╬еэб╝е╔>))
* ((<╞░ддд┐╝┬┤╢дЄ╠гдядиды╬у>))
* ((<Cocoaепеще╣>))
* ((<Cocoaеке╓е╕езепе╚д╬└╕└о>))
* ((<екб╝е╩б╝е╖е├е╫д╚есетеъ┤╔═¤>))
* ((<есе╜е├е╔д╬╩╓д╣├═>))
* ((<есе╜е├е╔╠╛д╬╖ш─ъ╩¤╦бд╚е╨еъеиб╝е╖ечеє>))
* ((<есе╜е├е╔д╬░·┐Їд╧▓─╟╜д╩╕┬дъ╩╤┤╣д╣ды>))
* ((<есе╜е├е╔╠╛дм╜┼╩гд╣дыд╚днд╦╗╚дж└▄╞м╝н "oc_">))
* ((<Cocoaепеще╣д╬╟╔└╕епеще╣д╚д╜д╬едеєе╣е┐еєе╣>))
* ((<Cocoa╟╔└╕епеще╣д╬─ъ╡┴>))
* ((<евеже╚еье├е╚>))
* ((<есе╜е├е╔д╬екб╝е╨б╝ещеде╔>))
* ((<Cocoa╟╔└╕епеще╣д╬едеєе╣е┐еєе╣└╕└о>))
* ((<едеєе╣е┐еєе╣└╕└о╗■д╬╜щ┤№▓╜е│б╝е╔д╧д╔д│д╦╜ёдпд┘дндл?>))
* ((<RubyCocoaеве╫еъе▒б╝е╖ечеєд╬е╟е╨е├е░>))


== irb - едеєе┐б╝ещепе╞еге╓ Ruby

д│д│д╦двдые╣епеъе╫е╚д╬└┌дь├╝дЄ╗юд╖д╞д▀дыд╬д╦ irb дЄ╗╚джд╚дшддд╟д╖дчджбг
irb д╧е│е▐еєе╔ещедеєд╟┬╨╧├┼кд╦ Ruby едеєе┐б╝е╫еъе┐дЄ╗╚дж Ruby╔╒┬░д╬е│
е▐еєе╔д╟д╣бг░╩▓╝д╬дшдж╡п╞░д╖д▐д╣бг

  % irb -r osx/cocoa

(├э) Mac OS X 10.1 д╟д╧ irb д╚ RubyCocoa дЄддд├д╖дчд╦╗╚джд╚д╖д╨д╖д╨
е╨е╣еиещб╝дм╚п└╕д╖д▐д╣бгMac OS X 10.2 д▐д┐д╧д╜дь░╩╣▀д╟д╬╗╚═╤дЄдк┤лдсд╖д▐д╣бг

== ещеде╓ещеъд╬еэб╝е╔

RubyCocoaд╬ещеде╓ещеъд╧░╩▓╝д╬дшджд╦еэб╝е╔д╖д▐д╣бг

  require 'osx/cocoa'


== ╞░ддд┐╝┬┤╢дЄ╠гдядиды╬у

д▐д║д╧╞░ддд┐╝┬┤╢дЄ╠гдядиды(▓╗дм╠─ды)┤╩├▒д╩╬уд╟д╣бгirb дЄ╗╚д├д╞╗юд╖д╞д▀
д▐д╖дчджбг

  include OSX
  files = `ls /System/Library/Sounds/*.aiff`.split
  NSSound.alloc.initWithContentsOfFile_byReference (files[0], true).play
  NSSound.alloc.initWithContentsOfFile_byReference (files[1], true).play
  NSSound.alloc.initWithContentsOfFile_byReference (files[2], true).play

░╩╣▀д╧бв├╧╠гд└д▒д╔═¤▓Єд╬╜їд▒д╦д╩дыд╚╗╫дядьды╬удЄдвд▓д╞ддднд▐д╣бг└т╠└д╬
├цд╟ "# => "д╬▒ж┬жд╧╝┬╣╘╖ы▓╠д╚д╖д╞╔╕╜р╜╨╬╧д╡дьды╩╕╗·╬єд╟д╣бг

== Cocoaепеще╣

  p OSX::NSObject # => OSX::NSObject
  obj = OSX::NSObject.description
  p obj      # => #<OSX::OCObject:0x5194e8 class='NSCFString' id=A97910>
  obj = OSX::NSObject.alloc.init
  p obj      # => #<OSX::NSObject:0x51f5b4 class='NSObject' id=976D90>

RubyCocoaд╟д╧бвCocoaепеще╣д╧OSXете╕ехб╝еы╟█▓╝д╬епеще╣д╚д╖д╞─ъ╡┴д╡дьд╞
ддд▐д╣(0.2.0░╩╣▀)бгCocoaепеще╣д╧Rubyд╬епеще╣д╟двдыд╚╞▒╗■д╦Cocoaд╬еке╓
е╕езепе╚д╚д╖д╞дт┐╢ды╔ёддд▐д╣бг


== Cocoaеке╓е╕езепе╚д╬└╕└о

Cocoaеке╓е╕езепе╚д╬└╕└од╦д╧бвCocoaд╬│╞епеще╣д╬есе╜е├е╔дЄд╜д╬д▐д▐╗╚ддд▐
д╣бг

  obj = OSX::NSObject.alloc.init
  str = OSX::NSString.stringWithString "hello"
  str = OSX::NSString.alloc.initWithString "world"

└╕└од╡дьд┐Cocoaеке╓е╕езепе╚д╧бвRubyCocoa╞т╔Їд╟OSX::ObjcIDд╚ддджепеще╣
д╬еке╓е╕езепе╚д╦╩ёд▐дьд╞ддд▐д╣бг─╠╛ябвOSX::ObjcIDепеще╣д╬┬╕║▀дЄ░╒╝▒д╣
ды╔м═╫д╧двдъд▐д╗дєбг


== екб╝е╩б╝е╖е├е╫д╚есетеъ┤╔═¤

OSX::ObjcIDд╬едеєе╣е┐еєе╣д╧длд╩дщд║╝л┐╚дм╩ёдєд╟дддыCocoaеке╓е╕езепе╚д╬
екб╝е╩б╝е╖е├е╫дЄ╗¤д┴д▐д╣бгекб╝е╩б╝е╖е├е╫д╧OSX::ObjcIDд╬едеєе╣е┐еєе╣дм
GCд╦┴▌╜№д╡дьдыд╚днд╦╝л╞░┼кд╦д╩дпд╩дъд▐д╣бгд╖д┐дмд├д╞RubyCocoaд╟д╧бвекб╝
е╩б╝е╖е├е╫д╩д╔д╬есетеъ┤╔═¤дЄ╡дд╦д╣ды╔м═╫д╧двдъд▐д╗дєбгд▐д┐бв─╠╛я
OSX::ObjcIDд╚ддджепеще╣д╬┬╕║▀дЄ░╒╝▒д╣ды╔м═╫дтдвдъд▐д╗дєбг

  str = OSX::NSString.stringWithString "hello"
  str = OSX::NSString.alloc.initWithString "world"

╛х╡нг▓╣╘д╧бвObjective-Cд╟д╧екб╝е╩б╝е╖е├е╫дЄ╚п└╕д╡д╗дыдлд╡д╗д╩дддлд╚дд
дж░удддмдвдъд▐д╣дмбвекб╝е╩б╝е╖е├е╫дЄ░╒╝▒д╣ды╔м═╫д╬д╩дд RubyCocoa д╟д╧
д┐ддд╖д╞░удддмдвдъд▐д╗дєбгreleaseбвautoreleaseбвretainд╩д╔д╬есе╜е├е╔д╧
┤Ё╦▄┼кд╦╕╞д╓╔м═╫д╧двдъд▐д╗дєд╖бвNSAutoreleasePoolдЄ║юды╔м═╫дтдвдъд▐д╗
дєбг

* Cocoaеке╓е╕езепе╚д╬└╕└од╦д╧Cocoaепеще╣д╦┬╨д╖д╞Cocoaд╬есе╜е├е╔дЄ╗╚дж
* Cocoaеке╓е╕езепе╚д╧║юдъд├д╤д╩д╖д╟╬╔ддбвесетеъ┤╔═¤д╧╔╘═╫

== есе╜е├е╔д╬╩╓д╣├═

  nstr = OSX::NSString.description
  p nstr      # => #<OCObject:0x7233e class='NSCFString' id=687610>
  p nstr.to_s # => "NSString"

  nstr = OSX::NSString.stringWithString "Hello World !"
  p nstr      # => #<OCObject:0x71970 class='NSCFString' id=688E90>
  p nstr.to_s # => "Hello World !"

  nstr = OSX::NSString.stringWithString(`pwd`.chop)
  nary = nstr.pathComponents
  p nary      # => #<OCObject:0x6bb2e class='NSCFArray' id=3C0150>

  ary = nary.to_a
  p ary       # => [#<OCObject:0x6a9b8 class='NSCFString' id=3C2B50>,...]

  ary.map! {|i| i.to_s }
  p ary       # => ["/", "Users", "hisa", "src", "ruby", "osxobjc"]

д│дьдщд╬╬удлдщ┐ф┬мд╟дндыдшджд╦RubyCocoaд╟д╧бвNSStringдфNSArrayд╩д╔
Objective-Cеке╓е╕езепе╚дЄ╩╓д╣есе╜е├е╔дЄCocoaеке╓е╕езепе╚д╚д╖д╞╩╓д╖д▐д╣бг
└╤╢╦┼кд╦Rubyд╬┬╨▒■д╣дыеке╓е╕езепе╚(╬удид╨Stringд╩д╔)д╦д╧╩╤┤╣д╖д▐д╗дєбг
╩╕╗·╬єд╚╟█╬єд╦┤╪д╖д╞д╧ to_s дф to_a дм─ъ╡┴д╡дьд╞дддыд╬д╟д╜дьдЄ╗╚джд│д╚
дмд╟днд▐д╣бг


== есе╜е├е╔╠╛д╬╖ш─ъ╩¤╦бд╚е╨еъеиб╝е╖ечеє

  # е╖е╣е╞ер▓╗дЄ╜ч╚╓д╦╠─дщд╣ (2)
  sndfiles.each do |path|
    snd = OSX::NSSound.alloc.initWithContentsOfFile(path, :byReference, true)
    snd.play
    sleep 0.25 while snd.isPlaying?
  end

д│дьд╧д╡днд█д╔╝ид╖д┐▓╗дЄд╩дщд╣╬уд╬╩╠е╨б╝е╕ечеєд╟д╣бгObjective-Cд╬есе├
е╗б╝е╕е╗еьепе┐д╚░·┐ЇдЄRuby╔ўд╦╔╜╡нд╣ды╩╠д╬╩¤╦бдЄ╝ид╖д╞ддд▐д╣бг
Objective-Cд╬

  [obj hogeAt: a0 withParamA: a1 withParamB: a2]

д╦┬╨д╖д╞дддпд─длд╬╕╞д╙╜╨д╖╩¤╦бдм═╤░╒д╡дьд╞ддд▐д╣бг┤Ё╦▄д╧бвесе├е╗б╝е╕е╗
еьепе┐д╬":"дЄ"_"д╦├╓дн┤╣дид┐дтд╬дмRuby┬жд╟д╬есе╜е├е╔╠╛д╚д╩дъд▐д╣бг

  obj.hogeAt_withParamA_withParamB_ (a0, a1, a2)

д┐д└д╖бвд│д╬д▐д▐д╟д╧еле├е│░нд╣дод╩д╬д╟║╟╕хд╬"_"д╧╛╩╬мд╣дыд│д╚дмд╟днд▐
д╣бг

  obj.hogeAt_withParamA_withParamB (a0, a1, a2)

д▐д┐─╣ддесе╜е├е╔╠╛д╬╛ь╣чд╩д╔бвесе├е╗б╝е╕е╗еьепе┐д╬енб╝еяб╝е╔д╚░·┐Їд╬┤╪
╖╕дмдядлдъд╦дпддд┐дсбвдвд▐дъ╚■д╖дпдвдъд▐д╗дєдмбв╢ь╞∙д╬║Ўд╚д╖д╞╝бд╬дшдж
д╩╩¤╦бдт╗╚джд│д╚дмд╟днд▐д╣бг

  obj.hogeAt (a0, :withParamA, a1, :withParamB, a2)

BOOLдЄ╩╓д╣есе╜е├е╔(╜╥╕ь)д╬╛ь╣чд╦д╧бвесе╜е├е╔╠╛д╬║╟╕хд╦"?"дЄ╔╒д▒д╞дпд└
д╡ддбгRubyCocoaд╟д╧бв'?'д╬═н╠╡д╟есе╜е├е╔дм╧└═¤├═дЄ╩╓д╣дтд╬длд╔дждл╚╜
├╟д╖д╞ддд▐д╣бг╔╒д▒д╩дд╛ь╣чд╦д╧Objective-Cдм╩╓д╖д┐┐Ї├═(0:NO, 1:YES)дм╩╓
дъд▐д╣дмбвд│дьдщд╬├═д╧Ruby д╬╧└═¤├═д╚д╖д╞д╔д┴дщдт┐┐д╦д╩дъд▐д╣бг

  nary = OSX::NSMutableArray.alloc.init
  p nary.containsObject("hoge")   # => 0
  p nary.containsObject?("hoge")  # => false
  nary.addObject("hoge")
  p nary.containsObject("hoge")   # => 1
  p nary.containsObject?("hoge")  # => true


== есе╜е├е╔д╬░·┐Їд╧▓─╟╜д╩╕┬дъ╩╤┤╣д╣ды

╛хд╬╬уд╬containsObjectд╬дшджд╦бв░·┐Їд╬├═д╚д╖д╞Objective-Cеке╓е╕езепе╚
дЄд╚дыесе╜е├е╔д╬╛ь╣чд╦бвRubyеке╓е╕езепе╚дЄд╜д╬д▐д▐┼╧д╖д╞дт▓─╟╜д╩╕┬дъ╩╤
┤╣дЄ╗юд▀д▐д╣бг


== есе╜е├е╔╠╛дм╜┼╩гд╣дыд╚днд╦╗╚дж└▄╞м╝н "oc_"

  klass = OSX::NSObject.class
  p klass     # => Class
  klass = OSX::NSObject.oc_class
  p klass     # => OSX::NSObject

"Object#class"д╬дшджд╦Rubyд╚Objective-Cд╟есе╜е├е╔╠╛(е╗еьепе┐)дм┴┤дп╞▒
д╕╛ь╣чд╦д╧бвRubyд╬есе╜е├е╔дм╕╞д╨дьд▐д╣бгд│д╬дшджд╩╛ь╣чд╦д╧бвесе╜е├е╔╠╛
д╬╞мд╦"oc_"д╚дддж└▄╞м╝ндЄд─д▒дыд╚бвObjective-Cеке╓е╕езепе╚д╦┬╨д╖д╞есе├
е╗б╝е╕дм┴ўдщдьд▐д╣бг"oc_" дЄ╔╒д▒д╞дтRuby┬жд╦есе╜е├е╔дмдвды╛ь╣чд╧бйд╔дж
д╖дшдждтдвдъд▐д╗дє(╬в╡╗д╧двдыд╬д╟е╜б╝е╣дЄ╞╔дсды┐═д╧д╔джд╛) бг


== Cocoaепеще╣д╬╟╔└╕епеще╣д╚д╜д╬едеєе╣е┐еєе╣

д│д│д▐д╟д╧┤√┬╕д╬Cocoaепеще╣д╚д╜д╬едеєе╣е┐еєе╣д╦┤╪д╣дые╚е╘е├епдЄ░╖ддд▐
д╖д┐бгд│д│длдщд╧бвRubyCocoaеве╫еъе▒б╝е╖ечеєдЄ╜ёдп╛ь╣чд╦╔м═╫д╚д╩дыCocoa 
╟╔└╕епеще╣д╬─ъ╡┴дфд╜д╬едеєе╣е┐еєе╣д╦┤╪д╣дые╚е╘е├епдЄ░╖ддд▐д╣бгCocoaд╬
╟╔└╕епеще╣д╧дфдфе╚еъе├енб╝д╩╝┬┴їд╦дшдъ╝┬╕╜д╖д╞дддыд┐дсбв┬┐╛пд╬└й╠єдф╩╩
дмдвдъд▐д╣дмбвд╜дьдт┤▐дсд╞╕лд╞ддднд▐д╖дчджбг


== Cocoa╟╔└╕епеще╣д╬─ъ╡┴

Interface Builderд╟║ю└од╖д┐GUI─ъ╡┴е╒ебедеы(nibе╒ебедеы)д╬├цд╟└▀─ъд╖д┐
Cocoaеке╓е╕езепе╚д╬епеще╣д╩д╔д╧╟╔└╕епеще╣д╚д╖д╞─ъ╡┴д╖д▐д╣(0.2.0░╩╣▀)бг
╬удид╨Cocoaд╬╞■╠ч╜ёдфе┴ехб╝е╚еъевеыд╩д╔д╟║╟╜щд╬╩¤д╦╜╨д╞дпдыдшджд╩MVCет
е╟еыд╬е│еєе╚еэб╝ещд╧

  class AppController < OSX::NSObject

    ib_outlets :messageField

    def btnClicked(sender)
      @messageField.setStringValue "Merry Xmas !"
    end

  end

д╬дшджд╦─ъ╡┴д╖д▐д╣бгRubyCocoaд╦дкд▒дыCocoaд╬╟╔└╕епеще╣─ъ╡┴д╧бвд│д╬дшдж
д╦─╠╛яд╬Rubyд╟д╬╟╔└╕епеще╣─ъ╡┴д╚╞▒══д╦╡н╜╥д╖д▐д╣бг


== евеже╚еье├е╚

nibе╒ебедеы├цд╟епеще╣д╦└▀─ъд╖д┐евеже╚еье├е╚д╧╟╔└╕епеще╣д╬─ъ╡┴д╬├цд╟

  ns_outlets :rateField, :dollerField

д╚╜ёднд▐д╣бгns_outletsд╧╝┬║▌д╦д╧ Module#attr_writer д╚╞▒д╕д╟д╣бгд╖д┐дмд├
д╞┬хдядъд╦

  def rateField= (new_val)
    @rateField = new_val
  end

д╬дшджд╦─ъ╡┴д╣дыд│д╚дтд╟днд▐д╣бгns_outlets д╦д╧ ib_outlets д╚дддж╩╠╠╛
дтдвдъд▐д╣бг


== есе╜е├е╔д╬екб╝е╨б╝ещеде╔

┐╞епеще╣д╟─ъ╡┴д╡дьд╞дддыесе╜е├е╔дЄекб╝е╨б╝ещеде╔д╣ды╛ь╣чбвns_overrides
(╩╠╠╛ib_overrides)дЄ╗╚д├д╞екб╝е╨б╝ещеде╔д╖д┐д│д╚дЄ└ы╕└д╣ды╔м═╫дмдвдъд▐
д╣бг

  class MyCustomView < OSX::NSView
    ns_overrides :drawRect_, 'mouseUp:'

    def drawRect(frame)
    end

    ...
  end

ns_overrides д╬░·┐Їд╦д╧ Objective-C д╬есе├е╗б╝е╕е╗еьепе┐дЄ╩╕╗·╬єд▐д┐д╧
е╖еєе▄еыд╟╔╜╕╜д╖д┐дтд╬дЄ═┐дид▐д╣бгд┐д└д╖б╓есе╜е├е╔╠╛д╬╖ш─ъ╩¤╦бд╚е╨еъеиб╝
е╖ечеєб╫д╟└т╠└д╖д┐╦Ў╚°дЄ╛╩╬мд╣ды╡н╦бдЄ╗╚джд│д╚д╧д╟днд▐д╗дєбг░·┐Їд╬┐Їд╦
╣чдяд╗д╞└╡│╬д╦╡н╜╥д╣ды╔м═╫дмдвдъд▐д╣бг

екб╝е╨б╝ещеде╔д╖д╞дддыесе╜е├е╔д╬─ъ╡┴д╬├цд╟е╣б╝е╤б╝епеще╣д╬╞▒д╕есе╜е├е╔
дЄ╕╞д╓╛ь╣чд╦д╧есе╜е├е╔╠╛д╦ "super_" └▄╞м╝ндЄ╔╒д▒д╞╕╞д╙д▐д╣бг

  class MyCustomView < OSX::NSView

    ns_overrides :drawRect_

    def drawRect (frame)
      p frame
      super_drawRect(frame)   # NSViewд╬drawRectдЄ╝┬╣╘
    end

  end


== Cocoa╟╔└╕епеще╣д╬едеєе╣е┐еєе╣└╕└о

Cocoa╟╔└╕епеще╣д╬едеєе╣е┐еєе╣дЄRubyе╣епеъе╫е╚├цд╟└╕└од╣ды╔м═╫дмдвды╛ь
╣чд╦д╧бв┤√┬╕д╬Cocoaепеще╣д╬╛ь╣чд╚╞▒══д╦

  AppController.alloc.init  # use this

д╬дшджд╦╜ёднд▐д╣бгRubyд╟д╬дтд├д╚дт░ь╚╠┼кд╩╜ёдн╩¤д╟двды

  AppController.new  # don't use this

дЄ╗╚джд│д╚д╧д╟днд▐д╗дє(╬у│░дЄ╚п└╕д╣дыдшджд╦д╖д╞двдъд▐д╣)бгд│дьд╦д╧дддэ
дддэ╗Ў╛Ёдмдвдыд╬д╟д╣дм─╣дпд╩дыд╬д╟д│д│д╟д╧╛▄д╖дд└т╠└д╧╛╩днд▐д╣бгд│д╬└й
╠єд╧едеєе╣е┐еєе╣└╕└одм

  * alloc (Objective-C┬ж)
  * alloc╞тд╟Rubyеке╓е╕езепе╚└╕└о(д│д│д╟initializeесе╜е├е╔дм╕╞д╨дьды)

д╚дддж╜ч╚╓д╟╣╘дядьдыд│д╚д╦┐╝дд┤╪╧вдмдвдъд▐д╣бг


== едеєе╣е┐еєе╣└╕└о╗■д╬╜щ┤№▓╜е│б╝е╔д╧д╔д│д╦╜ёдпд┘дндл?

░ь╚╠д╦Rubyд╟д╧initializeесе╜е├е╔д╬├цд╦╜щ┤№▓╜д╬е│б╝е╔дЄ╜ёднд▐д╣дмбв
Cocoa╟╔└╕епеще╣д╟д╧д╔д┴дщдлдддид╨двд▐дъ╛йдсдщдьд▐д╗дєбг═¤═│д╧└шд╦╜╥д┘
д┐едеєе╣е┐еєе╣└╕└о╗■д╬initializeесе╜е├е╔дм╕╞д╨дьдые┐еде▀еєе░д╦дшдъбвд╜
д╬╗■┼└д╟Cocoaеке╓е╕езепе╚д╚д╖д╞д╧есетеъдм│фдъ┼Ўд╞дщдьд┐д└д▒д╟╜щ┤№▓╜д╡
дьд╞ддд╩дддлдщд╟д╣бгдтд├д╚дтCocoa┬жесе╜е├е╔дЄ╕╞д╨д╩дд╕┬дъд╦дкддд╞д╧д╚
дпд╦╠ф┬ъд╧╚п└╕д╖д╩ддд╚╣═дидщдьд▐д╣бг

nibе╒ебедеыдлдщеэб╝е╔д╡дьдыдшджд╩╛ь╣чд╦д╧ awakeFromNib есе╜е├е╔д╟╜щ┤№
▓╜д╣дыд╬дмдтд├д╚дт╠╡╞ёд╟д╣бг╝┬║▌д╦Cocoaд╬╟╔└╕епеще╣дЄ─ъ╡┴д╣ды╔м═╫дмдв
дыд╬дтд│д╬е▒б╝е╣дмдтд├д╚дт┬┐ддд╬д╟д╧д╩ддд╟д╖дчдждлбг

д╜д╬┬╛д╬╛ь╣чд╦д╧бвCocoaд╬╬о╡╖д╟ "init" └▄╞м╝ндЄ╗¤д─есе╜е├е╔д╦╜ёдпд╬дм
дшддд╟д╖дчджбгесе╜е├е╔дмselfдЄ╩╓д╣дшджд╦д╣дыд│д╚дЄ╦║дьд╩ддд╟дпд└д╡ддбг


== RubyCocoaеве╫еъе▒б╝е╖ечеєд╬е╟е╨е├е░

║гд╬д╚д│дэ(2003-01-05)бвRubyCocoaеве╫еъе▒б╝е╖ечеєд╦┬╨▒■д╣ды
ProjectBuilderд╬е╫еще░едеєете╕ехб╝еыдм┬╕║▀д╖д╩ддд┐дсбвProjectBuilder╛х
д╟Rubyд╬е╟е╨е├емдЄ╗╚джд│д╚д╧д╟днд▐д╗дєбг

д╖длд╖бвRubyCocoaеве╫еъе▒б╝е╖ечеєдЄе╖езеыд╩д╔длдщеке╫е╖ечеє╔╒днд╟╡п╞░
д╣дыд│д╚д╦дшдъбвRubyд╦╔╒┬░д╬е╟е╨е├емд╩д╔дЄ╗╚джд│д╚д╧▓─╟╜д╟д╣бгEmacs╗╚
ддд╟двдьд╨бвrubydbе│е▐еєе╔дЄ╗╚д├д╞е╟е╨е├е░д╟днд▐д╣бг

░╩▓╝д╧бвsimpleapp(е╡еєе╫еы)дЄ┬ъ║рд╦бвRuby╔╒┬░е╟е╨е├емдЄ╗╚д├д╞RubyCocoa 
еве╫еъе▒б╝е╖ечеєдЄе╓еьб╝епд╡д╗дыд╚днд╬══╗╥д╟д╣бг

  $ cd sample/simpleapp/
  $ pbxbuild
  $ build/SimpleApp.app/Contents/MacOS/SimpleApp -r debug
  (rdb:1) b AppController.rb:24    # е╓еьб╝епе▌едеєе╚дЄ└▀─ъ
  Set breakpoint 1 at AppController.rb:24
  (rdb:1) c
  Breakpoint 1, aboutApp at AppController.rb:24
  AppController.rb:24:
  (rdb:1) l
  [19, 28] in AppController.rb
     19      @myView.set_alpha(@slider.floatValue)
     20      @myView.set_color(@colorWell.color)
     21    end
     22  
     23    def aboutApp (sender)
  => 24      NSApp().orderFrontStandardAboutPanelWithOptions(
     25        "Copyright" => "RubyCocoa #{RUBYCOCOA_VERSION}",
     26        "ApplicationVersion" => "Ruby #{VERSION}")
     27    end
     28  
     29    def colorBtnClicked (sender)
  (rdb:1) sender
  #<OSX::NSMenuItem:0xd439e class='NSMenuItem' id=0x3e27d0>
  (rdb:1) q
  Really quit? (y/n) y


$Date: 2005-09-01 01:10:34 +0900 (цЬи, 01  9 2005) $
