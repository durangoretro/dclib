#include <system.h>
#include <psv.h>
#include "durango_testing.h"

char* test_data;
char* out_data;

void test_random(void);

int main() {
    char test_number;
    
    test_data = 0x8000;
    out_data = 0x6000;
    test_number = test_data[0];
    consoleLogStr("\nTesting mode: ");
    consoleLogDecimal(test_number);
    
    
    if(test_number==1) {
        consoleLogStr("\nTesting random number generation");
        test_random();
    }
    
    return 0;
}

void test_random() {
    int seed, iterations, i;
    char random_value;
    
    setHiRes(1);
    clear_screen();
    
    seed = read_int(1);
    consoleLogStr("\nSeed: ");
    consoleLogInt(seed);
    
    iterations = read_int(3);
    consoleLogStr("\nGenerating random number. Count: ");
    consoleLogInt(iterations);
    
    i=0;
    do {
        random_value = random();
        //consoleLogStr("\nRandom value: ");
        //consoleLogDecimal(random_value);
        out_data[random_value]++;
        i++;     
    } while(i!=iterations);
}
