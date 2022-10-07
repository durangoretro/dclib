ASM_DIR=asm
BUILD_DIR=bin

all: $(BUILD_DIR)/durango.lib $(BUILD_DIR)/psv.lib $(BUILD_DIR)/system.lib $(BUILD_DIR)/sprites.lib

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(BUILD_DIR)/crt0.o: $(ASM_DIR)/crt0.s $(BUILD_DIR)
	ca65 -t none $(ASM_DIR)/crt0.s -o $(BUILD_DIR)/crt0.o
	
$(BUILD_DIR)/durango.lib: $(BUILD_DIR)/crt0.o $(BUILD_DIR)
	cp /usr/share/cc65/lib/supervision.lib $(BUILD_DIR)/durango.lib && ar65 a $(BUILD_DIR)/durango.lib $(BUILD_DIR)/crt0.o


$(BUILD_DIR)/psv.o: $(ASM_DIR)/psv.s $(BUILD_DIR)
	ca65 -t none $(ASM_DIR)/psv.s -o $(BUILD_DIR)/psv.o

$(BUILD_DIR)/psv.lib: $(BUILD_DIR)/psv.o $(BUILD_DIR)
	ar65 r $(BUILD_DIR)/psv.lib $(BUILD_DIR)/psv.o
	
	
$(BUILD_DIR)/system.o: $(ASM_DIR)/system.s $(BUILD_DIR)
	ca65 -t none $(ASM_DIR)/system.s -o $(BUILD_DIR)/system.o

$(BUILD_DIR)/system.lib: $(BUILD_DIR)/system.o $(BUILD_DIR)
	ar65 r $(BUILD_DIR)/system.lib $(BUILD_DIR)/system.o


$(BUILD_DIR)/sprites.o: $(ASM_DIR)/sprites.s $(BUILD_DIR)
	ca65 -t none $(ASM_DIR)/sprites.s -o $(BUILD_DIR)/sprites.o

$(BUILD_DIR)/system.lib: $(BUILD_DIR)/sprites.o $(BUILD_DIR)
	ar65 r $(BUILD_DIR)/sprites.lib $(BUILD_DIR)/sprites.o
	

clean:
	rm -Rf $(BUILD_DIR)
