// create a pile of sand in the middle
// write a topple function
// draw the piles
const canvasWidth = 200;
const canvasHeight = 200;
const initialPile = 10000000;
const toppleDistance = 2;
const depth = 4;
let colors;
let depthThresholdSlider = {};

//color related stuff
let colorSpread = 0.2;
const colorRange = 30;

const matrix = [];
for(var i = 0; i < canvasHeight; i++) {
  let inner = [];
  for(var j = 0; j < canvasWidth; j++) {
    inner[j] = 0;
  }
  matrix.push(inner);
}

function setup() {
  colorMode(HSB, 100);
  frameRate(10);
  colors = [
    color(100, 100, 100),
    color(80, 100, 90),
    color(60, 100, 80),
    color(40, 100, 70),
    color(20, 100, 60),
  ]
  
  // Create initial pile in the middle 
  matrix[canvasWidth / 2][canvasHeight / 2] = initialPile;
  
  createCanvas(canvasWidth, canvasHeight);
  
  colorSlider = createSlider(0, 0.6, colorSpread, 0.01);
  colorSlider.position(width + 20, height - 20);
}

function topple(depth) {
  for(var i = 0; i< canvasHeight - 1; i++) {
    for(var j = 0; j< canvasWidth - 1; j++) {
      if(matrix[i][j] >= depth) {
        topplePile([i, j], depth);
      }
    }
  }
}

function topplePile([x, y], depth) {
  if(x == 0 || y == 0 || x == width || y == height) {
    return;
  }
  if(!(matrix[x + toppleDistance])) {return};
  if(!(matrix[x - toppleDistance])) {return};
  if(!(matrix[y + toppleDistance])) {return};
  if(!(matrix[y - toppleDistance])) {return};
  
  // To allow for creativity, we need to distribute a
  // sorta arbitrary number of sand 'grains'
  
  // let divisibleByFour = depth % 4 == 0;
  // const incrementer = divisibleByFour ? depth / 4 : depth;
  const incrementer = floor(random(2));
  
  matrix[x - toppleDistance][y - toppleDistance] += incrementer;

  matrix[x + toppleDistance][y - toppleDistance] += incrementer;

  matrix[x - toppleDistance][y + toppleDistance] += incrementer;
  
  matrix[x + toppleDistance][y + toppleDistance] += incrementer;
}

function pointColor(value) {
  return color(
    value * colorSlider.value() % colorRange,         //hue
    80,                        //saturation
    (value * 30)        //brightness
  )
}

function drawMatrix(depth) {
  for(var i = 1; i<matrix.length - 1; i++) {
    for(var j = 1; j<matrix[0].length - 1; j++) {
      if(matrix[i][j] > 0 && matrix[i][j] >= depth) {
        stroke(pointColor(matrix[i][j]));
        point(i, j);
      }
    }
  }
}

function draw() {
  strokeWeight(4);
  background(220);
  
  drawMatrix(depth);
  for(var i = 0; i<2; i++) {
    topple(depth);
  }
  
}
