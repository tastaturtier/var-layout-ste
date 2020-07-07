## Copyright 2020 Sandro Leuchter (sandro.leuchter@dama.io)
#
# This work may be distributed and/or modified under the
# conditions of the LaTeX Project Public License, either version 1.3
# of this license or (at your option) any later version.
# The latest version of this license is in
#   http://www.latex-project.org/lppl.txt
# and version 1.3 or later is part of all distributions of LaTeX
# version 2005/12/01 or later.
#
# This work has the LPPL maintenance status `maintained'.
# 
# The Current Maintainer of this work is Sandro Leuchter.
#
# This work consists of the files var.cls, Makefile
################################################################################
#
# Makefile to build books according to var XeLaTeX layout class using make
# 
# project layout:
# ----------------
# var.cls                    the var layout class
# local.sty                  any local definitions and macros
# book.tex                   central document with includes to chapters
# draft.tex                  central document for producing draft of any chapters
# book/*.tex                 files that are included on global level (e.g. preface)
# book/img/*                 files that book/*.tex depend on (e.g. images)
# book/chapter*/chapter.tex  a chapter (or other unit of work)
# book/chapter*/*            files that chapter.tex depends on (e.g. images)
# out/*                      resulting outputs (pdf) and intermediate files go here
# 
# targets (building):
# -------------------
# make out/book.pdf      build book.pdf
# make out/chapterXX.pdf build draft of chapter XX
# make clean             attention! wipes intermediate files in out
# 
################################################################################

all: out/book.pdf clean 

out/book.pdf: book.tex book/*/* book/* local.sty var.cls
	xelatex --quiet -no-pdf --output-directory=out -halt-on-error $< && \
	makeindex out/$(basename $<) && \
	makeindex out/$(basename $<).nlo -s nomencl.ist -o out/$(basename $<).nls && \
	xelatex --quiet --output-directory=out -halt-on-error -no-pdf $< && \
	xelatex --quiet --output-directory=out -halt-on-error -no-pdf $< && \
	xelatex --quiet --output-directory=out -halt-on-error -no-pdf $< && \
	xelatex --quiet --output-directory=out -halt-on-error -no-pdf $< && \
	xelatex --quiet --output-directory=out -halt-on-error $<

out/chapter%.pdf: book/chapter%/chapter.tex book/chapter%/* local.sty var.cls 
	xelatex --quiet --output-directory=out -halt-on-error -no-pdf '\def\file{$<}\input{draft}' && \
	xelatex --quiet --output-directory=out -halt-on-error '\def\file{$<}\input{draft}' && \
	mv out/draft.pdf $@

clean:
	rm out/*.xdv out/*.akt out/*.act out/*.synctex.gz out/*'.synctex(busy)' \
	out/*.log out/*.idx out/*.ilg out/*.ind out/*.nlo out/*.out out/*.toc \
	out/*.aux out/*.mtc out/*.fdb_latexmk out/*.mtc0 out/*.fls out/*.nlo \
	out/*.idx out/*.out out/*.ilg out/*.ind out/*.log out/*.toc out/*.maf \
	out/*.nls
