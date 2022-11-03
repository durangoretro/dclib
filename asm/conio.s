.include "durango_constants.inc"
.PC02

.export _conio_init
.export _printf

.proc  _printf: near
    ; Get data pointer from procedure args
    STA DATA_POINTER
    STX DATA_POINTER+1
    
    
    ; Iterator
    LDY #$00
    loop:
    LDA (DATA_POINTER),Y
    BEQ end
    STA VSP
    INY
    BNE loop
    end:
    RTS
.endproc


.proc  _conio_init: near
    LDA #VSP_ASCII
    STA VSP_CONFIG
    
    RTS
.endproc
