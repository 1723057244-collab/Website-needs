#!/bin/bash
# Fix v4: all issues

# 1. Fix track light thumbnails — replace p.thumb with p.image in renderCard
cd /Users/murphy/projects/led-website/deploy-v4

echo "=== Fix 1: Use p.image instead of p.thumb ==="
sed -i '' 's/p\.thumb/p.image/' index.html products.html

echo "=== Verify ==="
grep 'p\.[ti]' index.html | head -3
grep 'p\.[ti]' products.html | head -3

# 2. Regenerate thumbnails with white background
echo ""
echo "=== Fix 2: Regenerate thumbnails ==="
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
        if os.path.exists(p): src = p; break
    if not src: continue
    try:
        src_img = Image.open(src).convert('RGBA')
        bg = Image.new('RGBA', src_img.size, (255,255,255,255))
        composited = Image.alpha_composite(bg, src_img).convert('RGB')
        composited.thumbnail((280,200), Image.LANCZOS)
        composited.save(os.path.join(thumb_dir, f), 'JPEG', quality=85)
        fixed += 1
    except Exception as e: print(f'ERR {f}: {e}')
print(f'Fixed {fixed} thumbnails')
" 2>&1

# 3. Clean temp files
rm -f *.sh check-*.js fix-*.js chk-*.js _t.js analyze-track.sh *.md 2>/dev/null

echo ""
echo "=== DONE ==="
ls -1 *.html *.css *.js *.pdf 2>/dev/null
echo "Images: $(ls images/ 2>/dev/null | wc -l | tr -d ' ')"
echo "Thumbs: $(ls images/thumbnails/ 2>/dev/null | wc -l | tr -d ' ')"
