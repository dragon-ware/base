# Define some colors
GREEN=\e[1;32m
NC=\e[0m
# Tool chain setup
TOOLCHAIN = arm-none-eabi-
CC = $(TOOLCHAIN)gcc
# Directory macro
SRC = src
OBJ = obj
BIN = bin
# Architecture specific macro
CPU = arm1176jzf-s
CARGS = -mcpu=$(CPU) -fpic -ffreestanding -std=gnu99 -O2 -Wall -Wextra

SRC_FILES := $(wildcard $(SRC)/*.c)
OBJ_FILES := $(addprefix $(OBJ)/,$(notdir $(SRC_FILES:.c=.o)))

all: $(OBJ_FILES)
	@echo "Building all target " $(SRC_FILES)
	$(CC) $(CARGS) -c $(SRC)/startup.s -o $(OBJ)/startup.o	
	@echo "Linking final ELF file"
	mkdir -p $(BIN)
	$(CC) $(CARGS) -T $(SRC)/linker.ld -nostdlib $^ $(OBJ)/startup.o -o $(BIN)/kernel.elf
	@echo -e "${GREEN}Build Success${NC}"
	
$(OBJ)/%.o: $(SRC)/%.c
	mkdir -p $(OBJ)
	$(CC) $(CARGS) -c -o $@ $<

$(OBJ) :
	mkdir -p $@

run: all
	qemu-system-arm -m 256 -M raspi2 -serial stdio -kernel bin/kernel.elf 
clean :
	$(RM) -r $(OBJ)/*
	$(RM) -r $(BIN)/*
