#!/bin/bash
# Fix: regenerate thumbnails with white background
# AND fix the renderCard function to use original PNGs instead of JPG thumbnails

THUMB_DIR="/Users/murphy/projects/led-website/deploy-v4/images/thumbnails"
IMG_DIR="/Users/murphy/projects/led-website/deploy-v4/images"

echo "=== Fix 1: Regenerate thumbnails with white background ==="
python3 -c "
from PIL import Image
import os

img_dir = '$IMG_DIR'
thumb_dir = '$THUMB_DIR'
fixed = 0
skipped = 0

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
        print(f'SKIP: {f} - no source')
        skipped += 1
        continue
    src_img = Image.open(src).convert('RGBA')
    bg = Image.new('RGBA', src_img.size, (255, 255, 255, 255))
    composited = Image.alpha_composite(bg, src_img).convert('RGB')
    composited.thumbnail((280, 200), Image.LANCZOS)
    dst = os.path.join(thumb_dir, f)
    composited.save(dst, 'JPEG', quality=85)
    fixed += 1

print(f'Fixed: {fixed}, Skipped: {skipped}')
" 2>&1

echo ""
echo "=== Fix 2: Use p.image instead of p.thumb in renderCard ==="
# In products.html and index.html, change p.thumb -> p.image
cd /Users/murphy/projects/led-website/deploy-v4
for f in index.html products.html; do
  sed -i '' 's/p\.thumb ? .*thumb/p.image ? .*image/' "$f" 2>/dev/null || true
done

# Prefer p.image over p.thumb in all render functions
sed -i '' "s/(p.thumb ? '<img/(p.image ? '<img/" index.html
sed -i '' "s/(p.thumb ? '<img/(p.image ? '<img/" products.html
sed -i '' "s/+ p.thumb +/+ p.image +/" index.html
sed -i '' "s/+ p.thumb +/+ p.image +/" products.html

echo "Fixed render functions to use original images"

echo ""
echo "=== Verify ==="
grep 'p\.\(thumb\|image\)' index.html | head -3
grep 'p\.\(thumb\|image\)' products.html | head -3

echo ""
echo "DONE"
