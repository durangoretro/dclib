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
    a.width=test_data[2];
    a.height=test_data[3];
    
    b.x=test_data[4];
    b.y=test_data[5];
    b.width=test_data[6];
    b.height=test_data[7];
    
    consoleLogStr("SPRITES TEST\n");
    consoleLogStr("============\n");
    consoleLogStr("First sprite: x,y,w,h\n");
    consoleLogDecimal(a.x);
    consoleLogDecimal(a.y);
    consoleLogDecimal(a.width);
    consoleLogDecimal(a.height);
    consoleLogStr("\nSecond sprite: x,y,w,h\n");
    consoleLogDecimal(b.x);
    consoleLogDecimal(b.y);
    consoleLogDecimal(b.width);
    consoleLogDecimal(b.height);
    consoleLogStr("\n");
    
    collision = check_collisions(&a, &b);
    consoleLogStr("\nCollision: ");
    consoleLogDecimal(collision);
    consoleLogStr("\n");
    out_data[0]=collision;    
}
