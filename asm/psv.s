; Debug procedures
.export _consoleLogHex
.export _consoleLogWord
.export _consoleLogBinary
.export _consoleLogDecimal
.export _consoleLogChar
.export _consoleLogStr
.export _startStopwatch
.export _stopStopwatch

VSP = $df93
VSP_CONFIG = $df94

; Debug modes
DEBUG_HEX = $00
DEBUG_CHAR = $01
DEBUG_BINARY = $02
DEBUG_DECIMAL = $03
STOPWATCH_START = $FB
STOPWATCH_STOP = $FC

; Lib zeropage
VMEM_POINTER = $10
DATA_POINTER = $12
X_COORD = $14
Y_COORD = $15
TEMP1 = $16
TEMP2 = $17

; ------ DEBUG PROCEDURES

.proc  _consoleLogHex: near
    ; Set virtual serial port in hex mode
    LDX #DEBUG_HEX
	STX VSP_CONFIG
    ; Send value to virtual serial port
    STA VSP
    RTS
.endproc

.proc  _consoleLogWord: near
    ; Set virtual serial port in hex mode
    LDY #DEBUG_HEX
	STY VSP_CONFIG
    ; Send value to virtual serial port
    STA VSP
    STX VSP
    RTS
.endproc

.proc  _consoleLogBinary: near
    ; Set virtual serial port in hex mode
    LDX #DEBUG_BINARY
	STX VSP_CONFIG
    ; Send value to virtual serial port
    STA VSP
    RTS
.endproc

.proc  _consoleLogDecimal: near
    ; Set virtual serial port in hex mode
    LDX #DEBUG_DECIMAL
	STX VSP_CONFIG
    ; Send value to virtual serial port
    STA VSP
    RTS
.endproc

.proc  _consoleLogChar: near
    ; Set virtual serial port in ascii mode
    LDX #DEBUG_CHAR
    STX VSP_CONFIG
    ; Send value to virtual serial port
    STA VSP
    RTS
.endproc

.proc  _consoleLogStr: near
    ; Get data pointer from procedure args
    STA DATA_POINTER
    STX DATA_POINTER+1
    ; Set virtual serial port in ascii mode
    LDA #DEBUG_CHAR
    STA VSP_CONFIG
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

.proc _startStopwatch: near
    LDA #STOPWATCH_START
    STA VSP_CONFIG
    RTS
.endproc

.proc _stopStopwatch: near
    LDA #STOPWATCH_STOP
    STA VSP_CONFIG
    RTS
.endproc
