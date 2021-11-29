int[][] sandpiles;
float count;

void setup() {
  size(1280,720);
  colorMode(RGB);
  frameRate(20);
  sandpiles = new int[width][height]; //A 2-dimenaional array
  for (int x = 0; x < width; x++) {
    int count = 0;
    for (int y = 0; y < height; y++) {
      sandpiles[x][y] = floor( noise(x,y)+sin(y) ); // Load initial pile with noise
    }
  }
  sandpiles[width/2][height/2] = 100000; //Initial sandpile will topple outward
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
  int baseCol = 255;
  loadPixels();
  for(int x = 0; x < width; x++) {
    for(int y = 0; y < height; y++) {
      int num = sandpiles[x][y]; 
      color col = color(100,baseCol,100);
      switch (num) {
        case 0:
          col = color(100,200,baseCol);
          break;
        case 1:
          col = color(100,200,baseCol);
          break;
        case 2:
          col = color(baseCol,200,baseCol);
          break; 
      }
      pixels[x+y*width] = col; // pixels[] is a 1-dimensional array native to Proessing
    }
  }
  
  updatePixels();
}

void draw() {
  render();
  for (int i = 0; i < 1; i++) {
   //The topple function was initially designed for static values
   //However, using trig functions based on time creates some extraordinary effects
   topple( floor(sin(count ))  );
  }
  count += 0.5;
  
  //saveFrame();
}
