.include "durango_constants.inc"
.PC02

;https://github.com/cc65/cc65/tree/master/libsrc/runtime
.importzp  sp
.import incsp3
.import incsp5

.export _drawFullScreen
.export _drawPixel
.export _drawRect
.export _drawLine


.proc _drawFullScreen: near
    LDX #>SCREEN_3
    STX VMEM_POINTER+1
    LDY #<SCREEN_3
    STY VMEM_POINTER
    loop:
    STA (VMEM_POINTER), Y
    INY
    BNE loop
	INC VMEM_POINTER+1
    BPL loop
    RTS
.endproc


.proc _drawPixel: near
    ; Load x coord
    LDY #$02
    LDA (sp), Y
    
    ; Load y coord
    LDY #$01
    LDA (sp), Y
    
    ; Load color
    LDY #$00
    LDA (sp), Y
    

    ; Remove args from stack
    JSR incsp3
    RTS
.endproc

.proc _drawRect:near
    ; Load x coord
    LDY #$04
    LDA (sp), Y
    
    ; Load y coord
    LDY #$03
    LDA (sp), Y
    
    ; Load color
    LDY #$00
    LDA (sp), Y
    
    ; Load height
    LDY #$01
    LDA (sp), Y

    ; Load width
    LDY #$02
    LDA (sp), Y
    

    ; Remove args from stack
    JSR incsp5
    RTS
.endproc

.proc _drawLine:near
    ; Load x coord
    LDY #$04
    LDA (sp), Y
    
    ; Load y coord
    LDY #$03
    LDA (sp), Y
    
    ; Load color
    LDY #$00
    LDA (sp), Y
    
    ; Load y2
    LDY #$01
    LDA (sp), Y

    ; Load x2
    LDY #$02
    LDA (sp), Y
    

    ; Remove args from stack
    JSR incsp5
    RTS
.endproc
