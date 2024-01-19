include ./config/project.mk

# Compiler

# GCC Default

ifeq ($(EXT_FILE_PROJECT), c)
CC = gcc
CFLAGS = -Wall -Wextra -Werror -I$(INCS_DIR) -pedantic -DVERSION=\"$(VERSION)"
LDFLAGS =
COMPILER_VERSION = $(shell $(CC) --version | head -n1)
endif

# Assembly Compiler using GAS as Default

ifeq ($(EXT_FILE_PROJECT), s)
CC = gcc
CFLAGS = -Wall -Wextra -Werror -I$(INCS_DIR) -pedantic -DVERSION=\"$(VERSION)"
LDFLAGS =
COMPILER_VERSION = $(shell $(CC) --version | head -n1)
endif

# Flags

ifeq ($(IS_LIBRARY), true)
	CFLAGS += -fPIE
endif

ifdef CLANG
	CC = clang
endif

ifdef FAST
	CFLAGS += -Ofast
endif

ifdef O2
	CFLAGS += -O2
endif

ifdef O3
	CFLAGS += -O3
endif

ifdef OSIZE
	CFLAGS += -Osize
endif

ifdef DEBUG
	CFLAGS += -DDEBUG=1
endif

ifdef STRIP
	CFLAGS += -s
endif

# Source Files

SRCS = $(shell ls $(SRCS_DIR)/*.$(EXT_FILE_PROJECT))
OBJS = $(addprefix $(OBJDIR)/, $(SRCS:.$(EXT_FILE_PROJECT)=.o))

# Test Files

TEST_SRCS = $(shell ls $(TEST_SRCS_DIR)/*.$(EXT_FILE_PROJECT) 2> /dev/null)
TEST_OBJS = $(TEST_SRCS:*.$(EXT_FILE_PROJECT)=.test)

# VPath

ifeq ($(EXT_FILE_PROJECT), c)
vpath %.c $(SRCS_DIR)
vpath %.h $(INCS_DIR)
endif

ifeq ($(EXT_FILE_PROJECT), s)

ifdef NASM
	CC = nasm
	CFLAGS = -felf64
endif

vpath %.s $(SRCS_DIR)
vpath %.h $(INCS_DIR)
endif
