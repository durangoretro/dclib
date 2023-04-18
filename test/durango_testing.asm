.PC02

.export _read_int

.proc _read_int: near
    TAX
    LDA $8000,X
    PHA
    INX
    LDA $8000,X
    TAX
    PLA
    RTS
.endproc
