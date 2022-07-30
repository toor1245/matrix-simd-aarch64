LFLAGS =
ASMOPS =-Iinclude

SRC_DIR=src
BUILD_DIR=build

all: entry

clean:
	rm -rf $(BUILD_DIR)

$(BUILD_DIR)/%_s.o: $(SRC_DIR)/%.S
	gcc $(ASMOPS) -MMD -c $< -o $@ -ggdb

ASM_FILES = $(wildcard $(SRC_DIR)/*.S)
OBJ_FILES = $(ASM_FILES:$(SRC_DIR)/%.S=$(BUILD_DIR)/%_s.o)

DEP_FILES = $(OBJ_FILES:%.o=%.d)
-include $(DEP_FILES)

entry: $(OBJ_FILES)
	gcc -o $(BUILD_DIR)/matrix $(OBJ_FILES) -ggdb
