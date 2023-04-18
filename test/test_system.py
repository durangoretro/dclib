import durango_testing

def test_random():
    run_random(0x1234, 128, 100, 3)
    run_random(0xa6b2, 256*4, 200, 15)


def run_random(seed, iterations, minimumTouchedExpected, maximumExpected):
    data = bytearray(8192)
    # test
    data[0]=1;
    # Seed
    data[1]=(seed & 0xFF00) >> 8
    data[2]=seed & 0x00FF
    # iterations
    data[3]=iterations & 0x00FF;
    data[4]=(iterations & 0xFF00) >> 8;
    
    dump = durango_testing.run_durango('test_system', data)
    touched = 0;
    minimum = dump[0x6000]
    maximum = dump[0x6000]
    for i in range(8192):
        if dump[0x6000+i] != 0:
            touched=touched+1
        if(dump[0x6000+i]<minimum):
            minimum = dump[0x6000+i]
        if(dump[0x6000+i]>maximum):
            maximum = dump[0x6000+i]
            
    print('Touched: ' + str(touched))
    print('Maximum: ' + str(maximum))
    print('Minimum: ' + str(minimum))
    assert touched >= minimumTouchedExpected
    assert maximum <= maximumExpected
   
