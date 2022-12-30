.include "durango_constants.inc"
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
    LDA $02, X
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
