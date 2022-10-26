#ifndef GEOMETRICS_H
#define GEOMETRICS_H


/**
 * Fill the entire Screen of one color
 * @param color one of the 16 colors to print. Check video.h to see the 16 colors Macros.
 */
extern void __fastcall__ drawFullScreen(unsigned char color);


/**
 * Draw a Pixel on Screen
 * @param x: X Coord in pixels. The x coordinate is from left to Rigth.
 * @param y: Y Coord in pixels. The Y coordinate is from up to Down.
 * @param color: color to use. Check the video.h file for the macros for the 16 colors.
 */
extern void __cdecl__ drawPixel(unsigned char x, unsigned char y, unsigned char color);


/**
 * @param x: X Coord in pixels. The x coordinate is from left to Rigth.
 * @param y: Y Coord in pixels. The Y coordinate is from up to Down.
 * @param width: Rectangle width
 * @param height: Rectangle height
 * @param color: color to use. Check the video.h file for the macros for the 16 colors.
 */
extern void __cdecl__ drawRect(unsigned char x, unsigned char y, unsigned char width, unsigned char height, unsigned char color);


#endif
