BUILD_DIR = build
DIST_DIR = bin
MESON = meson
TEST = $(MESON) test -C $(BUILD_DIR)
ifdef $(PWD)
	PREFIX = $(PWD)
else
	PREFIX = $(shell %CD%)
endif
BUILD = $(MESON) setup $(BUILD_DIR) --prefix=$(PREFIX)
NINJA = ninja -C $(BUILD_DIR) install
ECHO = echo -e

all: $(BUILD_DIR)

$(BUILD_DIR):
	@$(BUILD)
	@$(NINJA)

help:
	@$(ECHO) "release\tbuild the project with release mode."
	@$(ECHO) "plain\tbuild the project with plain mode (no optimization used)."
	@$(ECHO) "minsize\tbuild the project with minsize mode (produce the most minus binary size)."
	@$(ECHO) "debug\tbuild the project with debug mode (produce a debug binary with debug symbols but not optimized)."
	@$(ECHO) "debugoptimized\tbuild the project with debug mode (produce a debug binary with debug symbols but optimized)."
	@$(ECHO) "clean\tclean build directory ($(BUILD_DIR))."
	@$(ECHO) "fclean\tfull clean (remove $(BUILD_DIR) + $(DIST_DIR))."
	@$(ECHO) "re\tre build the project."
	@$(ECHO) "test\trun tests."

release: $(BUILD_DIR)

plain:
	@$(BUILD) --reconfigure --buildtype=plain
	@$(NINJA)

minsize:
	@$(BUILD) --reconfigure --buildtype=minsize
	@$(NINJA)

debug:
	@$(BUILD) --reconfigure --buildtype=debug
	@$(NINJA)

debugoptimized:
	@$(BUILD) --reconfigure --buildtype=debugoptimized
	@$(NINJA)

clean:
	@rm -rf $(BUILD_DIR)

fclean: clean
	@rm -rf $(DIST_DIR)

re: fclean
	@$(BUILD) --reconfigure
	@$(NINJA)

test: $(BUILD_DIR)
	@$(TEST)

.PHONY: all release plain minsize debug debugoptimized clean fclean re test
