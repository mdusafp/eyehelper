"""Tiny dependency-free PNG reader/writer (8-bit RGB/RGBA, non-interlaced)."""
import struct, zlib

def read(path):
    data = open(path, 'rb').read()
    assert data[:8] == b'\x89PNG\r\n\x1a\n'
    pos = 8; idat = b''; w = h = 0; ct = 0
    while pos < len(data):
        ln, typ = struct.unpack('>I4s', data[pos:pos+8]); body = data[pos+8:pos+8+ln]; pos += 12 + ln
        if typ == b'IHDR':
            w, h, bd, ct, _, _, il = struct.unpack('>IIBBBBB', body); assert bd == 8 and il == 0 and ct in (2, 6), (bd, ct, il)
        elif typ == b'IDAT': idat += body
        elif typ == b'IEND': break
    ch = 4 if ct == 6 else 3
    raw = zlib.decompress(idat); stride = w * ch
    out = bytearray(w * h * 4); prev = bytearray(stride); p = 0
    for y in range(h):
        f = raw[p]; p += 1; line = bytearray(raw[p:p+stride]); p += stride
        for i in range(stride):
            a = line[i-ch] if i >= ch else 0; b = prev[i]; c = prev[i-ch] if i >= ch else 0
            if f == 1: line[i] = (line[i] + a) & 255
            elif f == 2: line[i] = (line[i] + b) & 255
            elif f == 3: line[i] = (line[i] + (a + b) // 2) & 255
            elif f == 4:
                pa, pb, pc = abs(b - c), abs(a - c), abs(a + b - 2 * c)
                pr = a if pa <= pb and pa <= pc else (b if pb <= pc else c)
                line[i] = (line[i] + pr) & 255
        if ch == 4: out[y*w*4:(y+1)*w*4] = line
        else:
            for x in range(w): out[(y*w+x)*4:(y*w+x)*4+3] = line[x*3:x*3+3]; out[(y*w+x)*4+3] = 255
        prev = line
    return w, h, out

def write(path, w, h, rgba):
    raw = bytearray()
    for y in range(h): raw.append(0); raw += rgba[y*w*4:(y+1)*w*4]
    def chunk(t, b): return struct.pack('>I', len(b)) + t + b + struct.pack('>I', zlib.crc32(t + b) & 0xffffffff)
    png = b'\x89PNG\r\n\x1a\n' + chunk(b'IHDR', struct.pack('>IIBBBBB', w, h, 8, 6, 0, 0, 0)) + chunk(b'IDAT', zlib.compress(bytes(raw), 9)) + chunk(b'IEND', b'')
    open(path, 'wb').write(png)
