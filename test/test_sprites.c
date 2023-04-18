#include <sprites.h>
#include <psv.h>

char* test_data;
char* out_data;
sprite a, b;
char collision;

int main() {
    
    test_data = 0x8000;
    out_data = 0x6000;
    
    a.x=test_data[0];
    a.y=test_data[1];
    a.height=test_data[2];
    a.width=test_data[3];
    
    b.x=test_data[4];
    b.y=test_data[5];
    b.height=test_data[6];
    b.width=test_data[7];
    
    consoleLogStr("Hello world!\n");
    consoleLogDecimal(a.x);
    consoleLogDecimal(a.y);
    consoleLogDecimal(a.width);
    consoleLogDecimal(a.height);
    
    consoleLogDecimal(b.x);
    consoleLogDecimal(b.y);
    consoleLogDecimal(b.width);
    consoleLogDecimal(b.height);
    
    collision = check_collisions(&a, &b);
    consoleLogDecimal(collision);
    out_data[0]=collision;
    
}
