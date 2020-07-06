
out/book.pdf: book.tex var.cls private.sty book/foreword.tex book/ste-ser.tex img/*.png book/*/*
	xelatex -no-pdf --output-directory=out -halt-on-error book.tex && \
	makeindex out/book && \
	makeindex out/book.nlo -s nomencl.ist -o out/book.nls && \
	xelatex --output-directory=out -halt-on-error -no-pdf book.tex && \
	xelatex --output-directory=out -halt-on-error -no-pdf book.tex && \
	xelatex --output-directory=out -halt-on-error -no-pdf book.tex && \
	xelatex --output-directory=out -halt-on-error -no-pdf book.tex && \
	xelatex --output-directory=out -halt-on-error book.tex

out/chapter1.pdf: book/chapter1/*
	xelatex --output-directory=out -halt-on-error -no-pdf '\def\file{book/chapter1/chapter1}\input{draft}' && \
	xelatex --output-directory=out -halt-on-error '\def\file{book/chapter1/chapter1}\input{draft}' && \
	mv out/draft.pdf out/chapter1.pdf
out/chapter2.pdf: book/chapter2/*
	xelatex --output-directory=out -halt-on-error -no-pdf '\def\file{book/chapter2/chapter2}\input{draft}' && \
	xelatex --output-directory=out -halt-on-error '\def\file{book/chapter2/chapter2}\input{draft}' && \
	mv out/draft.pdf out/chapter2.pdf

clean:
	rm out/*.xdv out/*.akt out/*.act out/*.synctex.gz out/*'.synctex(busy)' \
	out/*.log out/*.idx out/*.ilg out/*.ind out/*.nlo out/*.out out/*.toc \
	out/*.aux out/*.mtc out/*.fdb_latexmk out/*.mtc0 out/*.fls out/*.nlo \
	out/*.idx out/*.out out/*.ilg out/*.ind out/*.log out/*.toc out/*.maf \
	out/*.nls

%.pdf: %.xdv
	xdvipdfmx $<

%.xdv: %.tex
	xelatex -no-pdf $<

