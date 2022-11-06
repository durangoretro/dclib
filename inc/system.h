#ifndef SYSTEM_H
#define SYSTEM_H

/* System procedures */
extern void __fastcall__ waitVSync(void);
extern void __fastcall__ waitStart(void);
extern void __fastcall__ waitFrames(unsigned char);
extern unsigned char __fastcall__ readGamepad(unsigned char);
extern void __fastcall__ halt(void);
extern void __fastcall__ calculate_coords(void*);

// Gamepad keys
#define BUTTON_A 0x80
#define BUTTON_START 0x40
#define BUTTON_B 0x20
#define BUTTON_SELECT 0x10
#define BUTTON_UP 0x08
#define BUTTON_LEFT 0x04
#define BUTTON_DOWN 0x02
#define BUTTON_RIGHT 0x01

#endif
