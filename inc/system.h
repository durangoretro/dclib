#ifndef SYSTEM_H
#define SYSTEM_H

/* System procedures */
extern void __fastcall__ setHiRes(unsigned char);
extern void __fastcall__ setInvert(unsigned char);
extern void __fastcall__ waitVSync(void);
extern void __fastcall__ waitStart(void);
extern void __fastcall__ waitButton(void);
extern void __fastcall__ waitFrames(unsigned char);
extern unsigned char __fastcall__ readGamepad(unsigned char);
extern unsigned char __fastcall__ readKeyboard(unsigned char);
extern void __fastcall__ halt(void);
extern void __fastcall__ calculate_coords(void*);
extern unsigned char __fastcall__ read_keyboard_row(unsigned char);
extern unsigned char __fastcall__ get_bit(unsigned char value, unsigned char number);
extern void __cdecl__ addBCD(long*, long*);
extern void __cdecl__ subBCD(long*, long*);
extern void __fastcall__ render_image(void*);
extern void __fastcall__ getBuildVersion(char*);
extern void __fastcall__ random_init(int);
extern unsigned char __fastcall__ random(void);
extern void __fastcall__ clear_screen(void);
extern void __cdecl__ copyMem(void *dest, void *source, char size);

// Gamepad keys
#define BUTTON_A 0x80
#define BUTTON_START 0x40
#define BUTTON_B 0x20
#define BUTTON_SELECT 0x10
#define BUTTON_UP 0x08
#define BUTTON_LEFT 0x04
#define BUTTON_DOWN 0x02
#define BUTTON_RIGHT 0x01

#define BLACK 0x00
#define GREEN 0x11
#define RED 0x22
#define ORANGE 0x33
#define PHARMACY_GREEN 0x44
#define LIME 0x55
#define MYSTIC_RED 0x66
#define YELLOW 0x77
#define BLUE 0x88
#define DEEP_SKY_BLUE 0x99
#define MAGENTA 0xaa
#define LAVENDER_ROSE 0xbb
#define NAVY_BLUE 0xcc
#define CIAN 0xdd
#define PINK_FLAMINGO 0xee
#define WHITE 0xff

// Keyboard
// 0
#define KEY_SPACE 0x80
#define KEY_INTRO 0x40
#define KEY_SHIFT 0x20
#define KEY_P 0x10
#define KEY_0 0x08
#define KEY_A 0x04
#define KEY_Q 0x02
#define KEY_1 0x01
#define KEY_ESC 0x01
// 1
#define KEY_ALT 0x80
#define KEY_L 0x40
#define KEY_Z 0x20
#define KEY_O 0x10
#define KEY_9 0x08
#define KEY_S 0x04
#define KEY_W 0x02
#define KEY_2 0x01
#define KEY_TAB 0x01
// 2
#define KEY_M 0x80
#define KEY_K 0x40
#define KEY_X 0x20
#define KEY_I 0x10
#define KEY_8 0x08
#define KEY_ARROW_RIGHT 0x08
#define KEY_D 0x04
#define KEY_E 0x02
#define KEY_3 0x01
#define KEY_NORM 0x01
// 3
#define KEY_N 0x80
#define KEY_J 0x40
#define KEY_C 0x20
#define KEY_U 0x10
#define KEY_7 0x08
#define KEY_ARROW_UP 0x08
#define KEY_F 0x04
#define KEY_R 0x02
#define KEY_4 0x01
#define KEY_INV 0x01
// 4
#define KEY_B 0x80
#define KEY_H 0x40
#define KEY_V 0x20
#define KEY_Y 0x10
#define KEY_6 0x08
#define KEY_ARROW_DOWN 0x08
#define KEY_G 0x04
#define KEY_T 0x02
#define KEY_5 0x01
#define KEY_ARROW_LEFT 0x01


// ROWS //
// 0
#define ROW_KEY_SPACE 0
#define ROW_KEY_INTRO 0
#define ROW_KEY_SHIFT 0
#define ROW_KEY_P 0
#define ROW_KEY_0 0
#define ROW_KEY_A 0
#define ROW_KEY_Q 0
#define ROW_KEY_1 0
#define ROW_KEY_ESC 0
// 1
#define ROW_KEY_ALT 1
#define ROW_KEY_L 1
#define ROW_KEY_Z 1
#define ROW_KEY_O 1
#define ROW_KEY_9 1
#define ROW_KEY_S 1
#define ROW_KEY_W 1
#define ROW_KEY_2 1
#define ROW_KEY_TAB 1
// 2
#define ROW_KEY_M 2
#define ROW_KEY_K 2
#define ROW_KEY_X 2
#define ROW_KEY_I 2
#define ROW_KEY_8 2
#define ROW_KEY_ARROW_RIGHT 2
#define ROW_KEY_D 2
#define ROW_KEY_E 2
#define ROW_KEY_3 2
#define ROW_KEY_NORM 2
// 3
#define ROW_KEY_N 3
#define ROW_KEY_J 3
#define ROW_KEY_C 3
#define ROW_KEY_U 3
#define ROW_KEY_7 3
#define ROW_KEY_ARROW_UP 3
#define ROW_KEY_F 3
#define ROW_KEY_R 3
#define ROW_KEY_4 3
#define ROW_KEY_INV 3
// 4
#define ROW_KEY_B 4
#define ROW_KEY_H 4
#define ROW_KEY_V 4
#define ROW_KEY_Y 4
#define ROW_KEY_6 4
#define ROW_KEY_ARROW_DOWN 4
#define ROW_KEY_G 4
#define ROW_KEY_T 4
#define ROW_KEY_5 4
#define ROW_KEY_ARROW_LEFT 4


#endif
