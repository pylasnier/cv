BUILDDIR=build
SRCDIR=src
PANDOCDIR=pandoc
include target.conf

pdf:
	mkdir $(BUILDDIR) -p
	pandoc $(SRCDIR)/$(TARGET).md \
		--include-in-header=$(PANDOCDIR)/header.tex \
		--include-before-body=$(PANDOCDIR)/title.tex \
		-V papersize:a4 \
		-V geometry:margin=1in \
		-V mainfont:"TeX Gyre Heros" \
		-V fontsize:11pt \
		--to=latex \
		--output=$(BUILDDIR)/$(TARGET).pdf \
		--pdf-engine=xelatex \
		--lua-filter=$(PANDOCDIR)/fancyheads.lua
