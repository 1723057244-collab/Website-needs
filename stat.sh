#!/bin/bash
cd /Users/murphy/projects/led-website/deploy-v4
source=$(grep -c 'cc-cover-img' catalog.html)
echo "cc-cover-img refs in catalog.html: $source"
echo ""
echo "=== pdfConfig check ==="
grep -A4 'pdfConfig' catalog.html | head -10
echo ""
echo "=== style.cc-cover check ==="
grep 'cc-cover{' style.css
echo ""
echo "=== img-wrap img check ==="
grep 'img-wrap img' style.css