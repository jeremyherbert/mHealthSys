LATEX = pdflatex
TEXFILES = $(wildcard *.tex)
BIBFILES = $(wildcard *.bib)

MAINFILE = ECG_sensor

all: $(MAINFILE).pdf

%.pdf: %.tex %.bib %.blg *.cls $(TEXFILES) $(BIBFILES)
	pdflatex $*.tex 
	bibtex --min-crossrefs=20 $*
	pdflatex $*.tex
	pdflatex $*.tex

%.blg: %.bib
	pdflatex $*.tex
	bibtex --min-crossrefs=20 $*
	pdflatex $*.tex

%.toc: %.tex
	pdflatex $*.tex

clean:
	/bin/rm -f $(MAINFILE).pdf *.dvi *.aux *.ps *~ *.log
	/bin/rm -f *.lot *.lof *.toc *.blg *.bbl url.sty *.out

view: 
	pdflatex $(MAINFILE).tex
	acroread  -geometry 1000x1000 $(MAINFILE).pdf

osx:
	pdflatex $(MAINFILE).tex
	open $(MAINFILE).pdf

check:
	pdflatex $(MAINFILE).tex | grep -s -e "multiply" -e "undefined"

