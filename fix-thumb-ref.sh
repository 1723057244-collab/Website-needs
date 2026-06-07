#!/bin/bash
echo "=== Editing renderCard in index.html ==="
# Change: (p.thumb ? '<img src="' + p.thumb + '" ... to (p.image ? '<img src="' + p.image + '"
cd /Users/murphy/projects/led-website/deploy-v4

# index.html line 125
echo "=== BEFORE ==="
sed -n '125p' index.html

# Replace p.thumb with p.image in the src attribute
sed -i '' '125s/p\.thumb/p.image/' index.html

echo "=== AFTER ==="
sed -n '125p' index.html

echo ""
echo "=== Editing renderCard in products.html ==="
echo "=== BEFORE ==="
sed -n '111p' products.html

# Replace p.thumb with p.image in products.html line 111
sed -i '' '111s/p\.thumb/p.image/' products.html

echo "=== AFTER ==="
sed -n '111p' products.html

echo ""
echo "DONE"
