
/**
 * Init conio lib. Should be called once before any conio operation, and
 * after any change in video mode register.
 */
extern void __fastcall__ conio_init(void);

/**
 * Fill the entire Screen of one color
 * @param color one of the 16 colors to print. Check video.h to see the 16 colors Macros.
 */
extern void __cdecl__ printf(char* text, void* font);


