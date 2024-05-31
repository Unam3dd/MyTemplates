BUILD_DIR = build
DIST_DIR = bin
MESON = meson
ifeq ($(OS),Windows_NT)
	PREFIX = $(shell echo %cd%)
else
	PREFIX = $(PWD)
endif
TEST = $(MESON) test -C $(BUILD_DIR)
BUILD = $(MESON) setup $(BUILD_DIR) --prefix=$(PREFIX)
NINJA = ninja -C $(BUILD_DIR) install

all: $(BUILD_DIR)

$(BUILD_DIR):
	@$(BUILD)
	@$(NINJA)

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
