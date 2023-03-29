#include <sprites.h>
#include <psv.h>

char* test_data;
sprite a, b;

int main() {

    test_data = 0x8000;
    
    a.x=test_data[0];
    a.y=test_data[1];
    a.height=test_data[2];
    a.width=test_data[3];
    
    b.x=test_data[4];
    b.y=test_data[5];
    b.height=test_data[6];
    b.width=test_data[7];
    
    consoleLogStr("Hello world!\n");
    consoleLogHex(a.x);
    consoleLogHex(a.y);
    consoleLogHex(a.width);
    consoleLogHex(a.height);
    
    consoleLogHex(b.x);
    consoleLogHex(b.y);
    consoleLogHex(b.width);
    consoleLogHex(b.height);
    
}
