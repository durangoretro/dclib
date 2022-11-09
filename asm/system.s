.include "durango_constants.inc"
.PC02

.export _setHiRes
.export _waitVSync
.export _readGamepad
.export _waitStart
.export _waitFrames
.export _halt
.export _calculate_coords

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

    ; Calculate Y coord
    STZ VMEM_POINTER
    LDA Y_COORD
    LSR
    ROR VMEM_POINTER
    LSR
    ROR VMEM_POINTER
    ADC #$60
    STA VMEM_POINTER+1
    ; Calculate X coord
    LDA X_COORD
    LSR
    CLC
    ADC VMEM_POINTER
    STA VMEM_POINTER
    BCC skip_upper
    INC VMEM_POINTER+1
    skip_upper:
	
    ; Write mem position to struct
    LDA VMEM_POINTER
    LDY #2
    STA (DATA_POINTER),y
    LDA VMEM_POINTER+1
    INY
    STA (DATA_POINTER),y
    
    RTS
.endproc
