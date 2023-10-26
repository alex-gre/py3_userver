import binascii


def hexdump(file_path):
    with open(file_path, 'rb') as file:
        data = file.read()
        offset = 0
        while data:
            hex_data = binascii.hexlify(data[:16]).decode('utf-8')
            hex_data = ' '.join(hex_data[i:i+2] for i in range(0, len(hex_data), 2))
            ascii_data = ''.join([chr(byte) if 32 <= byte < 127 else '.' for byte in data[:16]])
            print(f'{offset:08x} {hex_data:<48} {ascii_data}')
            data = data[16:]
            offset += 16
            
file_path = "enc.cr"
hexdump(file_path)