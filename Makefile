all: out/book.pdf clean 

out/book.pdf: book.tex book/*/* book/* private.sty var.cls
	xelatex -no-pdf --output-directory=out -halt-on-error $< && \
	makeindex out/$(basename $<) && \
	makeindex out/$(basename $<).nlo -s nomencl.ist -o out/$(basename $<).nls && \
	xelatex --output-directory=out -halt-on-error -no-pdf $< && \
	xelatex --output-directory=out -halt-on-error -no-pdf $< && \
	xelatex --output-directory=out -halt-on-error -no-pdf $< && \
	xelatex --output-directory=out -halt-on-error -no-pdf $< && \
	xelatex --output-directory=out -halt-on-error $<

out/chapter%.pdf: book/chapter%/chapter.tex book/chapter%/* private.sty var.cls
	xelatex --output-directory=out -halt-on-error -no-pdf '\def\file{$<}\input{draft}' && \
	xelatex --output-directory=out -halt-on-error '\def\file{$<}\input{draft}' && \
	mv out/draft.pdf $@

clean:
	rm out/*.xdv out/*.akt out/*.act out/*.synctex.gz out/*'.synctex(busy)' \
	out/*.log out/*.idx out/*.ilg out/*.ind out/*.nlo out/*.out out/*.toc \
	out/*.aux out/*.mtc out/*.fdb_latexmk out/*.mtc0 out/*.fls out/*.nlo \
	out/*.idx out/*.out out/*.ilg out/*.ind out/*.log out/*.toc out/*.maf \
	out/*.nls
