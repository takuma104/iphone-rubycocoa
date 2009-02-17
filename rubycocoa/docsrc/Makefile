TARGETDIR = ./html
RUBYCOCOA_DIR = ../src-trunk
CHANGELOG_SRC = $(RUBYCOCOA_DIR)/ChangeLog
INSTALL_TARGETDIR = $(RUBYCOCOA_DIR)/doc

RUBY = ruby
SED = sed

TARGET_HTML = \
	$(TARGETDIR)/index.en.html \
	$(TARGETDIR)/index.ja.html \
	$(TARGETDIR)/changes.en.html \
	$(TARGETDIR)/changes.ja.html \
	$(TARGETDIR)/faq.en.html \
	$(TARGETDIR)/faq.ja.html \
	$(TARGETDIR)/getting.en.html \
	$(TARGETDIR)/getting.ja.html \
	$(TARGETDIR)/build.en.html \
	$(TARGETDIR)/build.ja.html \
	$(TARGETDIR)/links.en.html \
	$(TARGETDIR)/links.ja.html \
	$(TARGETDIR)/programming.en.html \
	$(TARGETDIR)/programming.ja.html \
	$(TARGETDIR)/trysamples.en.html \
	$(TARGETDIR)/trysamples.ja.html \
	$(TARGETDIR)/references.ja.html \
	$(TARGETDIR)/references.en.html \
	$(TARGETDIR)/news.en.html \
	$(TARGETDIR)/news.ja.html \
	$(TARGETDIR)/changelog.html

TARGET = $(TARGET_HTML) $(TARGETDIR)/rubycocoasite.css $(TARGETDIR)/simpleapp-sml.jpg

SFINDEX = $(TARGETDIR)/index_sf.html

TEMPLATES = \
	sidebar-contents.en.xml sidebar-contents.ja.xml \
	sidebar-links.en.xml sidebar-links.ja.xml \
	site-menubar.en.xml site-menubar.ja.xml \
	page-template.html

DYNAMIC_ITEMS = \
	sidebar-news.en.xml sidebar-news.ja.xml \
	news.en.xml news.ja.xml


all:	$(TARGETDIR) $(TARGET) $(SFINDEX)

clean:
	-rm -f $(TARGET) $(DYNAMIC_ITEMS) $(SFINDEX)

install:	$(TARGETDIR) $(TARGET)
		$(RUBY) copy_if_diff.rb $(TARGET) $(INSTALL_TARGETDIR)


rsync:	$(TARGET)
	-rsync -v -t -e ssh html/* \
		shell.sourceforge.net:/home/groups/r/ru/rubycocoa/htdocs/doc/

$(TARGET):	$(TEMPLATES)


$(TARGETDIR):
	-mkdir -p $(TARGETDIR)

$(TARGETDIR)/rubycocoasite.css:	rubycocoasite.css
	-cp -f $< $(TARGETDIR)/

$(TARGETDIR)/simpleapp-sml.jpg:	simpleapp-sml.jpg
	-cp -f $< $(TARGETDIR)/

news.en.xml:	NEWS.data
	$(RUBY) news_to_body.rb en < $< > $@

news.ja.xml:	NEWS.data
	$(RUBY) news_to_body.rb ja < $< > $@

sidebar-news.en.xml:	NEWS.data
	$(RUBY) news_to_headline.rb en < $< > $@

sidebar-news.ja.xml:	NEWS.data
	$(RUBY) news_to_headline.rb ja < $< > $@

$(TARGETDIR)/index_sf.html:	$(TARGETDIR)/index.en.html
	$(RUBY) to_index_sf.rb < $< > $@

$(TARGETDIR)/index.en.html:	INDEX.en.rd sidebar-news.en.xml simpleapp-sml.jpg
	$(RUBY) make_html.rb $< $(TARGETDIR) news

$(TARGETDIR)/index.ja.html:	INDEX.ja.rd sidebar-news.ja.xml simpleapp-sml.jpg
	$(RUBY) make_html.rb $< $(TARGETDIR) news

$(TARGETDIR)/changes.en.html:	CHANGES.en.rd
	$(RUBY) make_html.rb $< $(TARGETDIR)

$(TARGETDIR)/changes.ja.html:	CHANGES.ja.rd
	$(RUBY) make_html.rb $< $(TARGETDIR)

$(TARGETDIR)/faq.en.html:	FAQ.en.rd
	$(RUBY) make_html.rb $< $(TARGETDIR)

$(TARGETDIR)/faq.ja.html:	FAQ.ja.rd
	$(RUBY) make_html.rb $< $(TARGETDIR)

$(TARGETDIR)/getting.en.html:	GETTING.en.rd
	$(RUBY) make_html.rb $< $(TARGETDIR)

$(TARGETDIR)/getting.ja.html:	GETTING.ja.rd
	$(RUBY) make_html.rb $< $(TARGETDIR)

$(TARGETDIR)/build.en.html:	BUILD.en.rd
	$(RUBY) make_html.rb $< $(TARGETDIR)

$(TARGETDIR)/build.ja.html:	BUILD.ja.rd
	$(RUBY) make_html.rb $< $(TARGETDIR)

$(TARGETDIR)/links.en.html:	LINKS.en.rd
	$(RUBY) make_html.rb $< $(TARGETDIR)

$(TARGETDIR)/links.ja.html:	LINKS.ja.rd
	$(RUBY) make_html.rb $< $(TARGETDIR)

$(TARGETDIR)/news.en.html:	news.en.xml
	$(RUBY) make_html.rb $< $(TARGETDIR)

$(TARGETDIR)/news.ja.html:	news.ja.xml
	$(RUBY) make_html.rb $< $(TARGETDIR)

$(TARGETDIR)/programming.en.html:	PROGRAMMING.en.rd
	$(RUBY) make_html.rb $< $(TARGETDIR)

$(TARGETDIR)/programming.ja.html:	PROGRAMMING.ja.rd
	$(RUBY) make_html.rb $< $(TARGETDIR)

$(TARGETDIR)/trysamples.en.html:	TRYSAMPLES.en.rd
	$(RUBY) make_html.rb $< $(TARGETDIR)

$(TARGETDIR)/trysamples.ja.html:	TRYSAMPLES.ja.rd
	$(RUBY) make_html.rb $< $(TARGETDIR)

$(TARGETDIR)/references.en.html:	REFERENCES.en.rd
	$(RUBY) make_html.rb $< $(TARGETDIR)

$(TARGETDIR)/references.ja.html:	REFERENCES.ja.rd
	$(RUBY) make_html.rb $< $(TARGETDIR)

$(TARGETDIR)/changelog.html:		$(CHANGELOG_SRC)
	echo "<html>" > $(TARGETDIR)/changelog.html
	echo "<head><title>RubyCocoa - ChangeLog</title></head>" >> $(TARGETDIR)/changelog.html
	echo "<body>"  >> $(TARGETDIR)/changelog.html
	echo "<pre>"  >> $(TARGETDIR)/changelog.html
#	$(SED) -e 's/</\&lt;/' -e 's/>/\&gt;/' $<  >> $(TARGETDIR)/changelog.html
	$(SED) -e 's/<.*@.*>//' $<  >> $(TARGETDIR)/changelog.html
	echo "</pre>" >> $(TARGETDIR)/changelog.html
	echo "</body></html>" >> $(TARGETDIR)/changelog.html

