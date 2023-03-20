import os


def run_durango(rom_name, test_data):
    test_image = bytearray(32768)
    # Add rom
    with open('./bin/'+rom_name+'.dux', 'rb') as fr:
        rom =bytearray(fr.read())
        if len(rom)!=16*1024:
            raise Exception("Wrong rom size")
        for i in range(16*1024):
            test_image[16384+i]=rom[i]
    
    # Add input data
    if len(test_data)!=8*1024:
        raise Exception("Wrong test data size")
    for i in range(8*1024):
        test_image[i]=test_data[i]
    
    
    # Write testing image to file
    with open('./bin/'+rom_name+'.dutt', 'wb') as ft:
        ft.write(test_image)
    
    # Run testing image on Perdita
    os.system('../../minimOS/emulation/perdita -gl bin/'+rom_name+'.dutt')
    # Get dump
    with open('./dump.bin', 'rb') as f:
        dump =bytearray(f.read())
    # Remove dump file
    os.remove('./dump.bin')
    
    # Return dump
    return dump
