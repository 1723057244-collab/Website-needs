#!/bin/bash
# Deploy deploy-v4 to v4.aocheng-lighting.pages.dev
# (separate project or same project with different branch)

# For now just verify v4 is complete
cd /Users/murphy/projects/led-website/deploy-v4

echo "=== deploy-v4 summary ==="
echo "HTML pages: $(ls *.html 2>/dev/null | wc -l | tr -d ' ')"
echo "CSS: $(ls *.css 2>/dev/null | wc -l | tr -d ' ')"
echo "JS: $(ls *.js 2>/dev/null | wc -l | tr -d ' ')"
echo "PDFs: $(ls *.pdf 2>/dev/null | wc -l | tr -d ' ')"
echo "Images: $(ls images/ 2>/dev/null | wc -l | tr -d ' ')"
echo "Catalog covers: $(ls images/catalog-cover* 2>/dev/null)"
echo "Logo: $(ls images/enterprise-logo* 2>/dev/null)"
echo ""
echo "=== deploy-v4 is ready ==="
echo "Location: /Users/murphy/projects/led-website/deploy-v4"
