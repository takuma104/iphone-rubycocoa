require 'docutils'

# parse args
if ARGV.size != 1 then
  $stderr.puts "usage: ruby news_to_body.rb {ja|en}"
  exit 1
end
LANG = ARGV.shift

if LANG == 'ja' then
  $stdout.puts "<?xml version='1.0' encoding='euc-jp' ?>\n<data><h1>ニュース</h1>\n"
  while article = NewsArticle.new.parse( $stdin ) do
    $stdout.puts article.to_div_ja
  end
else
  $stdout.puts "<?xml version='1.0' encoding='us-ascii' ?>\n<data><h1>NEWS</h1>\n"
  while article = NewsArticle.new.parse( $stdin ) do
    $stdout.puts article.to_div_en
  end
end
$stdout.puts "</data>"
