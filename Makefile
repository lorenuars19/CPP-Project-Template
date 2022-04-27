# Name of the executable
NAME = exec.out

# CPP Make Variables
CXX := g++
CXXFLAGS = -Wall -Wextra -Werror -std=c++98
INCLUDES = -I includes/

# Directories
BIN_DIR = ./bin
SRC_EXT = cpp

# Use Bash not SH
SHELL := bash


###▼▼▼<src-updater-do-not-edit-or-remove>▼▼▼
# **************************************************************************** #
# **   Generated with https://github.com/lorenuars19/makefile-src-updater   ** #
# **************************************************************************** #

SRCS := \
	./src/FortyTwo.cpp \
	./src/main.cpp \

HEADERS := \
	./includes/FortyTwo.hpp\

###▲▲▲<src-updater-do-not-edit-or-remove>▲▲▲


OBJS := $(SRCS:%.cpp=$(BIN_DIR)/%.o)

.PHONY: all dir re clean fclean run

all : $(NAME) run


$(NAME) : $(OBJS)
	@printf "\e[33;1m&&& Linking $(SRCS) -- [$(CXXFLAGS)] \n>>> $(NAME)\e[0m\n"
	@$(CXX) $(CXXFLAGS) $(OBJS) -o $(NAME)

$(BIN_DIR):
	@mkdir -p $(BIN_DIR)

$(BIN_DIR)/%.o: %.$(SRC_EXT) $(HEADERS) | $(BIN_DIR)
	@printf "\e[32;1m+++ Compiling $< - $@ -- [$(CXXFLAGS)] \e[0m\n"
	@mkdir -p $(@D)
	@$(CXX) $(CXXFLAGS) $(INCLUDES) -c $< -o $@

clean:
	@printf "\e[31;1m--- $(OBJS)\e[0m\n"
	@rm -rf $(BIN_DIR)

fclean: clean
	@printf "\e[31;1m--- $(NAME)\e[0m\n"
	@rm -rf $(NAME)

re: fclean all

soft: CXXFLAGS =
soft: re all

no_dbg: CXXFLAGS += -D NO_DEBUG
no_dbg: re all

dbg: CXXFLAGS += -D DEBUG=1 -g3
dbg: re all

dbg_san: CXXFLAGS += -D DEBUG=1 -g3 -fsanitize=address
dbg_san: re all

dbg_lek: CXXFLAGS += -D DEBUG=1 -g3 -fsanitize=address -fsanitize=leak
dbg_lek: export LSAN_OPTIONS=report_objects=1
dbg_lek: export ASAN_OPTIONS=detect_leaks=1
dbg_lek: CXX = g++_
dbg_lek: re all

gen_class:
	bash cpp_gen.sh

run: RUN_ARGS ?=
run:
	@printf "\e[34;1m>./ Running -- ./$(NAME) [$(RUN_ARGS)]\e[0m\n"
	@read -n 1 -p "Press any key to continue ..."

	./$(NAME) $(RUN_ARGS)
