# Definitions
MD_FILE=Article.md
BIBLIOGRAPHY=default.bib
PANDOC_OPTS= --biblatex --filter pandoc-citeproc --bibliography=$(BIBLIOGRAPHY) --toc -s

# Rules
doc: doc.html

doc.html: $(MD_FILE) $(BIBLIOGRAPHY)
	pandoc -o doc.html $(MD_FILE) $(PANDOC_OPTS)

.PHONY: clean

clean:
	rm -rf *.html
