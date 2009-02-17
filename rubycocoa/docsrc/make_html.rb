#!/usr/bin/env ruby
require 'docutils'

# parse options
unless (2..3) === ARGV.size then
  $stderr.puts "usage: ruby make_html.rb SRCFILE DSTDIR [NEWS?]"
  exit 1
end
SRCFILE = ARGV.shift
DSTDIR = ARGV.shift
NEWS_P = (ARGV.shift == "news")

def src_to_html(src, dst, lang, fmt)
  charset =
    if lang == 'ja' then
      'euc-jp'
    else
      lang = 'en'
      'us-ascii'
    end

  $stderr.print "#{src}..." ; $stderr.flush
  tmpl = PageTemplate.new( 'page-template.html' )

  # setup embeding parts. 
  embeding_parts = [
    ["site-menubar.#{lang}.xml", 'site-menubar' ],
    ["sidebar-contents.#{lang}.xml", 'sidebar-contents' ],
    ["sidebar-links.#{lang}.xml", 'sidebar-links' ],
  ]
  embeding_parts.push ["sidebar-news.#{lang}.xml", 'sidebar-news' ] if NEWS_P

  embeding_parts.each do |fname, idval|
    xmlsrc = File.open(fname){|f|f.read}
    xmldoc = REXML::Document.new( xmlsrc )
    tmpl.replace_elements( 'id', idval, xmldoc.root )
  end

  if fmt == 'rd' then
    rdoc = RDDocument.new( src, lang, charset )
    tmpl.set_title( rdoc.title )
    tmpl.set_contents( rdoc.body )
    tmpl.set_lang( lang )
    tmpl.write_to_file( dst )
  elsif fmt == 'xml' then
    xmldata = REXML::Document.new( File.open(src) )
    title = xmldata.root.elements['h1'].text
    tmpl.set_title( Uconv.u8toeuc(title) )
    tmpl.set_contents( xmldata.root )
    tmpl.set_lang( lang )
    tmpl.write_to_file( dst )
  else
    raise "unknwon document format '#{fmt}'"
  end
  $stderr.puts "done."
end


docs = [ SRCFILE ]

docs.each do |path|
  dirname = File.dirname(path)
  filename = File.basename(path)
  lang, fmt = filename.split('.')[-2, 2]
  docname = filename.split('.')[0..-3].join('.')
  dstpath = "#{DSTDIR}/#{docname.downcase}.#{lang}.html"
  src_to_html(path, dstpath, lang, fmt)
end
