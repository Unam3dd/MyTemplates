include config/project.mk
include config/banner.mk
include config/icons.mk
include config/bar.mk

.SILENT:

all: BANNER
	@echo -e "Project langage is $(PROJECT_SRC_ICO)"
	$(call top_bar, 20)
	$(call string_bar, "hello")
	$(call bot_bar, 20)

BANNER:
	clear
	printf "$$banner"
