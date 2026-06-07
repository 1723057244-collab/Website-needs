#!/bin/bash
echo "=== Check track light images (12w轨道, 20w轨道, 12w磁吸泛光 etc) ==="
echo ""
echo "Track light product images:"
ls /Users/murphy/projects/led-website/deploy-v4/images/*轨道* /Users/murphy/projects/led-website/deploy-v4/images/*磁吸* /Users/murphy/projects/led-website/deploy-v4/images/*折叠* 2>/dev/null
echo ""
echo "=== Check if 12w轨道, 20w轨道 PNGs are actually transparent ==="
for f in /Users/murphy/projects/led-website/deploy-v4/images/12w轨道.png /Users/murphy/projects/led-website/deploy-v4/images/20w轨道.png /Users/murphy/projects/led-website/deploy-v4/images/折叠.png; do
  echo ""
  echo "File: $(basename "$f")"
  python3 -c "
import struct
with open('$f','rb') as fh:
    fh.read(8)  # skip sig
    fh.read(8)  # skip IHDR
    w = struct.unpack('>I', fh.read(4))[0]
    h = struct.unpack('>I', fh.read(4))[0]
    fh.read(5)  # bit depth, color type, etc
    print(f'  Size: {w}x{h}')
    ct = fh.read(1)[0]
    print(f'  Color type: {ct} (0=grayscale, 2=RGB, 3=palette, 4=gray+alpha, 6=RGBA)')
" 2>/dev/null
done
echo ""
echo "=== Catalog cards in catalog.html ==="
grep -n 'catalog-card-full\|cc-cover' /Users/murphy/projects/led-website/deploy-v4/catalog.html | head -15
echo ""
echo "=== Check for cc-cover-inner CSS ==="
grep 'cc-cover-inner' /Users/murphy/projects/led-website/deploy-v4/style.css || echo "NOT FOUND — missing style!"
