#!/usr/bin/env node
var fs = require('fs');
var raw = fs.readFileSync('/Users/murphy/projects/led-website/deploy-v4/data.js','utf8');

// Find all track products and their images
var lines = raw.split('\n');
lines.forEach(function(line, i) {
  if (line.includes('"cat":"track"') || line.includes("cat:'track'") || (line.includes('cat:') && line.includes('track'))) {
    // Extract image path
    var m = line.match(/image:"([^"]+)"/);
    if (m) console.log('Line ' + (i+1) + ': ' + m[1]);
  } else if (line.includes('cat:"track"') || line.includes("cat:'track'")) {
    var m = line.match(/image:"([^"]+)"/);
    if (m) console.log('Line ' + (i+1) + ': ' + m[1]);
  }
});

// Check track images specifically
var trackImgs = raw.match(/images\/[^"]*轨道[^"]*/g) || [];
trackImgs = trackImgs.concat(raw.match(/images\/[^"]*磁吸[^"]*/g) || []);
trackImgs = trackImgs.concat(raw.match(/images\/[^"]*折叠[^"]*/g) || []);
console.log('\nAll track-related image paths:');
trackImgs.forEach(function(img) { console.log('  ' + img); });
