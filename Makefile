ASM_DIR=asm
BUILD_DIR=bin

all: $(BUILD_DIR)/durango.lib

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(BUILD_DIR)/crt0.o: $(ASM_DIR)/crt0.s $(BUILD_DIR)
	ca65 -t none $(ASM_DIR)/crt0.s -o $(BUILD_DIR)/crt0.o
	
$(BUILD_DIR)/durango.lib: $(BUILD_DIR)/crt0.o $(BUILD_DIR)
	cp /usr/share/cc65/lib/supervision.lib $(BUILD_DIR)/durango.lib && ar65 a $(BUILD_DIR)/durango.lib $(BUILD_DIR)/crt0.o

clean:
	rm -Rf $(BUILD_DIR)
