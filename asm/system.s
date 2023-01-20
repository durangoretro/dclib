.include "durango_constants.inc"
.include  "zeropage.inc"
.PC02

.importzp  sp
.import incsp1
.import coords2mem

.export _setHiRes
.export _waitVSync
.export _readGamepad
.export _waitStart
.export _waitFrames
.export _halt
.export _calculate_coords
.export _read_keyboard_row
.export _get_bit
.export _addBCD

.proc _setHiRes: near
	CMP #0
	BNE hires
	LDA VIDEO_MODE
	AND #%01111111
	STA VIDEO_MODE
	BRA end
	hires:
	LDA VIDEO_MODE
	ORA #%10000000
	STA VIDEO_MODE
	end:
	RTS
.endproc

.proc _waitVSync: near
    ; Wait for vsync end.
    loop1:
    BIT SYNC
    BVS loop1
    ; Wait for vsync start
    loop2:
    BIT SYNC
    BVC loop2
    RTS
.endproc

.proc _waitStart: near
    loop:
    BIT $02
    BMI exit_loop
    BVS exit_loop
    BIT $03
    BMI exit_loop
    BVS exit_loop
    BRA loop
    exit_loop:
    RTS
.endproc

.proc _waitFrames: near
    TAX
    wait_vsync_end:
    BIT SYNC
    BVS wait_vsync_end
    wait_vsync_begin:
    BIT SYNC
    BVC wait_vsync_begin   
    DEX
    BNE wait_vsync_end
    RTS
.endproc

.proc _readGamepad: near
    TAX
    LDA GAMEPAD_VALUE1, X
    RTS
.endproc

; Stop
.proc _halt: near
    STP
.endproc

.proc _calculate_coords: near
    ; Read pointer location
    STA DATA_POINTER
    STX DATA_POINTER+1
    ;LDA X_COORD
    LDA (DATA_POINTER)
    STA X_COORD
    ; LDA Y_COORD
    LDY #1
    LDA (DATA_POINTER),y
    STA Y_COORD

    JSR coords2mem
	
    ; Write mem position to struct
    LDA VMEM_POINTER
    LDY #2
    STA (DATA_POINTER),y
    LDA VMEM_POINTER+1
    INY
    STA (DATA_POINTER),y
    
    RTS
.endproc

.proc _read_keyboard_row: near
    TAY
    LDA #1
    CPY #0
    BEQ exit
    loop:
    ASL
    DEY
    BNE loop
    exit:
    STA MISTREL_KEYBOARD
    LDA MISTREL_KEYBOARD
    RTS
.endproc

.proc _get_bit: near
    TAY
    LDA (sp)
    CPY #0
    BEQ end
    loop:
    LSR
    DEY
    BNE loop
    end:
    AND #%00000001
    JMP incsp1
.endproc

; value1+=value2
; long* value1, long* value2
.proc _addBCD: near
    LDY #4
    ; Load value1
    DEY
    LDA (sp), Y
    STA DATA_POINTER+1    
    DEY
    LDA (sp), Y
    STA DATA_POINTER
    
    ; Load value2
    DEY
    LDA (sp), Y
    STA RESOURCE_POINTER+1    
    DEY
    LDA (sp), Y
    STA RESOURCE_POINTER
    
    ; ADD WITH CARRY BYTE 1
    LDY #0
    LDA (DATA_POINTER),Y
    SED
    CLC
    ADC (RESOURCE_POINTER),Y
    STA (DATA_POINTER),Y
    ; ADD BYTE 2
    INY
    LDA (DATA_POINTER),Y
    ADC (RESOURCE_POINTER),Y
    STA (DATA_POINTER),Y
    ; ADD BYTE 3
    INY
    LDA (DATA_POINTER),Y
    ADC (RESOURCE_POINTER),Y
    STA (DATA_POINTER),Y
    ; ADD BYTE 4
    INY
    LDA (DATA_POINTER),Y
    ADC (RESOURCE_POINTER),Y
    STA (DATA_POINTER),Y
    
    ; CLEAR CARRY AND DECIMAL MODE
    CLC
    CLD
    RTS
.endproc
