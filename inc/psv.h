#ifndef PSV_H
#define PSV_H

/* Debug procedures */
extern void __fastcall__ consoleLogHex(byte value);
extern void __fastcall__ consoleLogWord(word value);
extern void __fastcall__ consoleLogBinary(byte value);
extern void __fastcall__ consoleLogDecimal(byte value);
extern void __fastcall__ consoleLogChar(unsigned char);
extern void __fastcall__ consoleLogStr(char *str);
extern void __fastcall__ startStopwatch(void);
extern void __fastcall__ stopStopwatch(void);

#endif
