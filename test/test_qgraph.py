import durango_testing

def test_fillScreen():
    dump = durango_testing.run_durango('test_qgraph')
    assert dump[0x6000] == 0x11
