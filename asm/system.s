.include "durango_constants.inc"
.include  "zeropage.inc"
.PC02

.importzp  sp
.import incsp1
.import coords2mem

.export _setHiRes
.export _waitVSync
.export _readGamepad
.export _readKeyboard
.export _waitStart
.export _waitFrames
.export _halt
.export _calculate_coords
.export _read_keyboard_row
.export _get_bit
.export _addBCD
.export _render_image

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
    BIT GAMEPAD_VALUE1
    BMI exit_loop
    BVS exit_loop
    BIT GAMEPAD_VALUE2
    BMI exit_loop
    BVS exit_loop
    LDA KEYBOARD_CACHE
    BNE exit_loop
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

.proc _readKeyboard: near
    TAX
    LDA KEYBOARD_CACHE, X
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
    STA KEYBOARD
    LDA KEYBOARD
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
	; If reached end
	BCC end
	LDA #$99
	STA DATA_POINTER
	STA DATA_POINTER+1
	STA DATA_POINTER+2
	STA DATA_POINTER+3

	end:
    ; CLEAR CARRY AND DECIMAL MODE
    CLC
    CLD
    RTS
.endproc

.proc _render_image: near
    ; Read pointer location
    STA DATA_POINTER
    STX DATA_POINTER+1
    
    ; Init video pointer
    LDA #>SCREEN_3
    STA VMEM_POINTER+1
    STZ VMEM_POINTER
    rle_loop:
	LDY #0				; always needed as part of the loop
	LDA (DATA_POINTER), Y		; get command
	INC DATA_POINTER				; advance read pointer
	BNE rle_0
	INC DATA_POINTER+1
    rle_0:
	TAX					; command is just a counter
	BMI rle_u		; negative count means uncompressed string
    ; * compressed string decoding ahead *
	BEQ rle_exit		; 0 repetitions means end of 'file'
    ; multiply next byte according to count
	LDA (DATA_POINTER), Y		; read immediate value to be repeated
    rc_loop:
	STA (VMEM_POINTER), Y	; store one copy
	INY				; next copy, will never wrap as <= 127
	DEX				; one less to go
	BNE rc_loop
    ; burst generated, must advance to next command!
	INC DATA_POINTER
	BNE rle_next		; usually will skip to common code
	INC DATA_POINTER+1
	BNE rle_next	; no need for BRA
    ; * uncompressed string decoding ahead *
    rle_u:
	LDA (DATA_POINTER), Y	; read immediate value to be sent, just once
	STA (VMEM_POINTER), Y	; store it just once
	INY				; next byte in chunk, will never wrap as <= 127
	INX				; one less to go
	BNE rle_u
	TYA					; how many were read?
    rle_adv:
	CLC
	ADC DATA_POINTER				; advance source pointer accordingly (will do the same with destination)
	STA DATA_POINTER
	BCC rle_next		; check possible carry
	INC DATA_POINTER+1
    ; * common code for destination advence, either from compressed or un compressed
    rle_next:
	TYA					; once again, these were the transferred/repeated bytes
	CLC
	ADC VMEM_POINTER				; advance desetination pointer accordingly
	STA VMEM_POINTER
	BCC rle_loop		; check possible carry
	INC VMEM_POINTER+1
	BNE rle_loop		; no need for BRA
    ; *** end of code ***
    rle_exit:
    RTS
.endproc
