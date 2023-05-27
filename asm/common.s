.include "durango_constants.inc"
.PC02

.export coords2mem
.export readchar
.export keyrow1

.proc coords2mem: near
    ; Calculate Y coord
    STZ VMEM_POINTER
    LDA Y_COORD
    LSR
    ROR VMEM_POINTER
    LSR
    ROR VMEM_POINTER
    ADC #$60
    STA VMEM_POINTER+1
    ; Calculate X coord
    LDA X_COORD
    LSR
    CLC
    ADC VMEM_POINTER
    STA VMEM_POINTER
    BCC skip_upper
    INC VMEM_POINTER+1
    skip_upper:
    RTS
.endproc

.proc readchar: near
    LDX KEYBOARD_CACHE
    LDA keyrow1,X
    RTS
.endproc


;#define KEY_SPACE 0x80
;#define KEY_INTRO 0x40
;#define KEY_SHIFT 0x20
;#define KEY_P 0x10
;#define KEY_0 0x08
;#define KEY_A 0x04
;#define KEY_Q 0x02
;#define KEY_1 0x01


keyrow1: 
;      00  01  02  03  04  05  06  07  08  09  0a  0b  0c  0d  0e 0f
.byte $00,$41,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
