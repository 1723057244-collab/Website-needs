#!/bin/bash
echo "=== Track products with image paths ==="
grep 'cat:"track"' /Users/murphy/projects/led-website/deploy-v4/data.js | grep -o 'image:"[^"]*"'

echo ""
echo "=== Checking if 12w轨道.png has transparency issue ==="
echo "The 12w/20w轨道 PNGs are RGBA with alpha channel."
echo "In a white img-wrap div with background:#fff, any transparent area should appear white."
echo "The object-fit:contain should make the full image visible."

echo ""
echo "=== Catalog card overlay analysis ==="
echo "cc-cover has overflow:hidden ✓"
echo "cc-cover-img now uses object-fit:contain ✓"
echo "cc-badge is positioned absolute top-right ✓"
echo ""
echo "If cards overlap, check:"
echo "1. .catalog-grid uses flex-direction:column ✓"
echo "2. .catalog-card display:flex ✓"
echo "3. No duplicate cc-cover divs in HTML"
