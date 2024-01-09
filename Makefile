include config/project.mk
include config/icons.mk

SHELL :=/bin/zsh

all:
	@echo -e "Project langage is $(PROJECT_SRC_ICO)"

.PHONY: all
