.include "durango_constants.inc"
.PC02

.importzp sp
.import incsp1

.export _playMelody

.segment  "CODE"


.proc _playMelody: near
    ; Read pointer location
    STA DATA_POINTER
    STX DATA_POINTER+1
    JSR $FE00
.endproc



