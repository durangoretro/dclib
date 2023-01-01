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
	LDA #$22
    JSR type
	JSR type
    
    JMP incsp8
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
	; else
	BRA end
	right_pixel:
	; then

	; end if
	end:
	RTS
.endproc
