SHELL = /bin/sh

TMP_DIR := _tmp
MAKEFILE_COMMON := Makefile.common
REFERENCES = references.tex
REFERENCES_CONFIG = references_config.tex
REFERENCES_LIB = references_lib
EXAMPLE = example
LIB_PATH = latex-references-manager/
INIT_DIR = ../

init: init-no-ref link-ref

init-no-ref:
	echo "Initializing library"
	ln -sf $(LIB_PATH)$(MAKEFILE_COMMON) $(INIT_DIR)$(MAKEFILE_COMMON)
	ln -sf $(LIB_PATH)$(REFERENCES_LIB) $(INIT_DIR)$(REFERENCES_LIB);
	cp -n $(REFERENCES_CONFIG) $(INIT_DIR)$(REFERENCES_CONFIG)
	ln -sf $(LIB_PATH)$(EXAMPLE) $(INIT_DIR)$(EXAMPLE)

link-ref:
	@echo "Linking references file"
	ln -sf $(LIB_PATH)$(REFERENCES) $(INIT_DIR)$(REFERENCES)

clean:
	rm -f $(INIT_DIR)$(MAKEFILE_COMMON)
	rm -f $(INIT_DIR)$(REFERENCES_CONFIG)
	rm -rf $(INIT_DIR)$(EXAMPLE)
	rm -rf $(INIT_DIR)$(REFERENCES_LIB)