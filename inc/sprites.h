#ifndef SPRITES_H
#define SPRITES_H

typedef struct{
    unsigned char x, y;
    unsigned short mem;
    unsigned char width, height;
} sprite;

extern void __fastcall__ load_background(void*);
extern void __fastcall__ clrscr(void);
extern void __fastcall__ draw_sprite(void*);

#endif
