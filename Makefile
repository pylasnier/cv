BUILDDIR=build
SRC=main.md
PANDOCDIR=pandoc
TARGET=out

all: pdf readme

pdf: tex
	xelatex -output-directory=$(BUILDDIR) \
		-interaction=batchmode \
		$(BUILDDIR)/$(TARGET).tex

tex: $(SRC) $(PANDOCDIR)/template.latex $(PANDOCDIR)/header.tex $(PANDOCDIR)/title.tex $(PANDOCDIR)/filter.lua
	mkdir $(BUILDDIR) -p
	pandoc $(SRC) \
		--template=$(PANDOCDIR)/template.latex \
		--include-in-header=$(PANDOCDIR)/header.tex \
		--include-before-body=$(PANDOCDIR)/title.tex \
		-V papersize:a4 \
		-V pagestyle=empty \
		-V geometry:margin=0.6in \
		-V mainfont:"TeX Gyre Heros" \
		-V fontsize:11pt \
		--to=latex-smart \
		--lua-filter=$(PANDOCDIR)/filter.lua \
		-s --output=$(BUILDDIR)/$(TARGET).tex

gfm: $(SRC) $(PANDOCDIR)/template.md $(PANDOCDIR)/filter.lua
	mkdir $(BUILDDIR) -p
	pandoc $(SRC) \
		--template=$(PANDOCDIR)/template.md \
		--to=gfm \
		--lua-filter=$(PANDOCDIR)/filter.lua \
		-s --output=$(BUILDDIR)/$(TARGET).md

readme: gfm
	cat README-bare.md $(BUILDDIR)/$(TARGET).md > README.md

native: $(SRC)
	mkdir $(BUILDDIR) -p
	pandoc $(SRC).md \
		--to=native \
		-s --output=$(BUILDDIR)/$(TARGET).txt
