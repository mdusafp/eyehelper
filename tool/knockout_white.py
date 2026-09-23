#!/usr/bin/env python3
"""Make the white backdrop of the face sprites transparent.

The Flare atlases and the static face frames were exported on an opaque white
square. Everything that is white *and reachable from the image border* (or
from already-transparent atlas padding) is background and becomes
transparent; white enclosed by strokes — eye highlights, teeth, the palm of a
hand — is drawing and stays. Light anti-aliased pixels along the new edge get
an alpha from their brightness so no pale halo is left.

Usage: python3 tool/knockout_white.py assets/anim/*.png assets/firstImageFace*.png
"""
import sys, os
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '_lib'))
from pngio import read, write  # noqa: E402

WHITE = 244   # every channel at or above this counts as background white

def knockout(path):
    w, h, b = read(path)
    n = w * h
    def is_white(i):
        j = i * 4
        return b[j+3] > 0 and b[j] >= WHITE and b[j+1] >= WHITE and b[j+2] >= WHITE
    seen = bytearray(n)
    stack = []
    # Seeds: every border pixel, plus every already-transparent pixel.
    for i in range(n):
        j = i * 4
        x, y = i % w, i // w
        if b[j+3] == 0 or x == 0 or y == 0 or x == w-1 or y == h-1:
            if b[j+3] == 0 or is_white(i):
                seen[i] = 1; stack.append(i)
    while stack:
        i = stack.pop()
        x, y = i % w, i // w
        for k in ((i-1) if x > 0 else -1, (i+1) if x < w-1 else -1, (i-w) if y > 0 else -1, (i+w) if y < h-1 else -1):
            if k >= 0 and not seen[k] and is_white(k):
                seen[k] = 1; stack.append(k)
    cleared = 0
    for i in range(n):
        if seen[i] and b[i*4+3]:
            b[i*4+3] = 0; cleared += 1
    # Soften the boundary: light pixels touching the cleared area fade by brightness.
    faded = 0
    for i in range(n):
        j = i * 4
        if b[j+3] == 0: continue
        x, y = i % w, i // w
        touching = any(seen[k] for k in ((i-1) if x > 0 else -1, (i+1) if x < w-1 else -1, (i-w) if y > 0 else -1, (i+w) if y < h-1 else -1) if k >= 0)
        if not touching: continue
        mn = min(b[j], b[j+1], b[j+2])
        if mn > 128:
            b[j+3] = int(b[j+3] * (255 - mn) / 127); faded += 1
    write(path, w, h, b)
    print(f'{path}: cleared {cleared} px, faded {faded} edge px')

for p in sys.argv[1:]:
    knockout(p)
