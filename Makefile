include config/project.mk
include config/banner.mk
include config/icons.mk
include config/bar.mk
include config/checker.mk

LOADING_BRAILLE_STRING="⠟,⣟,⣯,⣷,⣾,⣽,⣻,⢿"

.SILENT:
all: BANNER BANNER_MAIN

build: $(OBJDIR) $(NAME)

$(OBJDIR):
	@mkdir -p $(sort $(addprefix $(OBJDIR)/, $(dir $(SRCS))))

$(OBJDIR)/%.o: %.$(EXT_FILE_PROJECT)
	echo $<
	echo $@
	$(CC) $(CFLAGS) -c $< -o $@

.ONESHELL:
$(NAME): $(OBJDIR) $(OBJS)
	mkdir -p $(DIST)
	$(CC) $(CFLAGS) $(OBJS) -shared -o $(NAME)

help: BANNER
	$(call top_bar_center)
	$(call string_bar_center,                Help Main)
	$(call string_bar_center,   Command                    Description)
	$(call string_bar_center,    help                     show this main)
	$(call string_bar_center,    info                     show info)
	$(call string_bar_center,    build                    build project)
	$(call string_bar_center,    clean                    clean *.o)
	$(call string_bar_center,    fclean                   clean *.o + project)
	$(call string_bar_center,    re                       rebuild the project)
	$(call string_bar_center,    test            build and run all test files)
	$(call string_bar_center,    multibuild      build on multiple distrib)
	$(call string_bar_center,    run                    run the project)
	$(call string_bar_center,    cbuild          build with docker container)
	$(call bot_bar_center)

info: BANNER BANNER_MAIN
	$(call top_bar_center)
	$(call string_bar_center,CFLAGS=)
	$(call string_bar_center,$(CFLAGS))
	$(call string_bar_center,LDFLAGS=$(LDFLAGS)) 
	$(call bot_bar_center)

.ONESHELL:
BANNER:
	clear
	printf "$$banner"

.ONESHELL:
BANNER_MAIN:
	$(call top_bar_center)

	$(call string_bar_center,   Project Name  │  $(PROJECT_NAME))
	$(call string_bar_center,   Version       │  $(VERSION))
	$(call string_bar_center,   Author        │  $(AUTHOR))
	$(call string_bar_center,   Github        │  $(GITHUB))
	$(call string_bar_center,   OS            │  $(DISTRO))
	$(call string_bar_center,   CC            │  $(COMPILER_VERSION))
	$(call string_bar_center,   Library       │  $(IS_LIBRARY))
	$(call string_bar_center,   Sources Dir   │  $(SRCS_DIR) ($(SRC_CNT)))
	$(call string_bar_center,   Includes Dir  │  $(INCS_DIR) ($(INC_CNT)))
	$(call string_bar_center,   Test Dir      │  $(TEST_SRCS_DIR) ($(TEST_SRCS_CNT)))
ifndef DEBUG
	$(call string_bar_center,   Mode          │  Release)
	$(call string_bar_center,   Output        │  $(DIST))
	$(call string_bar_center,   Shared File   │  $(NAME))
	$(call string_bar_center,   Static File   │  $(STATIC_NAME))
else
	$(call string_bar_center,   Mode          │  Debug)
	$(call string_bar_center,   Output        │  $(DIST))
	$(call string_bar_center,   Shared File   │  $(NAME))
	$(call string_bar_center,   Static File   │  $(STATIC_NAME))
endif
	$(call bot_bar_center)
