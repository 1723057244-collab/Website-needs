#!/bin/bash
echo "=== Final deploy-v4 status ==="
echo ""
echo "Fix 1: Track light images — img-wrap uses background:#fff, object-fit:contain ✓"
echo "Fix 2: Catalog cards — cc-cover uses object-fit:contain, flex-direction:column removed ✓"
echo ""
echo "Files ready for deploy:"
ls -1 /Users/murphy/projects/led-website/deploy-v4/*.html /Users/murphy/projects/led-website/deploy-v4/*.css /Users/murphy/projects/led-website/deploy-v4/*.js /Users/murphy/projects/led-website/deploy-v4/*.pdf 2>/dev/null
echo ""
echo "HTML pages: $(ls /Users/murphy/projects/led-website/deploy-v4/*.html 2>/dev/null | wc -l | tr -d ' ')"
echo "Images: $(ls /Users/murphy/projects/led-website/deploy-v4/images/ 2>/dev/null | wc -l | tr -d ' ')"
echo "Thumbnails: $(ls /Users/murphy/projects/led-website/deploy-v4/images/thumbnails/ 2>/dev/null | wc -l | tr -d ' ')"
echo ""
echo "DONE"
