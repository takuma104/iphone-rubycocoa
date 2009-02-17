require 'rexml/document'

def replace_link(elm)
  if elm.name == 'a' then
    href = elm.attributes['href']
    if /\Ahttp:/ !~ href and /\Amailto:/ !~ href and /\.html(#\d+)?\z/ =~ href then
      elm.attributes['href'] = "http://rubycocoa.sourceforge.net/doc/#{href}"
    end
  end
  elm.each_element do |child|
    replace_link(child)
  end
end

doc = REXML::Document.new( $stdin )
replace_link( doc.root )
print doc.to_s
