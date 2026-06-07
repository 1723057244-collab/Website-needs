#!/bin/bash
echo "=== Checking images vs thumbnails ==="
echo ""
echo "Image count: $(ls /Users/murphy/projects/led-website/deploy-v4/images/*.png /Users/murphy/projects/led-website/deploy-v4/images/*.jpg /Users/murphy/projects/led-website/deploy-v4/images/*.jpeg 2>/dev/null | wc -l | tr -d ' ')"
echo "Thumbnail count: $(ls /Users/murphy/projects/led-website/deploy-v4/images/thumbnails/ 2>/dev/null | wc -l | tr -d ' ')"
echo ""
echo "=== Do ALL products have thumb field? ==="
grep -c 'thumb:' /Users/murphy/projects/led-website/deploy-v4/data.js
echo ""
echo "=== renderCard in index.html ==="
grep -n 'p\.\(image\|thumb\)' /Users/murphy/projects/led-website/deploy-v4/index.html | head -5
echo ""
echo "=== renderCard in products.html ==="
grep -n 'p\.\(image\|thumb\)' /Users/murphy/projects/led-website/deploy-v4/products.html | head -5
echo ""
echo "=== product-detail.html images ==="
grep -n 'p\.\(image\|thumb\)' /Users/murphy/projects/led-website/deploy-v4/product-detail.html | head -5
