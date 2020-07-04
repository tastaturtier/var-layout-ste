
book.pdf: book.tex var.cls private.sty foreword.tex lastpage.tex img/*.png book/*/*
	xelatex -no-pdf -halt-on-error book.tex && \
	makeindex book && \
	makeindex book.nlo -s nomencl.ist -o book.nls && \
	xelatex -no-pdf -halt-on-error book.tex && \
	xelatex -no-pdf -halt-on-error book.tex && \
	xelatex -no-pdf -halt-on-error book.tex && \
	xelatex -no-pdf -halt-on-error book.tex && \
	xelatex -no-pdf -halt-on-error book.tex && \
	xdvipdfmx book.xdv 

draft.chapter1.pdf: draft.chapter1.tex var.cls private.sty img/*.png book/chapter1/*
	xelatex -halt-on-error draft.chapter1.tex 
draft.chapter2.pdf: draft.chapter1.tex var.cls private.sty img/*.png book/chapter2/*
	xelatex -halt-on-error draft.chapter2.tex 

clean:
	rm *.xdv *.akt *.act *.synctex.gz *'.synctex(busy)' *.log *.idx *.ilg *.ind *.nlo *.out *.toc *.aux *.mtc *.fdb_latexmk *.mtc0 *.fls *.nlo *.idx *.out *.ilg *.ind *.log *.toc *.maf *.nls

%.pdf: %.xdv
	xdvipdfmx $<

%.xdv: %.tex
	xelatex -no-pdf $<

