include config/project.mk
include config/banner.mk
include config/icons.mk
include config/bar.mk
include config/checker.mk

.SILENT:
all: BANNER BANNER_MAIN

build: BANNER BANNER_MAIN $(OBJDIR) $(OBJS) $(NAME) $(STATIC_NAME)

$(OBJDIR):
	@mkdir -p $(sort $(addprefix $(OBJDIR)/, $(dir $(SRCS))))

$(OBJDIR)/%.o: %.$(EXT_FILE_PROJECT)
	@$(CC) $(CFLAGS) -c $< -o $@
	@$(eval P=$(shell echo "$(COUNTER)/$(NF)*100" | bc -l | tr '.' '\n' | head -n1))
	@$(eval COUNTER=$(shell echo -e "$(COUNTER)+1" | bc -l))
	@$(eval MOD=$(shell echo $$(( ($(COUNTER) % 8) + 1))))
	@$(eval LOADING_ITER=$(shell echo -ne $(LOADING_BRAILLE_STRING) | cut -d ',' -f$(MOD)))
	@$(eval FILE_SIZE=$(shell stat --format="$(GREEN)%s$(RST) Bytes" $<))
	@echo -ne '\e[1A\e[1K'
	@echo -ne "\033[2K"
	@echo -ne "[$(GREEN)$(LOADING_ITER)$(RST)]	FileType: $(C_FILE_ICO_BLUE)  $(GREEN)$<$(RST) ($(FILE_SIZE)) 	$(GREEN)$@$(RST)"
	@echo -ne '\t['
	@i=1
	@while [ "$$i" -le $(COUNTER) ]
	@do
	@echo -ne '$(GREEN)█'
	@((i++))
	@done
	@while [ "$$i" -le $(NF) ]
	@do
	@echo -ne '▒'
	@((i++))
	@done
	@echo -e "$(RST)]\t\t $(PURPLE)$(P)$(RST)%	"

.ONESHELL:
$(NAME): $(OBJDIR) $(OBJS)
	mkdir -p $(DIST)
ifeq ($(IS_LIBRARY),true)
	$(CC) $(CFLAGS) $(LDFLAGS) $(OBJS) -shared -o $(NAME)
else
	$(CC) $(CFLAGS) $(LDFLAGS) $(OBJS) -o $(NAME)
endif
	@echo -e "\n\n\n$(CHECK) Project has been compiled and generated $(GREEN)successfully$(RST) !"
	@echo -e "$(CHECK) Shared library or executable generated at $(GREEN)$(NAME) $(RST) !"

.ONESHELL:
$(STATIC_NAME): $(OBJDIR) $(OBJS)
	mkdir -p $(DIST)
ifeq ($(IS_LIBRARY),true)
	ar rcs $(STATIC_NAME) $(OBJS)
else
	$(CC) $(STATIC_CFLAGS) $(LDFLAGS) $(OBJS) -o $(STATIC_NAME)
endif
	@echo -e "\n\n\n$(CHECK) Project has been compiled and generated $(GREEN)successfully$(RST) !"
	@echo -e "$(CHECK) Static library or static executable generated at $(GREEN)$(STATIC_NAME) $(RST) !"

.ONESHELL:
clean:
	@echo -e "$(CHECK) Clean object directory !"
	@echo -e "[$(GREEN)+$(RST)] $(GREEN)$(shell echo $(OBJS) | wc -w )$(RST) Object files was removed $(GREEN)successfully$(RST) !"
	rm -rf $(OBJS)
	rm -rf $(OBJDIR)

.ONESHELL:
fclean: clean
	echo -e "$(CHECK) $(NAME) was removed !"
	rm -rf $(NAME)
	echo -e "$(CHECK) $(STATIC_NAME) was removed !"
	rm -rf $(STATIC_NAME)
	echo -e "$(CHECK) $(DIST_BASE) was removed !"
	rm -rf $(DIST_BASE)

re: fclean build

help: BANNER
	$(call top_bar_center)
	$(call string_bar_center,                Help Main)
	$(call string_bar_center,   Command                  Description)
	$(call string_bar_center,    help                  show this main)
	$(call string_bar_center,    info                  show info)
	$(call string_bar_center,    build                 build project)
	$(call string_bar_center,    clean                 clean *.o)
	$(call string_bar_center,    fclean                clean *.o + project)
	$(call string_bar_center,    re                    rebuild the project)
	$(call string_bar_center,    test                  build and run all test files)
	$(call string_bar_center,    multibuild            build on multiple distrib)
	$(call string_bar_center,    run                   run the project)
	$(call string_bar_center,    cbuild                build with docker container)
	$(call bot_bar_center)

info: BANNER BANNER_MAIN
	$(call top_bar_center)
	$(call string_bar_center,CFLAGS=)
	$(call string_bar_center,$(CFLAGS))
	$(call string_bar_center,$(STATIC_CFLAGS))
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
	$(call string_bar_center,   Sources Dir   │  $(SRCS_DIR) ($(NF)))
	$(call string_bar_center,   Includes Dir  │  $(INCS_DIR) ($(HNF)))
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
	echo -e "\n"
