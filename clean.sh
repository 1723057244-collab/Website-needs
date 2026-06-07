#!/bin/bash
# Deploy v4 to preview server for testing
cd /Users/murphy/projects/led-website/deploy-v4

# Clean temp files
rm -f *.sh chk-track.sh fix-catalog.sh diagnose.sh check-images.js .DS_Store 2>/dev/null

echo "=== deploy-v4 ready for preview ==="
echo "Files:"
ls -1 *.html *.css *.js *.pdf 2>/dev/null
echo "Images: $(ls images/ 2>/dev/null | wc -l | tr -d ' ')"
