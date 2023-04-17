import durango_testing

def test_random():
    data = bytearray(8192)
    # test
    data[0]=1;
    # Seed
    data[1]=0x12;
    data[2]=0x23;
    # iterations
    data[3]=1;
    data[4]=0;
    
    dump = durango_testing.run_durango('test_system', data)
#    for i in range(8192):
#        print(dump[0x6000+i])
