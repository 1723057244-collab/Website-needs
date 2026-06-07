#!/usr/bin/env node
// Check: are the thumbnail JPGs being used instead of PNGs?
// The data.js has "thumb" fields — are they referenced somewhere?
var fs = require('fs');
var raw = fs.readFileSync('/Users/murphy/projects/led-website/deploy-v4/data.js','utf8');

// Check if thumb is used in rendering
console.log('=== Checking if thumb is used in rendering ===');
console.log('thumb fields count:', (raw.match(/thumb:/g) || []).length);

// Check products.html renderCard
var products = fs.readFileSync('/Users/murphy/projects/led-website/deploy-v4/products.html','utf8');
console.log('\n=== renderCard function in products.html ===');
var match = products.match(/function renderCard[\s\S]*?return '[\s\S]*?<\/a>/);
if (match) {
  var lines = match[0].split('\n');
  lines.forEach(function(l) { console.log(l.substring(0, 120)); });
} else {
  // Try different approach
  var start = products.indexOf('function renderCard');
  if (start > 0) {
    var end = products.indexOf('function ', start + 20);
    if (end < 0) end = products.indexOf('document.addEventListener', start + 20);
    console.log(products.substring(start, end < 0 ? start + 500 : end));
  }
}

// Also check index.html renderMarqueeCard
var index = fs.readFileSync('/Users/murphy/projects/led-website/deploy-v4/index.html','utf8');
console.log('\n=== renderMarqueeCard in index.html ===');
var m2 = index.match(/function renderMarqueeCard[\s\S]*?<\/a>/);
if (m2) {
  var lines = m2[0].split('\n');
  lines.forEach(function(l) { console.log(l.substring(0, 120)); });
}
