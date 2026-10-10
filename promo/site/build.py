#!/usr/bin/env python3
"""Inlines every asset of src/landing.html into eyehelper/index.html (one file to deploy)."""
import base64, pathlib, re
here = pathlib.Path(__file__).parent
A = here / 'eyehelper' / 'assets'
def uri(name, mime):
    return f"data:{mime};base64," + base64.b64encode((A / name).read_bytes()).decode()
badge = (A / 'badge-en-us.svg').read_text()
badge = re.sub(r'<\?xml[^>]*>', '', badge)
badge = re.sub(r'<title>.*?</title>', '<title>Download on the App Store</title>', badge, flags=re.S)
badge = badge.replace('<svg ', '<svg role="img" ', 1)
subs = {
  'ICON': uri('icon.png', 'image/png'),
  'BADGE': badge,
  'VIDEO_EN': uri('preview-en.mp4', 'video/mp4'), 'VIDEO_RU': uri('preview-ru.mp4', 'video/mp4'),
  'POSTER_EN': uri('poster-en.jpg', 'image/jpeg'), 'POSTER_RU': uri('poster-ru.jpg', 'image/jpeg'),
  'FINISH': uri('finish_face.png', 'image/png'),
}
for n in (1, 3, 4, 5, 6): subs[f'FACE{n}'] = uri(f'firstImageFace{n}.png', 'image/png')
for l in ('en', 'ru'):
    for i in ('02', '03', '04', '05'): subs[f'SHOT_{l.upper()}_{i}'] = uri(f'shot-{l}-{i}.jpg', 'image/jpeg')
import json
P = here.parent  # promo/
subs['SPRITES_JSON'] = (P / 'assets' / 'sprites.json').read_text().strip()
subs['ATLASES_JSON'] = json.dumps({f.stem: 'data:image/png;base64,' + base64.b64encode(f.read_bytes()).decode() for f in sorted((P / 'assets' / 'anim').glob('*.png'))})
html = (here / 'src' / 'landing.html').read_text()
html = re.sub(r'\{\{(\w+)\}\}', lambda m: subs[m.group(1)], html)
assert '{{' not in html
out = here / 'eyehelper' / 'index.html'
out.write_text(html)
print(f'{out.relative_to(here)}: {out.stat().st_size / 1024:.0f} KB')
