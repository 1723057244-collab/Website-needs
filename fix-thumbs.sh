#!/bin/bash
cd /Users/murphy/projects/led-website/deploy-v4

# Regenerate thumbnails with white bg
python3 << 'PYEOF'
from PIL import Image
import os

img_dir = 'images'
thumb_dir = os.path.join(img_dir, 'thumbnails')
fixed = 0

for f in sorted(os.listdir(thumb_dir)):
    if not f.endswith('.jpg'):
        continue
    base = os.path.splitext(f)[0]
    src = None
    for ext in ['.png', '.jpeg', '.jpg']:
        p = os.path.join(img_dir, base + ext)
        if os.path.exists(p):
            src = p
            break
    if not src:
        print(f'SKIP: {f}')
        continue
    try:
        src_img = Image.open(src).convert('RGBA')
        bg = Image.new('RGBA', src_img.size, (255, 255, 255, 255))
        composited = Image.alpha_composite(bg, src_img).convert('RGB')
        composited.thumbnail((280, 200), Image.LANCZOS)
        composited.save(os.path.join(thumb_dir, f), 'JPEG', quality=85)
        fixed += 1
    except Exception as e:
        print(f'ERR {f}: {e}')

print(f'Fixed: {fixed} thumbnails')
PYEOF

echo ""
echo "=== DONE ==="
