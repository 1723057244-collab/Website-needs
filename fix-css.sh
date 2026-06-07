#!/bin/bash
cd /Users/murphy/projects/led-website/deploy-v4

# 1. cc-cover flex-direction fix
sed -i '' 's|display:flex;flex-direction:column;align-items:center;justify-content:center|display:flex;align-items:center;justify-content:center|' style.css

# 2. Verify
grep 'cc-cover.*display' style.css

echo "Fixed: removed flex-direction:column from cc-cover"
echo "DONE"
