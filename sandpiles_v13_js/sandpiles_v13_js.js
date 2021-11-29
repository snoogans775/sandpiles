// create a pile of sand in the middle
// write a topple function
// draw the piles
const canvasWidth = 400;
const canvasHeight = 400;
const initialPile = 10000000;
const toppleDistance = 2;
let colors;
let depthThresholdSlider = {};

const matrix = [];
for(var i = 0; i < canvasHeight; i++) {
  let inner = [];
  for(var j = 0; j < canvasWidth; j++) {
    inner[j] = 0;
  }
  matrix.push(inner);
}

function setup() {
  // colorMode(HSB, 100);
  frameRate(30);
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
  depthThresholdSlider = createSlider(4, 16, 4, 2);
  depthThresholdSlider.position(20, height - 20);
}

function topple(depth) {
  for(var i = 0; i<height; i++) {
    for(var j = 0; j<width; j++) {
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
  
  // To allow for creativity, we need to distribute an
  // sorta arbitrary number of sand 'grains'
  
  let divisibleByFour = depth % 4 == 0;
  // const incrementer = divisibleByFour ? depth / 4 : 1;
  const incrementer = 1;
  
  matrix[x - toppleDistance][y - toppleDistance] += incrementer;

  matrix[x + toppleDistance][y - toppleDistance] += incrementer;

  matrix[x - toppleDistance][y + toppleDistance] += incrementer;
  
  matrix[x + toppleDistance][y + toppleDistance] += incrementer;
}

function pointColor(value) {
  return color(
    value * 50 % 255, 
    value * 150 % 255, 
    value * 250 % 255
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
  background(220);
  
  drawMatrix(depthThresholdSlider.value());
  for(var i = 0; i<1; i++) {
    topple(depthThresholdSlider.value());
  }
  
}
