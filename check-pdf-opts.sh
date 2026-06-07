#!/bin/bash
echo "=== Option 1: Cloudflare R2 (recommended, free tier 10GB storage) ==="
echo "Store large PDFs on R2 with a custom subdomain like files.aocen2005.com"
echo ""
echo "=== Option 2: Compress the PDF ==="
echo "Use Python to compress PDFs below 25MB threshold"
echo ""
echo "=== Option 3: Split PDF into parts ==="
echo "Split into <25MB chunks, serve sequentially"
echo ""
echo "=== Option 4: External hosting ==="
echo "Use Google Drive shared link or similar"
echo "============================================"
echo ""
echo "Checking current PDF sizes..."
ls -lh /Users/murphy/projects/led-website/deploy-v4/*.pdf 2>/dev/null
ls -lh /Users/murphy/Desktop/*.pdf 2>/dev/null
ls -lh /Users/murphy/Downloads/*.pdf 2>/dev/null
echo ""
echo "=== Checking if python3 pikepdf or pypdf is available ==="
python3 -c "import pikepdf; print('pikepdf available')" 2>/dev/null || python3 -c "from pypdf import PdfReader; print('pypdf available')" 2>/dev/null || echo "No PDF library available. We can compress with Ghostscript if installed." && command -v gs >/dev/null 2>&1 && echo "Ghostscript available" || echo "Ghostscript NOT available"
