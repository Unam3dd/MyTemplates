CC = gcc
#CC = clang
#CC = clang-cl
#CC = x86_64-w64-mingw32-gcc

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
ifeq ($(OS), Windows_NT)
	@rmdir $(BUILD_DIR) /S /Q
else
	@rm -rf $(BUILD_DIR)
endif

ifeq ($(OS), Windows_NT)
fclean:
	@rmdir $(DIST_DIR) /S /Q
else
fclean: clean
	@rm -rf $(DIST_DIR)
endif

re: fclean
	@$(BUILD) --reconfigure
	@$(NINJA) install

tests: $(BUILD_DIR)
	@$(TEST)

vg-tests: $(BUILD_DIR)
	@$(TEST) --verbose --wrapper=valgrind

build-tests:
	@$(BUILD) --reconfigure -Dbuild-tests=true
	@$(NINJA)

.PHONY: all release plain minsize debug debugoptimized clean fclean re tests build build-tests vg-tests
