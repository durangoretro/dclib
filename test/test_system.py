import durango_testing

def test_random():
    data = bytearray(8192)
    # test
    data[0]=1;
    # Seed
    data[1]=0x12;
    data[2]=0x23;
    # iterations
    data[3]=0;
    data[4]=1;
    
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
    assert touched > 128
    assert maximum < 5
   
