CC ?= cc
CFLAGS ?= -std=c11 -Wall -Wextra -Werror -pedantic -O2
CPPFLAGS ?= -Iinclude
PYTHON ?= python3

CROSS_CC ?= m68k-amigaos-gcc
CROSS_OBJDUMP ?= m68k-amigaos-objdump
CROSS_CFLAGS ?= -m68000 -std=c11 -Wall -Wextra -Werror -ffreestanding -fno-common -Os
CROSS_CPPFLAGS ?= -Iinclude

BUILD := build
CROSS_BUILD := $(BUILD)/m68k
OBJ := $(BUILD)/core.o $(BUILD)/exec.o
CROSS_OBJ := $(CROSS_BUILD)/core.o $(CROSS_BUILD)/exec.o
M2_OBJ := $(CROSS_BUILD)/startup.o $(CROSS_BUILD)/kernel.o
TEST_EXEC := $(BUILD)/test_exec

.PHONY: all check check-m0 check-m1 check-m1_1 check-m2_0 cross cross-check m2-objects clean

all: $(OBJ)

$(BUILD):
	mkdir -p $(BUILD)

$(CROSS_BUILD):
	mkdir -p $(CROSS_BUILD)

$(BUILD)/core.o: src/core.c include/libreexec/base.h | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c src/core.c -o $@

$(BUILD)/exec.o: src/exec.c include/libreexec/exec.h include/libreexec/base.h | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c src/exec.c -o $@

$(TEST_EXEC): tests/test_exec.c $(BUILD)/exec.o | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) tests/test_exec.c $(BUILD)/exec.o -o $@

$(CROSS_BUILD)/core.o: src/core.c include/libreexec/base.h | $(CROSS_BUILD)
	$(CROSS_CC) $(CROSS_CPPFLAGS) $(CROSS_CFLAGS) -c src/core.c -o $@

$(CROSS_BUILD)/exec.o: src/exec.c include/libreexec/exec.h include/libreexec/base.h | $(CROSS_BUILD)
	$(CROSS_CC) $(CROSS_CPPFLAGS) $(CROSS_CFLAGS) -c src/exec.c -o $@

$(CROSS_BUILD)/startup.o: kernel/startup.S | $(CROSS_BUILD)
	$(CROSS_CC) -m68000 -ffreestanding -c kernel/startup.S -o $@

$(CROSS_BUILD)/kernel.o: kernel/kernel.c include/libreexec/base.h | $(CROSS_BUILD)
	$(CROSS_CC) $(CROSS_CPPFLAGS) $(CROSS_CFLAGS) -c kernel/kernel.c -o $@

cross: $(CROSS_OBJ)

cross-check: cross
	@$(CROSS_CC) -dumpmachine | grep -Eq '^m68k-.*amigaos$$'
	@$(CROSS_OBJDUMP) -f $(CROSS_OBJ) | grep -q 'architecture: m68k'
	@echo "M1.1 68000 cross-build: PASS"

m2-objects: $(M2_OBJ)
	@$(CROSS_OBJDUMP) -f $(M2_OBJ) | grep -q 'architecture: m68k'
	@echo "M2.0 68000 boot objects: PASS"

check-m0: all
	$(PYTHON) tests/check_m0.py

check-m1: $(TEST_EXEC)
	./$(TEST_EXEC)

check-m1_1: cross-check

check-m2_0:
	$(PYTHON) tests/check_m2_0.py

check: check-m0 check-m1 check-m2_0

clean:
	rm -rf $(BUILD)
