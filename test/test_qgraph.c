#include <qgraph.h>
#include <psv.h>

char* test_data;

int main() {
    char color;
    
    test_data = 0x8000;
    
    fillScreen(test_data[0]);
    
    consoleLogHex(test_data[0]);
    
}
