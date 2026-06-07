#!/bin/bash
# Fix v4: catalog page layout + track light background
cd /Users/murphy/projects/led-website/deploy-v4

echo "=== Fix 1: Catalog cover images object-fit ==="
# Already done — changed from cover to contain

echo "=== Fix 2: Check catalog card structure ==="
echo "Cards found: $(grep -c 'catalog-card-full' catalog.html)"
echo "---"

echo "=== Fix 3: cc-cover sizing ==="
grep 'cc-cover{' style.css

echo ""
echo "=== Fix 4: Remove QR/share section if causing overlap ==="
echo "Current share section:"
grep -n 'catalog-share' catalog.html

echo ""
echo "=== DONE: verify with preview ==="
