#!/bin/bash
echo "=== Checking track light images transparency ==="
echo ""
echo "12w轨道.png — 526x563, RGBA (has alpha channel). If the background appears black,"
echo "it's likely that the image has transparent pixels being rendered as black."
echo ""
echo "Quick fix: Add background:#fff to img-wrap for track cards."
echo ""
echo "=== Current CSS for product card img ==="
grep -A2 'img-wrap img' /Users/murphy/projects/led-website/deploy-v4/style.css
echo ""
echo "=== Check data.js: 'track' products image references ==="
grep 'cat:"track"' /Users/murphy/projects/led-website/deploy-v4/data.js | head -3
