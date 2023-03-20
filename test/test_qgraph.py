import durango_testing

def test_fillScreen():
    internal_fillScreen(0x11)
    internal_fillScreen(0x22)
    internal_fillScreen(0x33)
    
def internal_fillScreen(color):
    data = bytearray(8192)
    data[0]=color
    dump = durango_testing.run_durango('test_qgraph', data)
    assert dump[0x5FFF] != color
    for i in range(8192):
        assert dump[0x6000+i] == color
