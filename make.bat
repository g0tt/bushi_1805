	@echo " * Compiling to dvi..."
	platex -kanji=utf8 -interaction=nonstopmode "%1.tex"
	platex -kanji=utf8 -interaction=nonstopmode "%1.tex"
	platex -kanji=utf8 -interaction=nonstopmode "%1.tex"
	@echo " * Converting dvi to pdf..."
	dvipdfmx -o %1.pdf %1.dvi