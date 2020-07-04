
book.pdf: book.tex var.cls private.sty foreword.tex lastpage.tex img/*.png 
	xelatex -no-pdf book.tex; \
	makeindex book; \
	makeindex book.nlo -s nomencl.ist -o book.nls; \
	xelatex -no-pdf book.tex; \
	xelatex -no-pdf book.tex; \
	xelatex -no-pdf book.tex; \
	xelatex -no-pdf book.tex; \
	xelatex -no-pdf book.tex; \
	xdvipdfmx book.xdv 

clean:
	rm *.xdv *.akt *.act *.synctex.gz *'.synctex(busy)' *.log *.idx *.ilg *.ind *.nlo *.out *.toc *.aux *.mtc *.fdb_latexmk *.mtc0 *.fls *.nlo *.idx *.out *.ilg *.ind *.log *.toc *.maf *.nls

%.pdf: %.xdv
	xdvipdfmx $<

%.xdv: %.tex
	xelatex -no-pdf $<

