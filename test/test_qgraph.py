import durango_testing

def test_fillScreen():
    data = bytearray(8192)
    dump = durango_testing.run_durango('test_qgraph', data)
    assert dump[0x6000] == 0x11
