import durango_testing

def test_answer():
    # 2 right to 1
    internal_cols(0,0,50,0, 0)
    # 2 above 1
    internal_cols(50,50,50,10, 0)
    # 2 left to 1
    internal_cols(50,0,0,0, 0)
    # 2 right overlap to 1
    internal_cols(0,0,5,0, 1)
    

def internal_cols(x1, y1, x2, y2, expected):
    data = bytearray(8192)
    data[0]=x1
    data[1]=y1
    data[2]=10
    data[3]=10
    data[4]=x2
    data[5]=y2
    data[6]=10
    data[7]=10
    
    dump = durango_testing.run_durango('test_sprites', data)

    assert dump[0x6000] == expected
