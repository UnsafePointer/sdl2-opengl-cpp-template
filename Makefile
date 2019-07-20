CXX		  := g++
CXX_FLAGS := -Wall -Wextra -std=c++17 -ggdb `sdl2-config --cflags`

OPENGL_API := 4.5
GLAD_BUILD_DIR := glad

BIN		:= bin
SRC		:= src
INCLUDE	:= include
LIB		:= lib

LIBRARIES	:= `sdl2-config --libs` -ldl
EXECUTABLE	:= main


all: $(BIN)/$(EXECUTABLE)

run: clean all
	clear
	./$(BIN)/$(EXECUTABLE)

$(GLAD_BUILD_DIR)/src/*.c:
	python -m glad --out-path=$(GLAD_BUILD_DIR) --api="gl=$(OPENGL_API)" --extensions="GL_KHR_debug" --generator="c"

$(BIN)/$(EXECUTABLE): $(SRC)/*.cpp $(GLAD_BUILD_DIR)/src/*.c
	$(CXX) $(CXX_FLAGS) -I$(INCLUDE) -I$(GLAD_BUILD_DIR)/include -L$(LIB) $^ -o $@ $(LIBRARIES)

clean:
	rm -rf $(BIN)/*
	rm -rf $(GLAD_BUILD_DIR)
