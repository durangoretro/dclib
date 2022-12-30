.include "durango_constants.inc"
.PC02

.importzp sp
.import incsp2
.import coords2mem

.export _printBCD


.proc _printBCD: near
	; Load Y coord
    LDY #1
    LDA (sp), Y
    STA X_COORD
    
    ; Load X coord
    INY
    LDA (sp), Y
    STA Y_COORD    

    ; Calculate coords
    JSR coords2mem
    
    LDA #$22
    STA (VMEM_POINTER)
    
    JMP incsp2
.endproc
