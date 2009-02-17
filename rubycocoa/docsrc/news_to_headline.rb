require 'docutils'

# parse args
if ARGV.size != 1 then
  $stderr.puts "usage: ruby news_to_headline.rb {ja|en}"
  exit 1
end
LANG = 
  if ARGV.shift == 'ja' then
    { :lang => 'ja', :enc => 'euc-jp', :title => 'ニュース' }
  else
    { :lang => 'en', :enc => 'us-ascii', :title => 'NEWS' }
  end

# template for news xml
XML_TMPL_HEAD = <<EOTMPL
<?xml version="1.0" encoding="#{LANG[:enc]}"?>
<div id="sidebar-news">
<h2 class="body-sidebar"><a href="news.#{LANG[:lang]}.html">#{LANG[:title]}</a></h2>
<ul class="body-sidebar">
EOTMPL

$stdout.puts XML_TMPL_HEAD
      while article = NewsArticle.new.parse( $stdin ) do
    subj = (LANG[:lang] == 'ja') ? article.subject_ja : article.subject_en
    $stdout.puts "<li><a href='news.#{LANG[:lang]}.html##{article.uid}'>#{subj} (#{article.date})</a></li>"
  end
$stdout.puts "</ul>\n</div>"
