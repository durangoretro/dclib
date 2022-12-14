; ---------------------------------------------------------------------------
; DURANGO HARDWARE CONSTANTS
; ---------------------------------------------------------------------------
; [HiRes Invert S1 S0    RGB LED NC NC]
VIDEO_MODE = $DF80
INT_ENABLE = $DFA0
GAMEPAD1 = $DF9C
GAMEPAD2 = $DF9D
VSP = $DF93
VSP_CONFIG = $DF94
SYNC = $DF88
SCREEN_0 = $0000
SCREEN_1 = $2000
SCREEN_2 = $4000
SCREEN_3 = $6000
MISTREL_KEYBOARD = $DF9B

; ---------------------------------------------------------------------------
; DURANGO CRT0 CONSTANTS
; ---------------------------------------------------------------------------
GAMEPAD_MODE1 = $00
GAMEPAD_MODE2 = $01
GAMEPAD_VALUE1 = $02
GAMEPAD_VALUE2 = $03
IRQ_ADDR = $0200
NMI_ADDR = $0202
KEY_PRESSED = $020A

; ---------------------------------------------------------------------------
; DURANGO LIB PAGE ZERO CONSTANTS
; ---------------------------------------------------------------------------
VMEM_POINTER = $10 ; $11
DATA_POINTER = $12 ; $13
X_COORD = $14
Y_COORD = $15
HEIGHT = $16
WIDTH = $17
RESOURCE_POINTER = $18 ; $19
COLOUR = $20
PAPER = $21
BACKGROUND_POINTER = $22; $22; $23
TEMP1 = $24
TEMP2 = $25
TEMP3 = $26
TEMP4 = $27

; ---------------------------------------------------------------------------
; DURANGO LIB MEMORY CONSTANTS
; ---------------------------------------------------------------------------
TEMP10 = $020A

; ---------------------------------------------------------------------------
; VIRTUAL SERIAL PORT CONSTANTS
; ---------------------------------------------------------------------------
VSP_FOPEN = $11
VSP_FREAD = $12
VSP_FWRITE = $13
VSP_FCLOSE = $1F
VSP_HEX = $F0
VSP_ASCII = $F1
VSP_BINARY = $F2
VSP_DECIMAL = $F3
VSP_STOPWATCH_START = $FB
VSP_STOPWATCH_STOP = $FC
VSP_DUMP = $FD
VSP_STACK = $FE
VSP_STAT = $FF
