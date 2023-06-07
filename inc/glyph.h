#ifndef GLYPH_H
#define GLYPH_H

extern void __cdecl__ printBCD(unsigned char x, unsigned char y, void* font, unsigned char color, unsigned char paper, long value);
extern void __cdecl__ printStr(unsigned char x, unsigned char y, void* font, unsigned char color, unsigned char paper, char *value);
extern void __cdecl__ readStr(unsigned char x, unsigned char y, void* font, unsigned char color, unsigned char paper, char *value, char max);

#endif
