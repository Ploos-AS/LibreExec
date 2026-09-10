CC ?= cc
CFLAGS ?= -std=c11 -Wall -Wextra -Werror -pedantic -O2
CPPFLAGS ?= -Iinclude
PYTHON ?= python3

BUILD := build
OBJ := $(BUILD)/core.o $(BUILD)/exec.o
TEST_EXEC := $(BUILD)/test_exec

.PHONY: all check check-m0 check-m1 clean

all: $(OBJ)

$(BUILD):
	mkdir -p $(BUILD)

$(BUILD)/core.o: src/core.c include/libreexec/base.h | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c src/core.c -o $@

$(BUILD)/exec.o: src/exec.c include/libreexec/exec.h include/libreexec/base.h | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c src/exec.c -o $@

$(TEST_EXEC): tests/test_exec.c $(BUILD)/exec.o | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) tests/test_exec.c $(BUILD)/exec.o -o $@

check-m0: all
	$(PYTHON) tests/check_m0.py

check-m1: $(TEST_EXEC)
	./$(TEST_EXEC)

check: check-m0 check-m1

clean:
	rm -rf $(BUILD)
