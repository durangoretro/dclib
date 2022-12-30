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
        

    ; Calculate coords
    JSR coords2mem
    
    LDA #$22
    STA (VMEM_POINTER)
    
    JMP incsp8
.endproc
