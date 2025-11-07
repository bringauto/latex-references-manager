SHELL = /bin/sh

TMP_DIR := _tmp
MAKEFILE_COMMON := Makefile.common
REFERENCES = references.tex
REFERENCES_CONFIG = references_config.tex
REFERENCES_LIB = references_lib
EXAMPLE = example
LIB_PATH = latex-references-manager/
INIT_DIR = ../

init:
	echo "Initializing library"
	ln -sf $(LIB_PATH)$(MAKEFILE_COMMON) $(INIT_DIR)$(MAKEFILE_COMMON)
	ln -sf $(LIB_PATH)$(REFERENCES_LIB) $(INIT_DIR)$(REFERENCES_LIB)
	ln -sf $(LIB_PATH)$(EXAMPLE) $(INIT_DIR)$(EXAMPLE)
	# Copy only if not exists
	cp -n $(REFERENCES_CONFIG) $(INIT_DIR)$(REFERENCES_CONFIG)
	cp -n $(REFERENCES) $(INIT_DIR)$(REFERENCES)

clean:
	@echo "Cleaning initialized library"
	rm -f $(INIT_DIR)$(MAKEFILE_COMMON)
	rm -rf $(INIT_DIR)$(EXAMPLE)
	rm -rf $(INIT_DIR)$(REFERENCES_LIB)

.PHONY: init clean