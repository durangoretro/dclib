#ifndef SYSTEM_H
#define SYSTEM_H

/* System procedures */
extern void __fastcall__ waitVSync(void);
extern void __fastcall__ waitStart(void);
extern void __fastcall__ waitFrames(byte);
extern byte __fastcall__ readGamepad(byte);
extern void __fastcall__ halt(void);

#endif
