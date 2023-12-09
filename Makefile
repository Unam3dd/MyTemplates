AUTHOR = Unam3dd
GITHUB = https://github.com/Unam3dd
VERSION = 0.0.1

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
C_FILE_ICO_BLUE				:= \033[38;5;69m$(C_FILE_ICO)
H_FILE_ICO_PURPLE			:= \033[38;5;98m$(H_FILE_ICO)

CHECK					:= [$(GREEN)\xE2\x9C\x94$(RST)]

# Output when project is generated
DIST = dist
OBJDIR = obj

# Includes and src dir
INCLUDES_DIR = inc
SRCS_DIR = src

NF=$(shell ls -lR $(SRCS_DIR) | grep -F .c | wc -l)
P=0
COUNTER=1
MOD=1
LOADING_ITER=0
FILE_SIZE=0
BIN_FILE_SIZE=0
NF_O=0

# Name of the project

NAME = $(DIST)/supermath.so
STATIC_NAME = $(DIST)/supermath.a

SRCS = $(shell ls $(SRCS_DIR)/*.c 2>/dev/null)
OBJS = $(addprefix $(OBJDIR)/, $(SRCS:.c=.o)) 

vpath %.c $(SRCS_DIR)
vpath %.h $(INCLUDES_DIR)

# Compiler Options
CC   = gcc
CFLAGS = -Wall -Wextra -Werror -Iinc -pedantic -fPIE -DVERSION=\"$(VERSION)\"
COMPILER_VERSION = $(shell $(CC) --version | head -n1)


ifdef CLANG
	CFLAGS = clang
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


			Version: $(PURPLE)$(VERSION)
			$(GREEN)Author: $(PURPLE)$(AUTHOR)
			$(GREEN)Github: $(PURPLE)$(GITHUB)
			$(GREEN)CC Version: $(PURPLE)$(COMPILER_VERSION)$(RST)




$(RST)
endef
export banner

.SILENT:

all: BANNER $(NAME) $(STATIC_NAME) $(eval SHELL:=/bin/zsh)

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
	@$(CC) $(CFLAGS) $(OBJS) -shared -o $(NAME)
	@echo -e "\n\n\n$(CHECK) Project has been compiled and generated $(GREEN)successfully$(RST) !"
	@echo -e "$(CHECK) Shared library or executable generated at $(GREEN)$(NAME)$(RST) !"
	@echo -e "$(CHECK) Static library or executable generated at $(GREEN)$(STATIC_NAME)$(RST) !\n\n"

static: $(OBJDIR) $(OBJS)
	@mkdir -p $(DIST)
	@ar -rcs $(STATIC_NAME) $(OBJS)

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

re: fclean all

.PHONY: all clean fclean re
