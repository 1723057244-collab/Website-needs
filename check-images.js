#!/usr/bin/env node
var fs = require('fs');
var buf = fs.readFileSync('/Users/murphy/projects/led-website/deploy-v4/images/12w轨道.png');
// PNG signature is 137 80 78 71 13 10 26 10
// After IHDR chunk: width(4) height(4) bitDepth(1) colorType(1) compression(1) filter(1) interlace(1)
var idx = 8; // skip signature
var len = buf.readUInt32BE(idx); idx += 4; // chunk length
// IHDR type
idx += 4; // 'IHDR'
var w = buf.readUInt32BE(idx); idx += 4;
var h = buf.readUInt32BE(idx); idx += 4;
var bitDepth = buf[idx]; idx += 1;
var colorType = buf[idx]; idx += 1;
var colorNames = {0:'Grayscale', 2:'RGB', 3:'Indexed', 4:'Grayscale+Alpha', 6:'RGBA'};
console.log('12w轨道.png: ' + w + 'x' + h + ', bitDepth=' + bitDepth + ', colorType=' + colorType + ' (' + (colorNames[colorType]||'unknown') + ')');

// Check 20w轨道 too
buf = fs.readFileSync('/Users/murphy/projects/led-website/deploy-v4/images/20w轨道.png');
idx = 8; len = buf.readUInt32BE(idx); idx += 4; idx += 4;
w = buf.readUInt32BE(idx); idx += 4; h = buf.readUInt32BE(idx); idx += 4;
bitDepth = buf[idx]; idx += 1; colorType = buf[idx];
console.log('20w轨道.png: ' + w + 'x' + h + ', bitDepth=' + bitDepth + ', colorType=' + colorType + ' (' + (colorNames[colorType]||'unknown') + ')');

// Check 折叠.png
buf = fs.readFileSync('/Users/murphy/projects/led-website/deploy-v4/images/折叠.png');
idx = 8; len = buf.readUInt32BE(idx); idx += 4; idx += 4;
w = buf.readUInt32BE(idx); idx += 4; h = buf.readUInt32BE(idx); idx += 4;
bitDepth = buf[idx]; idx += 1; colorType = buf[idx];
console.log('折叠.png: ' + w + 'x' + h + ', bitDepth=' + bitDepth + ', colorType=' + colorType + ' (' + (colorNames[colorType]||'unknown') + ')');

// Check a few magxi (magnetic) images too
var files = ['12w磁吸泛光.png', '24w磁吸泛光.png', '30w磁吸格栅.png'];
files.forEach(function(f) {
  try {
    buf = fs.readFileSync('/Users/murphy/projects/led-website/deploy-v4/images/' + f);
    idx = 8; idx += 4; idx += 4;
    w = buf.readUInt32BE(idx); idx += 4; h = buf.readUInt32BE(idx); idx += 4;
    bitDepth = buf[idx]; idx += 1; colorType = buf[idx];
    console.log(f + ': ' + w + 'x' + h + ', colorType=' + colorType + ' (' + (colorNames[colorType]||'unknown') + ')');
  } catch(e) { console.log(f + ': ERROR ' + e.message); }
});
