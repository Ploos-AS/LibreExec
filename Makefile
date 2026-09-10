CC ?= cc
CFLAGS ?= -std=c11 -Wall -Wextra -Werror -pedantic -O2
CPPFLAGS ?= -Iinclude
PYTHON ?= python3

BUILD := build
OBJ := $(BUILD)/core.o

.PHONY: all check clean

all: $(OBJ)

$(BUILD):
	mkdir -p $(BUILD)

$(OBJ): src/core.c include/libreexec/base.h | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c src/core.c -o $(OBJ)

check: all
	$(PYTHON) tests/check_m0.py

clean:
	rm -rf $(BUILD)
