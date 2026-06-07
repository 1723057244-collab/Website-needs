#!/usr/bin/env node
// Convert thumbnails in thumbnails/ to PNGs with white background
// These JPG thumbnails were made from RGBA PNGs but the alpha channel was
// composited onto black instead of white.
// Fix: regenerate thumbnails with white bg using python3 Pillow

var { execFileSync } = require('child_process');
var fs = require('fs');
var path = require('path');

var imgDir = '/Users/murphy/projects/led-website/deploy-v4/images';
var thumbDir = imgDir + '/thumbnails';

// List thumbnail files
var thumbs = fs.readdirSync(thumbDir);
console.log('Thumbnails to fix: ' + thumbs.length);

// Python script to composit PNG onto white bg and save as JPG
thumbs.forEach(function(f) {
  // Get the source PNG name (same base name, .png extension)
  var base = path.basename(f, '.jpg');
  var srcPng = imgDir + '/' + base + '.png';
  if (!fs.existsSync(srcPng)) {
    // Try .jpeg
    var srcJpeg = imgDir + '/' + base + '.jpeg';
    if (!fs.existsSync(srcJpeg)) {
      console.log('SKIP: No source for ' + f + ' (tried ' + srcPng + ', ' + srcJpeg + ')');
      return;
    }
    srcPng = srcJpeg;
  }
  var dstJpg = thumbDir + '/' + f;
  console.log('Fix: ' + f + ' from ' + path.basename(srcPng));
});

// Now actually run the python fix
var pyCode = `
from PIL import Image
import os, sys

img_dir = '/Users/murphy/projects/led-website/deploy-v4/images'
thumb_dir = os.path.join(img_dir, 'thumbnails')

fixed = 0
for f in os.listdir(thumb_dir):
    if not f.endswith('.jpg'):
        continue
    base = os.path.splitext(f)[0]
    # Find source
    src = None
    for ext in ['.png', '.jpeg', '.jpg']:
        p = os.path.join(img_dir, base + ext)
        if os.path.exists(p):
            src = p
            break
    if not src:
        print(f'SKIP: {f} - no source found')
        continue

    # Open source (might be RGBA)
    src_img = Image.open(src).convert('RGBA')
    # Create white background
    bg = Image.new('RGBA', src_img.size, (255, 255, 255, 255))
    # Composite
    composited = Image.alpha_composite(bg, src_img).convert('RGB')
    # Resize to thumbnail size (280x200 for product cards)
    composited.thumbnail((280, 200), Image.LANCZOS)
    # Save
    dst = os.path.join(thumb_dir, f)
    composited.save(dst, 'JPEG', quality=85)
    fixed += 1
    print(f'OK: {f}')

print(f'Fixed {fixed} thumbnails')
`;

// Run python
try {
  var result = execFileSync('/usr/bin/python3', ['-c', pyCode], { encoding: 'utf8', timeout: 30000 });
  console.log('\n' + result);
} catch(e) {
  console.error('PYTHON ERROR:', e.message);
  if (e.stderr) console.error(e.stderr.toString());
  if (e.stdout) console.log(e.stdout.toString());
}
