int[][] sandpiles;

void setup() {
  size(600,600);
  colorMode(RGB);
  frameRate(100);
  sandpiles = new int[width][height]; //A 2-dimenaional array
  sandpiles[width/2][height/2] = 1000000; //Initial sandpile will topple outward
}

void topple() {
  int[][] nextpiles = new int[width][height];
    for (int x = 0; x < width; x++) {
      for (int y = 0; y < height; y++) {
        int num = sandpiles[x][y];
        if (num < 4) {
        nextpiles[x][y] = sandpiles[x][y];
    }
   }
  }
 for (int x = 0; x < width; x++) {
  for (int y = 0; y < height; y++) {
    int num = sandpiles[x][y];
    if (num >= 4) {
      nextpiles[x][y] += (num - 4);
      if (x+1 < width) {
       nextpiles[x+1][y]++;
      }
      if (x-1 >= 0) {
        nextpiles[x-1][y]++;
      }
      if (y+1 < height) {
        nextpiles[x][y+1]++;
      }
      if (y-1 >= 0) {
      nextpiles[x][y-1]++;
      }
    }
  }
 }
 sandpiles = nextpiles;
}

void render() {
  int baseCol = 255
  loadPixels();
  for(int x = 0; x < width; x++) {
    for(int y = 0; y < height; y++) {
      int num = sandpiles[x][y]; 
      color col = color(0,0,0);
      switch (num) {
        case 0:
          col = color(100,200,baseCol);
          break;
        case 1:
          col = color(100,baseCol,200);
          break;
        case 2:
          col = color(baseCol,200,baseCol);
          break;     
      }
      pixels[x+y*width] = col; // pixels[] is a 1-dimensional array
    }
  }
  
  updatePixels();
}

void draw() {
  render();
  for (int i = 0; i < 10; i++) {
   topple();
  }
}