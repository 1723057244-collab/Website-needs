#!/bin/bash
# Fix thumbnails via python3
cd /Users/murphy/projects/led-website/deploy-v4

echo "=== Checking if Pillow is installed ==="
python3 -c "from PIL import Image; print('Pillow OK')" 2>&1

echo ""
echo "=== Regenerating thumbnails with white background ==="
python3 -c "
from PIL import Image
import os

img_dir = 'images'
thumb_dir = os.path.join(img_dir, 'thumbnails')
fixed = 0

for f in sorted(os.listdir(thumb_dir)):
    if not f.endswith('.jpg'): continue
    base = os.path.splitext(f)[0]
    src = None
    for ext in ['.png', '.jpeg', '.jpg']:
        p = os.path.join(img_dir, base + ext)
        if os.path.exists(p):
            src = p
            break
    if not src:
        print('SKIP: ' + f)
        continue
    src_img = Image.open(src).convert('RGBA')
    bg = Image.new('RGBA', src_img.size, (255, 255, 255, 255))
    composited = Image.alpha_composite(bg, src_img).convert('RGB')
    composited.thumbnail((280, 200), Image.LANCZOS)
    composited.save(os.path.join(thumb_dir, f), 'JPEG', quality=85)
    fixed += 1

print('Fixed: ' + str(fixed) + ' thumbnails')
" 2>&1

echo ""
echo "=== DONE ==="
