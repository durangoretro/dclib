.include "durango_constants.inc"
.PC02

.importzp sp
.import incsp8
.import coords2mem

.export _printBCD

; Font 5x8
.proc _printBCD: near
	; Load X coord
    LDY #7
    LDA (sp), Y
    STA X_COORD    
    
    ; Load Y coord
    DEY
    LDA (sp), Y
    STA Y_COORD
    
    ; Load font
    DEY
    LDA (sp), Y
    STA RESOURCE_POINTER    
    DEY
    LDA (sp), Y
    STA RESOURCE_POINTER+1
        

    ; Calculate coords
    JSR coords2mem
	STZ TEMP1
	
	; Load color
	LDA #$00
	STA COLOUR
	LDA #$FF
	STA PAPER
	
	; type
	LDY #$00
	LDA #%10101010
	STA (RESOURCE_POINTER),Y
	INY
	LDA #%01010101
	STA (RESOURCE_POINTER),Y
	INY
	LDA #%10101010
	STA (RESOURCE_POINTER),Y
	INY
	LDA #%01010101
	STA (RESOURCE_POINTER),Y
	JSR type_letter
	
    JMP incsp8
.endproc

.proc type_letter: near
	; Load First byte
	LDY #$00
	LDA (RESOURCE_POINTER),Y
	; Type row 1
	ASL
	JSR type_carry
	ASL
	JSR type_carry
	ASL
	JSR type_carry
	ASL
	JSR type_carry
	ASL
	JSR type_carry

	; Type row 2
	JSR next_row
	ASL
	JSR type_carry
	ASL
	JSR type_carry
	ASL
	JSR type_carry
	LDY #$01
	LDA (RESOURCE_POINTER),Y
	ASL
	JSR type_carry
	ASL
	JSR type_carry
	
	; Type row 3
	JSR next_row
	ASL
	JSR type_carry
	ASL
	JSR type_carry
	ASL
	JSR type_carry
	ASL
	JSR type_carry
	ASL
	JSR type_carry
	
	; Type row 4
	JSR next_row
	ASL
	JSR type_carry
	LDY #$02
	LDA (RESOURCE_POINTER),Y
	ASL
	JSR type_carry
	ASL
	JSR type_carry
	ASL
	JSR type_carry
	ASL
	JSR type_carry
	
	; Type row 5
	JSR next_row
	ASL
	JSR type_carry
	ASL
	JSR type_carry
	ASL
	JSR type_carry
	ASL
	JSR type_carry
	LDY #$03
	LDA (RESOURCE_POINTER),Y
	ASL
	JSR type_carry
	
	; Type row 6
	JSR next_row
	ASL
	JSR type_carry
	ASL
	JSR type_carry
	ASL
	JSR type_carry
	ASL
	JSR type_carry
	ASL
	JSR type_carry
	
	; Type row 7
	JSR next_row
	ASL
	JSR type_carry
	ASL
	JSR type_carry
	LDY #$04
	LDA (RESOURCE_POINTER),Y
	ASL
	JSR type_carry
	ASL
	JSR type_carry
	ASL
	JSR type_carry
	
	; Type row 8
	JSR next_row
	ASL
	JSR type_carry
	ASL
	JSR type_carry
	ASL
	JSR type_carry
	ASL
	JSR type_carry
	ASL
	JSR type_carry

	RTS
.endproc

.proc next_row: near
	PHA
	STZ TEMP1
	LDA VMEM_POINTER
	CLC
	ADC #62
	STA VMEM_POINTER
	BCC skip
	INC VMEM_POINTER+1	
	skip:
	PLA
	RTS
.endproc


.proc type_carry: near
	; Keep A
	PHA
	; If carry set
	BCC carry_set
		; Load ink color
		LDA COLOUR
	; else
	BRA end
	carry_set:
		; Load paper color
		LDA PAPER
	;end if
	end:
	JSR type
	; Restore A
	PLA
	RTS
.endproc

.proc type: near
	; If left pixel
	BIT TEMP1
	BMI right_pixel
	; then
		; Keep left pixel from color
		AND #$F0
		; Store single color in temp2
		STA TEMP2
		; Load original pixel pair
		LDA (VMEM_POINTER)
		; Clear left pixel
		AND #$0F
		; Paint left pixel
		ORA TEMP2
		; Save pixel pair
		STA (VMEM_POINTER)
		; Increment position
		CLC
		LDA #%10000000
		ADC TEMP1
		STA TEMP1
	; else
	BRA end
	right_pixel:
	; then
		; Keep right pixel from color
		AND #$0F
		; Store single color in temp2
		STA TEMP2
		; Load original pixel pair
		LDA (VMEM_POINTER)
		; Clear right pixel
		AND #$F0
		; Paint left pixel
		ORA TEMP2
		; Save pixel pair
		STA (VMEM_POINTER)
		; Increment position
		CLC
		LDA #%10000000
		ADC TEMP1
		STA TEMP1
		INC VMEM_POINTER
		BNE end
		INC VMEM_POINTER+1
	; end if
	end:
	RTS
.endproc
