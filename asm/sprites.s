.include "durango_constants.inc"
.PC02

.export _load_background
.export _clrscr
.export _draw_sprite

.proc _load_background: near
    ; Read pointer location
    STA DATA_POINTER
    STX DATA_POINTER+1
    
    ; Init video pointer
    LDA #>SCREEN_2
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
; alternate code, more compact but a bit slower
;		LDA #1
;		BNE rle_adv			; just advance source by 1 byte
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

.proc _clrscr: near
    ; Init data pointer
    LDA #>SCREEN_2
    STA DATA_POINTER+1
    STZ DATA_POINTER
    
    ; Init vmem pointer
    LDA #>SCREEN_3
    STA VMEM_POINTER+1
    STZ VMEM_POINTER
    
    loop:
    LDA (DATA_POINTER),Y
    STA (VMEM_POINTER),Y
    INY
    BNE loop
	INC DATA_POINTER+1
	INC VMEM_POINTER+1
    BPL loop

	RTS
.endproc

.proc render_sprite: near
    LDX HEIGHT
    loop2:
    LDY WIDTH
    DEY
    loop:
    LDA (RESOURCE_POINTER),Y
    STA (VMEM_POINTER),Y
    DEY
    BPL loop
    CLC
    LDA VMEM_POINTER
    ADC #$40
    STA VMEM_POINTER
    BCC skip
    INC VMEM_POINTER+1
    skip:
    CLC
    LDA RESOURCE_POINTER
    ADC WIDTH
    STA RESOURCE_POINTER
    BCC skip2
    INC RESOURCE_POINTER+1
    skip2:
    DEX
    BPL loop2
    RTS
.endproc

.proc _draw_sprite: near
    ; Read pointer location
    STA DATA_POINTER
    STX DATA_POINTER+1
    
    ; Video pointer
    LDY #2
    LDA (DATA_POINTER),Y
    STA VMEM_POINTER
    INY
    LDA (DATA_POINTER),Y
    STA VMEM_POINTER+1
    
    ; width & height
    INY
    LDA (DATA_POINTER),Y
    LSR
    STA WIDTH
    INY
    LDA (DATA_POINTER),Y
    STA HEIGHT
    
    ; Resource pointer
    LDY #6
    LDA (DATA_POINTER),Y
    STA RESOURCE_POINTER
    INY
    LDA (DATA_POINTER),Y
    STA RESOURCE_POINTER+1

    JSR render_sprite

    RTS
.endproc

.proc _move_sprite: near
    ; Read pointer location
    STA DATA_POINTER
    STX DATA_POINTER+1
    
    ; Video pointer
    LDY #2
    LDA (DATA_POINTER),Y
    STA VMEM_POINTER
    INY
    LDA (DATA_POINTER),Y
    STA VMEM_POINTER+1
    
    
    RTS
.endproc
