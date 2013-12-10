LATEX=latex
DVI=dvipdf
FILE=rm

all:
	$(LATEX) $(FILE).tex
	$(LATEX) $(FILE).tex
	$(DVI) $(FILE).dvi
open:
	open $(FILE).pdf
clean:
	rm -rf *.aux *.log ${FILE}.pdf
