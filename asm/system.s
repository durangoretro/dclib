.include "durango_constants.inc"
.PC02

; System procedures
.export _waitVSync
.export _readGamepad
.export _waitStart
.export _waitFrames
.export _halt

; ----- SYSTEM PROCEDURES ---
.proc _waitVSync: near
    ; Wait for vsync end.
    loop1:
    BIT SYNC
    BVS loop1
    ; Wait for vsync start
    loop2:
    BIT SYNC
    BVC loop2
    RTS
.endproc

.proc _waitStart: near
    loop:
    BIT $02
    BMI exit_loop
    BVS exit_loop
    BIT $03
    BMI exit_loop
    BVS exit_loop
    BRA loop
    exit_loop:
    RTS
.endproc

.proc _waitFrames: near
    TAX
    wait_vsync_end:
    BIT SYNC
    BVS wait_vsync_end
    wait_vsync_begin:
    BIT SYNC
    BVC wait_vsync_begin   
    DEX
    BNE wait_vsync_end
    RTS
.endproc

.proc _readGamepad: near
    TAX
    LDA $02, X
    RTS
.endproc

; Stop
.proc _halt: near
    STP
.endproc
