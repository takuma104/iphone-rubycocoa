require 'uconv'
require 'kconv'
require 'rexml/document'
require 'rd/rd2html-lib'
require 'rd/rdfmt'

module REXML

  class Element

    def find_attribute( key, val )
      return self if attributes[key] == val
      self.each_element do |elm|
	ret = elm.find_attribute( key, val )
	return ret if ret
      end
      return nil
    end

  end
end

class PageTemplate

  def initialize (tmpl_name)
    src = File.open(tmpl_name){|f|f.read}
    @doc = REXML::Document.new(src)
  end

  def write_to_file(fname)
    File.open(fname, 'w') {|f| f.write(@doc.to_s) }
    self
  end

  def set_title (str)
    if not str.nil? then
      str = 'RubyCocoa - ' << str
      @doc.root.elements["head/title"].text = Uconv::euctou8(str.toeuc)
      nil
    end
  end

  def set_contents( elm )
    replace_elements( 'id', 'body-contents', elm )
  end

  def replace_elements (src_key, src_val, new_elm)
    target = @doc.find_attribute( src_key, src_val )
    if target then
      target.to_a.each {|i| target.delete(i) }
      new_elm.each do |i|
	if i.respond_to? :deep_clone then
	  target.add(i.deep_clone)
	else
	  target.add(i.clone)
	end
      end
    end
    nil
  end

  def set_lang( lang )
    enc = nil
    if lang == 'ja'
      enc = 'euc-jp'
    else
      lang = 'en'
      enc = 'us-ascii'
    end
    @doc.xml_decl.encoding = enc
    @doc.root.attributes['lang'] = lang
    @doc.root.attributes['xml:lang'] = lang
    @doc.elements['html/head/meta[@http-equiv="Content-type"]'].
      attributes['content'] = "text/html; charset=#{enc}"
    @doc.elements['html/head/meta[@name="Content-Language"]'].attributes['content'] = lang
  end

  def inspect
    return super[0..80]
  end

  def to_s
    @doc.to_s
  end

end				# class PageTemplate



class RDDocument

  attr_reader :src_name, :title, :body, :lang, :charset

  def initialize( fname, lang, charset )
    @src_name = fname
    @lang = lang
    @charset = charset

    rd2(fname, "/tmp/rubycocoahoge")
    xml_src = `cat /tmp/rubycocoahoge`
    command 'rm -f /tmp/rubycocoahoge'
    @doc = REXML::Document.new(xml_src)
    @body = @doc.elements['html/body']
    elm_h1 = @body.elements['h1']
    if elm_h1 then
      @title = Uconv::u8toeuc(elm_h1.elements['a'].text)
    end
  end

  def to_s
    Uconv::u8toeuc(@body.to_s)
  end

  private

  def command(cmd)
    $stderr.puts "execute '#{cmd}' ..."
    raise(RuntimeError, cmd) unless system(cmd)
  end

  def rd2(src, dst)
    opt_lang = "--html-lang=#{@lang}" if @lang
    opt_charset = "--html-charset=#{@charset}" if @charset
    cmdstr = "rd2 -r rd/rd2html-lib #{opt_charset} #{opt_lang}"
    command "#{cmdstr} #{src} > #{dst}"
  end

end				# class RDDocument



class NewsArticle

  attr_reader :subject_ja, :subject_en, :date, :uid,
    :body_ja, :body_en

  def parse( input )
    begin
      return nil unless parse_header( input )
      parse_body( input, 'ja' ) if @subject_ja
      parse_body( input, 'en' ) if @subject_en
      return self
    rescue EOFError
      return nil
    end
  end

  def parse_header( input )
    line = ""
    line = input.readline while /^$/ =~ line
    until /^$/ =~ line do
      case line
      when /^subject-ja:(.*)$/i then @subject_ja = $1.strip
      when /^subject-en:(.*)$/i then @subject_en = $1.strip
      when /^date:(.*)$/i then @date = $1.strip
      when /^uid:(.*)$/i then @uid = $1.strip
      else
	raise "#{self.class}#parse_header: #{line.chop}"
      end
      line = input.readline
    end
    return true
  end

  def parse_body( input, lang )
    body = ''
    line = input.readline
    delim = /^\.\.#{lang}$/
    until delim =~ line do
      body << line
      line = input.readline
    end
    if lang == 'ja' then
      @body_ja = body.strip
    else
      @body_en = body.strip
    end
  end

  def to_div_en
    return '' unless @subject_en
    ret = "<div><h2 class='body-news'><a name='#{@uid}'>#{@subject_en} (#{@date})</a></h2>\n"
    # ret << "<p class='body-news'>#{@body_en}</p></div>"
    ret << "#{@body_en}</div>"
    return ret
  end

  def to_div_ja
    return '' unless @subject_ja
    ret = "<div><h2 class='body-news'><a name='#{@uid}'>#{@subject_ja} (#{@date})</a></h2>\n"
    # ret << "<p class='body-news'>#{@body_ja}</p></div>"
    ret << "#{@body_ja}</div>"
    return ret
  end

end 				# class NewsArticle
