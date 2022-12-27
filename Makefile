BUILDDIR=build
SRCDIR=src
PANDOCDIR=pandoc
include target.conf

pdf:
	mkdir $(BUILDDIR) -p
	pandoc $(SRCDIR)/$(TARGET).md \
		--template=$(PANDOCDIR)/template.latex \
		--include-in-header=$(PANDOCDIR)/header.tex \
		--include-before-body=$(PANDOCDIR)/title.tex \
		-V papersize:a4 \
		-V pagestyle=empty \
		-V geometry:margin=0.6in \
		-V mainfont:"TeX Gyre Heros" \
		-V fontsize:11pt \
		--to=latex \
		--lua-filter=$(PANDOCDIR)/fancyheads.lua \
		-s --output=$(BUILDDIR)/$(TARGET).tex
	xelatex -output-directory=$(BUILDDIR) \
		-interaction=batchmode \
		$(BUILDDIR)/$(TARGET).tex
	rm $(BUILDDIR)/$(TARGET).aux $(BUILDDIR)/$(TARGET).log


