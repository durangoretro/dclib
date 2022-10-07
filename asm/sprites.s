.include "durango_constants.inc"
.PC02

.export _load_background

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
