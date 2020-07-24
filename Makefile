# Definitions
MD_FILE=Article.md
BIBLIOGRAPHY=default.bib
PANDOC_OPTS= --biblatex --filter pandoc-citeproc --bibliography=$(BIBLIOGRAPHY) --toc -s
TARGET=doc.html

# Rules
doc: $(TARGET)

doc.html: $(MD_FILE) $(BIBLIOGRAPHY)
	pandoc -o doc.html $(MD_FILE) $(PANDOC_OPTS)

doc.pdf: $(MD_FILE) $(BIBLIOGRAPHY)
	pandoc -o doc.pdf $(MD_FILE) $(PANDOC_OPTS)

.PHONY: clean

clean:
	rm -rf *.html
