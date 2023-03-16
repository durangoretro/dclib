#include <sprites.h>
#include <psv.h>

sprite player = {0x11, 0x22, 0, 0x33, 0x44, 0};

int main() {
    consoleLogStr("Hello world!\n");
    consoleLogHex(player.x);
    consoleLogHex(player.y);
    consoleLogHex(player.width);
    consoleLogHex(player.height);
    
    psvDump();
}
