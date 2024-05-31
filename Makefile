BUILD_DIR = build
DIST_DIR = bin
MESON = meson
TEST = $(MESON) test -C $(BUILD_DIR)
BUILD = $(MESON) setup $(BUILD_DIR) --prefix=$(PWD)
NINJA = ninja -C $(BUILD_DIR)

all: $(DIST_DIR)

$(DIST_DIR):
	@$(BUILD)
	@$(NINJA) install

build: $(DIST_DIR)

release: $(DIST_DIR)

plain:
	@$(BUILD) --reconfigure --buildtype=plain
	@$(NINJA) install

minsize:
	@$(BUILD) --reconfigure --buildtype=minsize
	@$(NINJA) install

debug:
	@$(BUILD) --reconfigure --buildtype=debug
	@$(NINJA) install

debugoptimized:
	@$(BUILD) --reconfigure --buildtype=debugoptimized
	@$(NINJA) install

clean:
	@rm -rf $(BUILD_DIR)

fclean: clean
	@rm -rf $(DIST_DIR)

re: fclean
	@$(BUILD) --reconfigure
	@$(NINJA) install

tests: $(BUILD_DIR)
	@$(TEST)

build-tests:
	@$(BUILD) --reconfigure -Dbuild-tests=true
	@$(NINJA)

.PHONY: all release plain minsize debug debugoptimized clean fclean re tests build-tests
