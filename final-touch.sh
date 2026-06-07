#!/bin/bash
# Fix v4 catalog.html: logo fallback and cover image alignment
cd /Users/murphy/projects/led-website/deploy-v4

echo "=== Fix 1: Logo fallback in catalog.html ==="
# catalog.html already has the updated logo with fallback from edit above

echo "=== Fix 2: Remove flex-direction:column from cc-cover ==="
sed -i '' 's/flex-direction:column;align-items:center;justify-content:center;position:relative;flex-shrink:0;overflow:hidden/align-items:center;justify-content:center;position:relative;flex-shrink:0;overflow:hidden/' style.css

echo "=== Verify ==="
echo "Logo in catalog.html:"
grep 'enterprise-logo' catalog.html | head -1
echo ""
echo "cc-cover display in style.css:"
grep 'cc-cover.*display' style.css | head -3

echo ""
echo "DONE"
