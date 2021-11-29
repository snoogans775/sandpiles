int[][] sandpiles;

void setup() {
  size(1000,600);
  colorMode(RGB);
  frameRate(100);
  sandpiles = new int[width][height]; //A 2-dimenaional array
  for (int x = 0; x < width; x++) {
    int count = 0;
    for (int y = 0; y < height; y++) {
      sandpiles[x][y] = floor( noise(x,x%5) );
    }
  }
  sandpiles[width/2][height/2] = 10; //Initial sandpile will topple outward
}

void topple(int maxNum) {
  // The topple() function takes a value and uses it to control
  // the behavior of the sandpiles that topple away.
  // In this program, each pixel is computed as an individual sandpile.
  int[][] nextpiles = new int[width][height]; 
    for (int x = 0; x < width; x++) {
      for (int y = 0; y < height; y++) {
        int num = sandpiles[x][y];
        if (num < maxNum) {
        nextpiles[x][y] = sandpiles[x][y];
    }
   }
  }
 for (int x = 0; x < width; x++) {
  for (int y = 0; y < height; y++) {
    int num = sandpiles[x][y]; //Iterate through sandpiles array
    if (num >= maxNum) {
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
  int baseCol = 200;
  loadPixels();
  for(int x = 0; x < width; x++) {
    for(int y = 0; y < height; y++) {
      int num = sandpiles[x][y]; 
      color col = color(0,0,255);
      switch (num) {
        case 0:
          col = color(205,205,50);
          break;
        case 1:
          col = color(0,0,255);
          break;
        case 2:
          col = color(0,0,255);
          break; 
      }
      pixels[x+y*width] = col; // pixels[] is a 1-dimensional array native to Proessing
    }
  }
  
  updatePixels();
}

void draw() {
  render();
  for (int i = 0; i < 5; i++) {
   //The topple function was initially designed for static values
   //However, using trig functions based on time creates some extraordinary effects
   topple( floor(sin(millis() )) );
  }
}