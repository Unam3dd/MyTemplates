include config/project.mk
include config/banner.mk
include config/icons.mk
include config/bar.mk
include config/checker.mk

.SILENT:
all: BANNER BANNER_MAIN

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
	printf "$$banner"

.ONESHELL:
BANNER_MAIN:
	$(call top_bar_center)
	
	$(call string_bar_center,   Project Name  │  $(GREEN)$(PROJECT_NAME)$(RST)			    )
	$(call string_bar_center,   Version       │  $(GREEN)$(VERSION)$(RST)                                      )
	$(call string_bar_center,   Author        │  $(GREEN)$(AUTHOR)$(RST)                                    )
	$(call string_bar_center,   Github        │  $(GREEN)$(GITHUB)$(RST)                 )
	$(call string_bar_center,   OS            │  $(GREEN)$(DISTRO)$(RST)                                )
	$(call string_bar_center,   CC            │  $(GREEN)$(COMPILER_VERSION)$(RST)                  )
	$(call string_bar_center,   Library       │  $(GREEN)$(IS_LIBRARY)$(RST)                                       )
	$(call string_bar_center,   Language      │  $(GREEN)Writed in $(RST)$(PROJECT_SRC_ICO) $(PROJECT_INC_ICO)                             )
	$(call string_bar_center,   Sources Dir   │  $(GREEN)$(SRCS_DIR)$(RST)  $(PROJECT_SRC_ICO)  ($(GREEN)$(SRC_CNT)$(RST))                               )
	$(call string_bar_center,   Includes Dir  │  $(GREEN)$(INCS_DIR)$(RST)  $(PROJECT_INC_ICO) ($(GREEN)$(INC_CNT)$(RST))                                )
	$(call string_bar_center,   Test Dir      │  $(GREEN)$(TEST_SRCS_DIR) $(TEST_ICO)  $(RST)($(GREEN)$(TEST_SRCS_CNT)$(RST))	                        )
ifndef DEBUG
	$(call string_bar_center,   Mode          │  $(YELLOW)Release$(RST)                                    )
	$(call string_bar_center,   Output        │  $(GREEN)$(DIST)$(RST)                              )
	$(call string_bar_center,   Shared File   │  $(GREEN)$(NAME)$(RST)                  )
	$(call string_bar_center,   Static File   │  $(GREEN)$(STATIC_NAME)$(RST)                   )
else
	$(call string_bar_center,   Mode          │  $(YELLOW)Debug$(RST)                                      )
	$(call string_bar_center,   Output        │  $(GREEN)$(DIST)$(RST)                                )
	$(call string_bar_center,   Shared File   │  $(GREEN)$(NAME)$(RST)                    )
	$(call string_bar_center,   Static File   │  $(GREEN)$(STATIC_NAME)$(RST)                     )
endif
	$(call bot_bar_center)
