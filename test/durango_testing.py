import os


def run_durango(rom_name, test_data):
    test_image = bytearray(65543)
    # Add rom
    with open('./bin/'+rom_name+'.dux', 'rb') as fr:
        rom =bytearray(fr.read())
        if len(rom)!=16*1024:
            raise Exception("Wrong rom size")
        for i in range(16*1024):
            test_image[0xC000+i]=rom[i]
    
    # Add input data
    if len(test_data)!=8*1024:
        raise Exception("Wrong test data size")
    for i in range(8*1024):
        test_image[0x4000+i]=test_data[i]
    
    # Add register A
    test_image[65536] = 0x00;
    # Add register X
    test_image[65537] = 0x00;
    # Add register Y
    test_image[65538] = 0x00;
    # Add register S
    test_image[65539] = 0x00;
    # Add register P
    test_image[65540] = 0x00;
    # Add register PC
    test_image[65541] = test_image[0xFFFC];
    test_image[65542] = test_image[0xFFFD];
    
    with open('./bin/'+rom_name+'.dutt', 'wb') as ft:
        ft.write(test_image)
    
    
    os.system('../../minimOS/emulation/perdita -gl bin/'+rom_name+'.dutt')
    with open('./dump.bin', 'rb') as f:
        dump =bytearray(f.read())
    os.remove('./dump.bin')
    return dump
