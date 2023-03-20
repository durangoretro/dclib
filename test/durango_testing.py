import os


def run_durango(rom_name):
    os.system('../../minimOS/emulation/perdita -gl bin/'+rom_name+'.dut')
    with open('./dump.bin', 'rb') as f:
        dump =bytearray(f.read())
    os.remove('./dump.bin')
    return dump
