import os


def test_fillScreen():
    os.system('../../minimOS/emulation/perdita -gl bin/test_qgraph.dut')
    with open('./dump.bin', 'rb') as f:
        dump =bytearray(f.read())
    os.remove('./dump.bin')
    
    assert dump[0x6000] == 0x11
