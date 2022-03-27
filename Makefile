# Name of the executable
NAME = exec.out

# CPP Make Variables
CXX := g++
CXXFLAGS = -Wall -Wextra -Werror -std=c++98
INCLUDES = -I includes/

# Directories
BIN_DIR = ./bin
SRC_DIR = .
SRC_EXT = cpp

# Use Bash not SH
SHELL := bash

###▼▼▼<src-updater-do-not-edit-or-remove>▼▼▼
# **************************************************************************** #
# **   Generated with https://github.com/lorenuars19/makefile-src-updater   ** #
# **************************************************************************** #

SRCS = \

HEADERS = \

###▲▲▲<src-updater-do-not-edit-or-remove>▲▲▲

OBJS := $(SRCS:%.cpp=$(BIN_DIR)/%.o)

.PHONY: all dir re clean fclean run

all : $(NAME) run

$(NAME) : $(OBJS)
	@printf "\e[33;1m&&& Linking $(SRCS) -- [$(CXXFLAGS)] \n>>> $(NAME)\e[0m\n"
	@$(CXX) $(CXXFLAGS) $(OBJS) -o $(NAME)

$(BIN_DIR):
	@mkdir -p $(BIN_DIR)

$(BIN_DIR)/%.o: $(SRC_DIR)/%.$(SRC_EXT) | $(BIN_DIR)
	@printf "\e[32;1m+++ Compiling $< -- [$(CXXFLAGS)] \e[0m\n"
	@mkdir -p $(@D)
	@$(CXX) $(CXXFLAGS) $(INCLUDES) -c $< -o $@

clean:
	@printf "\e[31;1m--- $(OBJS)\e[0m\n"
	@rm -rf $(BIN_DIR)

fclean: clean
	@printf "\e[31;1m--- $(NAME)\e[0m\n"
	@rm -rf $(NAME)

re: fclean all

no_debug: CXXFLAGS += -D NO_DEBUG
no_debug: re all

debug: CXXFLAGS += -D DEBUG=1 -g3
debug: re all

debug_san: CXXFLAGS += -D DEBUG=1 -g3 -fsanitize=address
debug_san: re all

gen_class:
	bash cpp_gen.sh

run:
	@printf "\e[34;1m>./ Running -- ./$(NAME)\e[0m\n"
	@read -n 1 -p "Press any key to continue ..."

	./$(NAME)
