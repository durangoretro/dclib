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
	LDA #%11111111
	STA (RESOURCE_POINTER)
	JSR type_letter
	
    JMP incsp8
.endproc

.proc type_letter: near
	; Load First byte
	LDY #$00
	LDA (RESOURCE_POINTER),Y
	; Type first row
	ASL
	PHA
	JSR type_carry
	PLA
	
	ASL
	PHA
	JSR type_carry
	PLA

	ASL
	PHA
	JSR type_carry
	PLA

	ASL
	PHA
	JSR type_carry
	PLA

	ASL
	PHA
	JSR type_carry
	PLA

	RTS
.endproc


.proc type_carry: near
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
	JMP type
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
