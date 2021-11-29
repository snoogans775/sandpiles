import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class sandpiles_v9 extends PApplet {

int[][] sandpiles;
int scl = 30;

public void setup() {
  
  background(0);
  colorMode(RGB);
  frameRate(30);
  sandpiles = new int[width][height]; //A 2-dimenaional array
  sandpiles[width/2][height/2] = 1000000; //Initial sandpile will topple outward
}

public void topple(int maxNum) {
  // The topple() function takes a values and uses it to control
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
    int num = sandpiles[x][y];
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

public void render() {
  int baseCol = 255;
  loadPixels();
  for(int x = 0; x < width; x++) {
    for(int y = 0; y < height; y++) {
      int num = sandpiles[x][y]; 
      int col = color(0,0,0);
      switch (num) {
        case 0:
          col = color(100,100,255);
          break;
        case 1:
          col = color(100,100,255);
          break;
        case 2:
          col = color(baseCol,200,baseCol);
          break;  
        case 3:
          col = color(255,255,baseCol);
          break; 
        case 4:
          col = color(150,150,255);
          break;
      }
      if(num == 3 | num == 2){
       pixels[x+y*width] = col; // pixels[] is a 1-dimensional array native to Proessing
      }
    }
  }
  
  updatePixels();
}

public void draw() {
  noStroke();
  render();
  for (int i = 0; i < 100; i++) {
    topple( 2 );
  }
}
  public void settings() {  size(600,600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#666666", "--stop-color=#cccccc", "sandpiles_v9" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
