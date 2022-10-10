#ifndef SYSTEM_H
#define SYSTEM_H

/* System procedures */
extern void __fastcall__ waitVSync(void);
extern void __fastcall__ waitStart(void);
extern void __fastcall__ waitFrames(unsigned char);
extern unsigned char __fastcall__ readGamepad(unsigned char);
extern void __fastcall__ halt(void);
extern void __fastcall__ calculate_coords(void*);

#endif
