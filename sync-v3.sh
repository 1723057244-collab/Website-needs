#!/bin/bash
# Quick sync deploy-v3 -> deploy-v4 (preserve user's v4 edits)
# Only sync the framework files, don't touch catalog.html (user edited)

cp /Users/murphy/projects/led-website/deploy-v3/data.js /Users/murphy/projects/led-website/deploy-v4/data.js
cp /Users/murphy/projects/led-website/deploy-v3/app.js /Users/murphy/projects/led-website/deploy-v4/app.js
cp /Users/murphy/projects/led-website/deploy-v3/style.css /Users/murphy/projects/led-website/deploy-v4/style.css
cp /Users/murphy/projects/led-website/deploy-v3/index.html /Users/murphy/projects/led-website/deploy-v4/index.html
cp /Users/murphy/projects/led-website/deploy-v3/about.html /Users/murphy/projects/led-website/deploy-v4/about.html
cp /Users/murphy/projects/led-website/deploy-v3/products.html /Users/murphy/projects/led-website/deploy-v4/products.html
cp /Users/murphy/projects/led-website/deploy-v3/product-detail.html /Users/murphy/projects/led-website/deploy-v4/product-detail.html
cp /Users/murphy/projects/led-website/deploy-v3/features.html /Users/murphy/projects/led-website/deploy-v4/features.html
cp /Users/murphy/projects/led-website/deploy-v3/careers.html /Users/murphy/projects/led-website/deploy-v4/careers.html
cp /Users/murphy/projects/led-website/deploy-v3/contact.html /Users/murphy/projects/led-website/deploy-v4/contact.html
cp /Users/murphy/projects/led-website/deploy-v3/404.html /Users/murphy/projects/led-website/deploy-v4/404.html

echo "Synced framework files from v3 to v4 (catalog.html preserved)"
echo "DONE"
