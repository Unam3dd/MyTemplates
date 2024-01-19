LINE_SIZE=20

# Top Bar, $1 = length of line

define top_bar
	echo -en "┌"
	for ((i = 0; i < $(LINE_SIZE); i++)); do echo -en "─"; done
	echo -e "┐"
endef

# First Parameter is your string

define string_bar
	$(eval LEN_ARG:= $(shell echo -ne $(1) | wc -m))
	$(eval PADDING:= $(shell echo -e $(LINE_SIZE)-$(LEN_ARG) | bc))
	echo -ne "│$(1)"
	for ((i = 1; i < $(PADDING); i++)); do echo -en '\x20'; done
	echo -e "│"
endef

# Same as Top bar

define bot_bar
	echo -en "└"
	for ((i = 0; i < $(1); i++)); do echo -en "─"; done
	echo -e "┘"
endef
