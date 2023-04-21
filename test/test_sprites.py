import durango_testing

X_COORD  = 0x14
Y_COORD  = 0x15
X2_COORD = 0x1A
Y2_COORD = 0x1B
X3_COORD = 0x1C
Y3_COORD = 0x1D
X4_COORD = 0x1E
Y4_COORD = 0x1F
HEIGHT   = 0x16
WIDTH    = 0x17
HEIGHT2  = 0x2E
WIDTH2   = 0x2F

def test_answer():
    # 2 right to 1
    internal_cols(0,0,50,0, 0)
    # 2 above 1
    internal_cols(50,50,50,10, 0)
    # 2 left to 1
    internal_cols(50,0,0,0, 0)
    # 2 right overlap to 1
    #internal_cols(0,0,5,0, 1)

def test_cols_coords():
    internal_cols_coords(0,0,10,10,5,5,15,20)
    

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

def internal_cols_coords(x1, y1, w1, h1, x2, y2, w2, h2):
    data = bytearray(8192)
    data[0]=x1
    data[1]=y1
    data[2]=w1
    data[3]=h1
    data[4]=x2
    data[5]=y2
    data[6]=w2
    data[7]=h2
    
    dump = durango_testing.run_durango('test_sprites', data)
    assert dump[X_COORD] == x1
    assert dump[Y_COORD] == y1
    assert dump[WIDTH] == w1
    assert dump[HEIGHT] == h1
    #assert dump[X2_COORD] == x1+w1
    #assert dump[Y2_COORD] == y1+h1
    #assert dump[X3_COORD] == x2
    #assert dump[Y3_COORD] == y2
    #assert dump[X4_COORD] == x2+w2
    #assert dump[Y4_COORD] == y2+h2
    
