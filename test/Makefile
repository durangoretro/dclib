SOURCE_DIR=.
RESCOMP ?= ../../rescomp/target/rescomp.jar
BUILD_DIR ?= bin
CFG ?= ../cfg/durango16k.cfg
DCLIB ?= ../bin
DCINC ?= ../inc
PERDITA ?= ../../minimOS/emulation/perdita

all: $(BUILD_DIR)/test_ok

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(BUILD_DIR)/test_ok: $(BUILD_DIR)/test_sprites.dux $(BUILD_DIR)/test_qgraph.dux $(BUILD_DIR)/test_system.dux
	export PERDITA=$(PERDITA) && pytest -s

$(BUILD_DIR)/durango_testing.o: $(SOURCE_DIR)/durango_testing.asm
	ca65 -t none $(SOURCE_DIR)/durango_testing.asm -o $(BUILD_DIR)/durango_testing.o


$(BUILD_DIR)/test_qgraph.casm: $(BUILD_DIR) $(SOURCE_DIR)/test_qgraph.c
	cc65 -I $(DCINC) $(SOURCE_DIR)/test_qgraph.c -t none --cpu 6502 -o $(BUILD_DIR)/test_qgraph.casm
$(BUILD_DIR)/test_qgraph.o: $(BUILD_DIR)/test_qgraph.casm
	ca65 -t none $(BUILD_DIR)/test_qgraph.casm -o $(BUILD_DIR)/test_qgraph.o
$(BUILD_DIR)/test_qgraph.bin: $(BUILD_DIR)/test_qgraph.o
	ld65 -C $(CFG) $(BUILD_DIR)/test_qgraph.o $(DCLIB)/qgraph.lib $(DCLIB)/durango.lib $(DCLIB)/psv.lib -o $(BUILD_DIR)/test_qgraph.bin	
$(BUILD_DIR)/test_qgraph.dux: $(BUILD_DIR)/test_qgraph.bin
	java -jar ${RESCOMP} -m SIGNER -n $$(git log -1 | head -1 | sed 's/commit //' | cut -c1-8) -t QGRAPH-TEST -d "Test qgraph lib" -i $(BUILD_DIR)/test_qgraph.bin -o $(BUILD_DIR)/test_qgraph.dux


$(BUILD_DIR)/test_sprites.casm: $(BUILD_DIR) $(SOURCE_DIR)/test_sprites.c
	cc65 -I $(DCINC) $(SOURCE_DIR)/test_sprites.c -t none --cpu 6502 -o $(BUILD_DIR)/test_sprites.casm
$(BUILD_DIR)/test_sprites.o: $(BUILD_DIR)/test_sprites.casm
	ca65 -t none $(BUILD_DIR)/test_sprites.casm -o $(BUILD_DIR)/test_sprites.o
$(BUILD_DIR)/test_sprites.bin: $(BUILD_DIR)/test_sprites.o
	ld65 -C $(CFG) $(BUILD_DIR)/test_sprites.o $(DCLIB)/sprites.lib $(DCLIB)/durango.lib $(DCLIB)/psv.lib -o $(BUILD_DIR)/test_sprites.bin	
$(BUILD_DIR)/test_sprites.dux: $(BUILD_DIR)/test_sprites.bin
	java -jar ${RESCOMP} -m SIGNER -n $$(git log -1 | head -1 | sed 's/commit //' | cut -c1-8) -t SPRITES-TEST -d "Test sprites lib" -i $(BUILD_DIR)/test_sprites.bin -o $(BUILD_DIR)/test_sprites.dux
	

$(BUILD_DIR)/test_system.casm: $(BUILD_DIR) $(SOURCE_DIR)/test_system.c
	cc65 -I $(DCINC) $(SOURCE_DIR)/test_system.c -t none --cpu 6502 -o $(BUILD_DIR)/test_system.casm
$(BUILD_DIR)/test_system.o: $(BUILD_DIR)/test_system.casm
	ca65 -t none $(BUILD_DIR)/test_system.casm -o $(BUILD_DIR)/test_system.o
$(BUILD_DIR)/test_system.bin: $(BUILD_DIR)/test_system.o $(BUILD_DIR)/durango_testing.o
	ld65 -C $(CFG) $(BUILD_DIR)/test_system.o $(DCLIB)/system.lib $(DCLIB)/durango.lib $(DCLIB)/psv.lib $(BUILD_DIR)/durango_testing.o -o $(BUILD_DIR)/test_system.bin	
$(BUILD_DIR)/test_system.dux: $(BUILD_DIR)/test_system.bin
	java -jar ${RESCOMP} -m SIGNER -n $$(git log -1 | head -1 | sed 's/commit //' | cut -c1-8) -t SYSTEM-TEST -d "Test system lib" -i $(BUILD_DIR)/test_system.bin -o $(BUILD_DIR)/test_system.dux	
	


clean:
	rm -Rf $(BUILD_DIR)
