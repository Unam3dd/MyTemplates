include ./config/colors.mk
include ./config/project.mk
include ./config/files.mk

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
			$(GREEN)Project Version: $(PURPLE)$(PROJECT_NAME)
			$(GREEN)CC Version: $(PURPLE)$(COMPILER_VERSION)
			$(GREEN)Your OS Name: $(PURPLE)$(DISTRO)
			$(GREEN)Flag Set: $(PURPLE)$(CFLAGS)
			$(GREEN)Project Language: $(PROJECT_INC_ICO) $(PROJECT_SRC_ICO)$(RST)



$(RST)
endef
export banner
