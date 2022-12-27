BUILDDIR=build
SRCDIR=src
PANDOCDIR=pandoc
include target.conf

pdf: tex
	xelatex -output-directory=$(BUILDDIR) \
		-interaction=batchmode \
		$(BUILDDIR)/$(TARGET).tex
	rm $(BUILDDIR)/$(TARGET).aux $(BUILDDIR)/$(TARGET).log

tex:
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
		--lua-filter=$(PANDOCDIR)/filter.lua \
		-s --output=$(BUILDDIR)/$(TARGET).tex

gfm:
	mkdir $(BUILDDIR) -p
	pandoc $(SRCDIR)/$(TARGET).md \
		--template=$(PANDOCDIR)/template.md \
		--to=gfm \
		--lua-filter=$(PANDOCDIR)/filter.lua \
		-s --output=$(BUILDDIR)/$(TARGET).md

readme: gfm
	cat README-bare.md $(BUILDDIR)/$(TARGET).md > README.md

native:
	mkdir $(BUILDDIR) -p
	pandoc $(SRCDIR)/$(TARGET).md \
		--to=native \
		-s --output=$(BUILDDIR)/$(TARGET).txt
