HTML = $(shell ls a*.tex | sed 's/\.tex/.html/')
PDF  = $(shell ls *.tex | sed 's/\.tex/.pdf/')

all: $(HTML) $(PDF)

pdf: $(PDF)

a%.html : a%.tex
	grep ^%SCRIPT $< | cut -c9- | sh
	@./.process_verbatims $<
	./.latex_to_html5 < $< > $@

a%.pdf : a%.tex a%.html .header.tex .footer.tex
	cat .header.tex $< .footer.tex | ./.pdflatexfilter > $@

p%.pdf : p%.tex
	grep ^%SCRIPT $< | cut -c9- | sh
	cat $< | ./.pdflatexfilter > $@

clean :
	$(RM) $(HTML) $(PDF) canvas *.g  o/*.png
