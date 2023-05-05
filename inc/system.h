#ifndef SYSTEM_H
#define SYSTEM_H

/* System procedures */
extern void __fastcall__ setHiRes(unsigned char);
extern void __fastcall__ waitVSync(void);
extern void __fastcall__ waitStart(void);
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
#define KEY_SPACE 0X80
#define KEY_INTRO 0X40
#define KEY_SHIFT 0X20
#define KEY_P 0X10
#define KEY_0 0X08
#define KEY_A 0X04
#define KEY_Q 0X02
#define KEY_1 0X01
#define KEY_ESC 0X01
// 1
#define KEY_ALT 0X80
#define KEY_L 0X40
#define KEY_Z 0X20
#define KEY_O 0X10
#define KEY_9 0X08
#define KEY_S 0X04
#define KEY_W 0X02
#define KEY_2 0X01
#define KEY_TAB 0X01
// 2
#define KEY_M 0X80
#define KEY_K 0X40
#define KEY_X 0X20
#define KEY_I 0X10
#define KEY_8 0X08
#define KEY_ARROW_RIGHT 0X08
#define KEY_D 0X04
#define KEY_E 0X02
#define KEY_3 0X01
#define KEY_NORM 0X01
// 3
#define KEY_N 0X80
#define KEY_J 0X40
#define KEY_C 0X20
#define KEY_U 0X10
#define KEY_7 0X08
#define KEY_ARROW_UP 0X08
#define KEY_F 0X04
#define KEY_R 0X02
#define KEY_4 0X01
#define KEY_INV 0X01
// 4
#define KEY_B 0X80
#define KEY_H 0X40
#define KEY_V 0X20
#define KEY_Y 0X10
#define KEY_6 0X08
#define KEY_ARROW_DOWN 0X08
#define KEY_G 0X04
#define KEY_T 0X02
#define KEY_5 0X01
#define KEY_ARROW_LEFT 0X01



#endif
