# Name of the executable
NAME = exec.out

# CPP Make Variables
CXX := g++
CXXFLAGS = -Wall -Wextra -Werror -std=c++98
INCLUDES = -I include/

# Directories
BIN_DIR = ./bin
SRC_DIR = .
SRC_EXT = cpp
###▼▼▼<src-updater-do-not-edit-or-remove>▼▼▼
# **************************************************************************** #
# **   Generated with https://github.com/lorenuars19/makefile-src-updater   ** #
# **************************************************************************** #

SRCS = \
	./src/FortyTwo.cpp \
	./src/main.cpp \

HEADERS = \
	./includes/FortyTwo.hpp\

###▲▲▲<src-updater-do-not-edit-or-remove>▲▲▲

OBJS := $(SRCS:%.cpp=$(BIN_DIR)/%.o)

all : $(NAME)

$(NAME) : $(OBJS)
	@printf "\e[33;1m&&& $(SRCS) -- [$(CXXFLAGS)] \n>>> $(NAME)\e[0m\n"
	@$(CXX) $(CXXFLAGS) $(OBJS) -o $(NAME)

$(BIN_DIR):
	@mkdir -p $(BIN_DIR)

$(BIN_DIR)/%.o: $(SRC_DIR)/%.$(SRC_EXT) | $(BIN_DIR)
	@printf "\e[32;1m+++ $@ -- [$(CXXFLAGS)] \e[0m\n"
	@$(CXX) $(CXXFLAGS) $(INCLUDES) -c $< -o $@

clean:
	@printf "\e[31;1m--- $(OBJS)\e[0m\n"
	@rm -rf $(BIN_DIR)

fclean: clean
	@printf "\e[31;1m--- $(NAME)\e[0m\n"
	@rm -rf $(NAME)

re: fclean all

debug: CXXFLAGS += -D DEBUG=1 -g3
debug: re all

debug_san: CXXFLAGS += -D DEBUG=1 -g3 -fsanitize=address
debug_san: re all

.PHONY: all dir re clean fclean
