
example.pdf: vorwort.tex VAR-Reihe.tex example.tex var.cls private.sty
	xelatex -no-pdf example.tex; \
	makeindex example; \
	makeindex example.nlo -s nomencl.ist -o example.nls; \
	xelatex -no-pdf example.tex; \
	xelatex -no-pdf example.tex; \
	xelatex -no-pdf example.tex; \
	xelatex -no-pdf example.tex; \
	xelatex -no-pdf example.tex; \
	xdvipdfmx example.xdv 

clean:
	rm *.xdv *.akt *.act *.synctex.gz *'.synctex(busy)' *.log *.idx *.ilg *.ind *.nlo *.out *.toc *.aux *.mtc *.fdb_latexmk *.mtc0 *.fls *.nlo *.idx *.out *.ilg *.ind *.log *.toc *.maf *.nls

%.pdf: %.xdv
	xdvipdfmx example.xdv $<

%.xdv: %.tex
	xelatex -no-pdf $<

