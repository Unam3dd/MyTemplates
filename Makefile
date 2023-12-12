AUTHOR = Unam3dd
GITHUB = https://github.com/Unam3dd
VERSION = 0.0.1
DISTRO=$(shell cat /etc/os-release | grep "^ID" | head -n1 | cut -d '=' -f2)
PROJECT_NAME = libsupermath
IS_LIBRARY=true

RED							:= \033[38;5;196m
GREEN						:= \033[38;5;82m
BLUE						:= \033[38;5;27m
YELLOW						:= \033[38;5;11m
ORANGE						:= \033[38;5;202m
PURPLE						:= \033[38;5;129m
CYAN						:= \033[38;5;44m
RST						:= \033[00m
C_FILE_ICO					:= 
H_FILE_ICO					:= 
C_FILE_ICO_BLUE				:= \033[38;5;69m$(C_FILE_ICO)$(RST)
H_FILE_ICO_PURPLE			:= \033[38;5;98m$(H_FILE_ICO)$(RST)

CHECK					:= [$(GREEN)\xE2\x9C\x94$(RST)]

# Output when project is generated
DIST = dist/$(DISTRO)
OBJDIR = obj

# Includes and src dir
INCLUDES_DIR = inc
SRCS_DIR = src

TEST_INC_DIR = test
TEST_SRCS_DIR = test

NF=$(shell ls -lR $(SRCS_DIR) | grep -F .c | wc -l)
HNF=$(shell ls -lR $(INCLUDES_DIR) | grep -F .h | wc -l)
P=0
COUNTER=1
MOD=1
LOADING_ITER=0
FILE_SIZE=0
BIN_FILE_SIZE=0
NF_O=0
HASH=0

# Name of the project

FILENAME = $(PROJECT_NAME)
NAME = $(DIST)/$(FILENAME).so
STATIC_NAME = $(DIST)/$(FILENAME).a

SRCS = $(shell ls $(SRCS_DIR)/*.c 2>/dev/null)
OBJS = $(addprefix $(OBJDIR)/, $(SRCS:.c=.o)) 
TEST_SRCS = $(shell ls $(TEST_SRCS_DIR)/*.c 2> /dev/null)
TEST_OBJS = $(TEST_SRCS:.c=.test)

vpath %.c $(SRCS_DIR)
vpath %.h $(INCLUDES_DIR)

# Compiler Options
CC   = gcc
CFLAGS = -Wall -Wextra -Werror -Iinc -pedantic -DVERSION=\"$(VERSION)\"
COMPILER_VERSION = $(shell $(CC) --version | head -n1)

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

LOADING_BRAILLE_STRING="⠟,⣟,⣯,⣷,⣾,⣽,⣻,⢿"

define banner

$(PURPLE)

	
	 ██▓███   ██▀███   ▒█████   ▄▄▄██▀▀▀▓█████  ▄████▄  ▄▄▄█████▓
	▓██░  ██▒▓██ ▒ ██▒▒██▒  ██▒   ▒██   ▓█   ▀ ▒██▀ ▀█  ▓  ██▒ ▓▒
	▓██░ ██▓▒▓██ ░▄█ ▒▒██░  ██▒   ░██   ▒███   ▒▓█    ▄ ▒ ▓██░ ▒░
	▒██▄█▓▒ ▒▒██▀▀█▄  ▒██   ██░▓██▄██▓  ▒▓█  ▄ ▒▓▓▄ ▄██▒░ ▓██▓ ░ 
	▒██▒ ░  ░░██▓ ▒██▒░ ████▓▒░ ▓███▒   ░▒████▒▒ ▓███▀ ░  ▒██▒ ░ 
	▒▓▒░ ░  ░░ ▒▓ ░▒▓░░ ▒░▒░▒░  ▒▓▒▒░   ░░ ▒░ ░░ ░▒ ▒  ░  ▒ ░░   
	░▒ ░       ░▒ ░ ▒░  ░ ▒ ▒░  ▒ ░▒░    ░ ░  ░  ░  ▒       ░    
	░░         ░░   ░ ░ ░ ░ ▒   ░ ░ ░      ░   ░          ░      
	            ░         ░ ░   ░   ░      ░  ░░ ░               
	                                           ░                 


			$(GREEN)Version: $(PURPLE)$(VERSION)
			$(GREEN)Author: $(PURPLE)$(AUTHOR)
			$(GREEN)Github: $(PURPLE)$(GITHUB)
			$(GREEN)CC Version: $(PURPLE)$(COMPILER_VERSION)
			$(GREEN)Your OS Name: $(PURPLE)$(DISTRO)
			$(GREEN)Flag Set: $(PURPLE)$(CFLAGS)$(RST)




$(RST)
endef
export banner

.SILENT:

all:  BANNER $(eval SHELL:=/bin/zsh)
	@echo -e "\t\t\t\t$(GREEN)H $(PURPLE)E $(GREEN)L $(PURPLE)P  $(GREEN)M $(PURPLE)A $(GREEN)I $(PURPLE)N\t\n"
	@echo -e "\t$(GREEN)┌─────────────────────────────┬─────────────────────────────────────────┐"
	@echo -e "\t$(GREEN)│ $(PURPLE)COMMAND:$(GREEN)                    │ $(PURPLE)DESCRIPTION:$(GREEN)                            │"
	@echo -e "\t$(GREEN)│ $(PURPLE)build$(GREEN)     	              │ $(PURPLE)build the project$(GREEN)                       │"
	@echo -e "\t$(GREEN)│ $(PURPLE)clean$(GREEN)                       │ $(PURPLE)clean object files$(GREEN)                      │"
	@echo -e "\t$(GREEN)│ $(PURPLE)fclean$(GREEN)                      │ $(PURPLE)clean all$(GREEN)                               │"
	@echo -e "\t$(GREEN)│ $(PURPLE)help$(GREEN)                        │ $(PURPLE)show this main$(GREEN)                          │"
	@echo -e "\t$(GREEN)│ $(PURPLE)re$(GREEN)                          │ $(PURPLE)remake the project$(GREEN)                      │"
	@echo -e "\t$(GREEN)│ $(PURPLE)hash$(GREEN)                        │ $(PURPLE)get hash of files$(GREEN)                       │"
	@echo -e "\t$(GREEN)│ $(PURPLE)test$(GREEN)                        │ $(PURPLE)test your project$(GREEN)                       │"
	@echo -e "\t$(GREEN)└─────────────────────────────┴─────────────────────────────────────────┘$(RST)\n\n\n"

build: BANNER header $(NAME) $(STATIC_NAME) $(eval SHELL:=/bin/zsh)

header:
	@echo -e "$(CHECK) Check header files is present in $(GREEN)$(INCLUDES_DIR)$(RST) !"
	@echo -e "$(CHECK)	$(H_FILE_ICO_PURPLE) $(GREEN)$(HNF)$(RST) Headers founds in $(GREEN)$(INCLUDES_DIR)$(RST) !"

.ONESHELL:
BANNER:
	clear
	printf "$$banner"

$(OBJDIR):
	@mkdir -p $(sort $(addprefix $(OBJDIR)/, $(dir $(SRCS))))

.ONESHELL:
$(OBJDIR)/%.o: %.c
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
$(NAME): static $(OBJDIR) $(OBJS)
	@mkdir -p $(DIST)

ifeq ($(IS_LIBRARY), true)
	@$(CC) $(CFLAGS) $(OBJS) -shared -o $(NAME)
else
	@$(CC) $(CFLAGS) $(OBJS) -o $(NAME)
endif

	@echo -e "\n\n\n$(CHECK) Project has been compiled and generated $(GREEN)successfully$(RST) !"
	@echo -e "$(CHECK) Shared library or executable generated at $(GREEN)$(NAME) $(RST) !"
	@echo -e "$(CHECK) Static library or executable generated at $(GREEN)$(STATIC_NAME) $(RST) !\n\n"

static: $(OBJDIR) $(OBJS)
	@mkdir -p $(DIST)
ifeq ($(IS_LIBRARY), true)
	@ar -rcs $(STATIC_NAME) $(OBJS)
else
	$(CC) $(CFLAGS) $(OBJS) -static -o $(NAME)
endif

clean:
	@echo -e "$(CHECK) Clean object directory !"
	@echo -e "[$(GREEN)+$(RST)] $(GREEN)$(shell echo $(OBJS) | wc -w )$(RST) Object files was removed $(GREEN)successfully$(RST) !"
	@rm -rf $(OBJS)
	@rm -rf $(OBJDIR)

fclean: clean
	@echo -e "$(CHECK) $(GREEN)$(STATIC_NAME)$(RST) was removed $(GREEN)successfully$(RST) !"
	@echo -e "$(CHECK) $(GREEN)$(NAME)$(RST) was removed $(GREEN)successfully$(RST) !"
	@rm -rf $(STATIC_NAME)
	@rm -rf $(NAME)
	@rm -rf $(DIST)
	@rm -rf dist

re: fclean build

hash: $(STATIC_NAME) $(NAME) BANNER build

	@echo -e "$(CHECK) Checksum Signature files:\n"

	@$(eval HASH=$(shell md5sum $(NAME) | cut -d ' ' -f1))
	@echo -e "$(CHECK) (MD5) $(GREEN)$(NAME) = ($(HASH))$(RST) !"
	@$(eval HASH=$(shell md5sum $(STATIC_NAME) | cut -d ' ' -f1))
	@echo -e "$(CHECK) (MD5) $(GREEN)$(STATIC_NAME) = ($(HASH))$(RST) !\n"
	
	@$(eval HASH=$(shell sha256sum $(NAME) | cut -d ' ' -f1))
	@echo -e "$(CHECK) (SHA256) $(GREEN)$(NAME) = ($(HASH))$(RST) !"
	@$(eval HASH=$(shell sha256sum $(STATIC_NAME) | cut -d ' ' -f1))
	@echo -e "$(CHECK) (SHA256) $(GREEN)$(STATIC_NAME) = ($(HASH))$(RST) !\n"

	@$(eval HASH=$(shell sha512sum $(NAME) | cut -d ' ' -f1))
	@echo -e "$(CHECK) (SHA512) $(GREEN)$(NAME) = ($(HASH))$(RST) !"
	@$(eval HASH=$(shell sha512sum $(STATIC_NAME) | cut -d ' ' -f1))
	@echo -e "$(CHECK) (SHA512) $(GREEN)$(STATIC_NAME) = ($(HASH))$(RST) !\n"

%.test: %.c
	$(CC) -Wall -Wextra -Werror $< -o $@ -I./inc -lcriterion $(STATIC_NAME)
	./$@

test:
	@docker build -t test_$(PROJECT_NAME) containers/test/
	@docker run --name test_$(PROJECT_NAME) --hostname test_$(PROJECT_NAME) -v ./:/project/ -t test_$(PROJECT_NAME)
	@docker stop test_$(PROJECT_NAME)
	@docker rm test_$(PROJECT_NAME)

build_test: $(TEST_OBJS)

test_clean:
	@rm -rf $(TEST_OBJS)
	@rm -rf $(OBJS)
	@rm -rf $(OBJDIR)

test_image_clean:
	@docker image rm test_$(PROJECT_NAME)

build_all:
	@docker compose up --build
	@docker compose down --rmi all

.PHONY: all build clean fclean re hash test build_test test_clean
