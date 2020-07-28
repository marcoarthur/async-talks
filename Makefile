# Definitions
MD_FILE=Article.md
BIBLIOGRAPHY=default.bib
PANDOC_FILTERS= --filter pandoc-citeproc
PANDOC_OPTS= --biblatex $(PANDOC_FILTERS) --bibliography=$(BIBLIOGRAPHY) --toc -s
TARGET=doc.html

# Rules
doc: $(TARGET)

doc.html: $(MD_FILE) $(BIBLIOGRAPHY)
	pandoc -o doc.html $(MD_FILE) $(PANDOC_OPTS)

doc.pdf: $(MD_FILE) $(BIBLIOGRAPHY)
	pandoc -o doc.pdf $(MD_FILE) $(PANDOC_OPTS)

.PHONY: clean

clean:
	rm -rf *.html *.pdf
