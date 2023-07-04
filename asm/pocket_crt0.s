; ---------------------------------------------------------------------------
; crt0.s
; ---------------------------------------------------------------------------
;
; Startup code for cc65 (Single Board Computer version)

.import   _main

.export   __STARTUP__ : absolute = 1        ; Mark as startup
.import __STACKSTART__, __STACKSIZE__, __ROM_START__
.import    copydata, zerobss, initlib, donelib
.include "../asm/durango_constants.inc"
.include "zeropage.inc"

; Enable 65C02 instruction set
.PC02

; 200 -> IRQ
; 202 -> NMI
; 204 -> BRK
; 206 (4 BYTES)-> TICKS
; INC $206
; BNE
; INC $207
;....

; ---------------------------------------------------------------------------
; SEGMENT STARTUP
; ---------------------------------------------------------------------------
.segment  "STARTUP"


; Initialize Durango X
_init:
    ; Initialize 6502    
    SEI ; Disable interrupts
    CLD ; Clear decimal mode
    LDX #$FF ; Initialize stack pointer to $01FF
    TXS
    
    ; Clean up RAM ????
    
    ; Initialize cc65 stack pointer
    LDA #<(__STACKSTART__ + __STACKSIZE__)
    STA sp
    LDA #>(__STACKSTART__ + __STACKSIZE__)
    STA sp+1

    ; Initialize memory storage
    JSR zerobss
    JSR copydata
    JSR initlib
    
    ; Set up IRQ subroutine
    LDA #<_irq_int
    STA IRQ_ADDR
    LDA #>_irq_int
    STA IRQ_ADDR+1
    
    ; Set up NMI subroutine
    LDA #<_nmi_int
    STA NMI_ADDR
    LDA #>_nmi_int
    STA NMI_ADDR+1
    
    ; Initialize interrupts counter
    STZ $0206
    STZ $0207
    STZ $0208
    STZ $0209

    
    ; Enable Durango interrupts
    LDA #$01
    STA INT_ENABLE
    CLI

	; Initialize Durango Video
    LDA #$30
    STA VIDEO_MODE
    
    ; Call main()
    JSR _main

; Back from main (also the _exit entry):
_exit:
    ; Run destructors
    JSR donelib

; Stop
_stop:
    STP
    BRA _stop


; Maskable interrupt (IRQ) service routine
_irq_int:  
    ; Save registres and filter BRK
    PHA
    PHX
    PHY
    TSX
    LDA $104,X
    AND #$10
    BNE _stop
    ; Increment interrupt counter
    INC $0206
    BNE next
    INC $0207
    BNE next
    INC $0208
    BNE next
    INC $0209
    next:
    
	; Read buttons
    
    
    ; Restore registers and return
    PLY
    PLX
    PLA
    RTI 

; Non-maskable interrupt (NMI) service routine
_nmi_int:
    RTI

; ---------------------------------------------------------------------------
; SEGMENT DXHEAD
; ---------------------------------------------------------------------------
.segment "DXHEAD"

; 8 bytes
.byt $00
.byt "dP"
.byt "****"
.byt $0d

; 222 bytes
; TITLE_COMMENT[
.byt "##################################################"
.byt "##################################################"
.byt "##################################################"
.byt "##################################################"
.byt "######################";]


; 18 bytes
;DCLIB_COMMIT[
.byt "LLLLLLLL"
;]
;MAIN_COMMIT[
.byt "MMMMMMMM"
;]
;VERSION[
.byt "VV"
;]

; 8 bytes
;TIME[
.byt "TT"
;]
;DATE[
.byt "DD"
;]
;FILEZISE[
;.byt $00,$40,$00,$00 ; 16K
.byt $00,$60,$00,$00 ; 24K
;.byt $00,$80,$00,$00 ; 32K
;]


; ---------------------------------------------------------------------------
; SEGMENT METADATA
; ---------------------------------------------------------------------------
.segment "METADATA"
.byt "SIGNATURE:[##]$$"
.byt "DCLIB:[########]"
.byt "BUILD:[########]"
.byt "######DmOS######"
