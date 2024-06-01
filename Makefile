#CC = gcc
#CC = clang
#CC = clang-cl
#CC = x86_64-w64-mingw32-gcc

BUILD_DIR = build
DIST_DIR = bin
MESON = meson
TEST = $(MESON) test -C $(BUILD_DIR)
BUILD = $(MESON) setup $(BUILD_DIR)
NINJA = ninja -C $(BUILD_DIR)

all: $(DIST_DIR)

$(DIST_DIR):
	@$(BUILD) --prefix=$(PWD)
	@$(NINJA) install

build: $(DIST_DIR)

release: $(DIST_DIR)

plain:
	@$(BUILD) --reconfigure --buildtype=plain --prefix=$(PWD)
	@$(NINJA) install

minsize:
	@$(BUILD) --reconfigure --buildtype=minsize --prefix=$(PWD)
	@$(NINJA) install

debug:
	@$(BUILD) --reconfigure --buildtype=debug --prefix=$(PWD)
	@$(NINJA) install

debugoptimized:
	@$(BUILD) --reconfigure --buildtype=debugoptimized --prefix=$(PWD)
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
	@$(BUILD) --reconfigure --prefix=$(PWD)
	@$(NINJA) install

tests: $(BUILD_DIR)
	@$(TEST)

vg-tests: $(BUILD_DIR)
	@$(TEST) --verbose --wrapper=valgrind

build-tests:
ifeq ($(OS), Windows_NT)
	@$(BUILD) --reconfigure -Dbuild-tests=true
	@$(NINJA) install
else
	@$(BUILD) --reconfigure -Dbuild-tests=true --prefix=/usr/
ifdef INSTALL
	@$(NINJA) install
else
	@$(NINJA)
endif
endif

.PHONY: all release plain minsize debug debugoptimized clean fclean re tests build build-tests vg-tests
