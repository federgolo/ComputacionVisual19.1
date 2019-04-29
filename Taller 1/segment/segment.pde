HScrollbar hs1, hs2;  // Two scrollbars
PImage img1, bwImage;  // Two images to load
PGraphics pg1, pg2, pg3;  
int imgWidth;
int imgHeight;
int[] grays = new int[256];
int[] hist = new int[256];

void setup() {
  size(1039, 375);
  noStroke();
  background(105, 200, 190);
  img1 = loadImage("nba.jpg");
  imgWidth = img1.width;
  imgHeight = img1.height;
  pg1 = createGraphics(imgWidth, imgHeight);
  pg2 = createGraphics(imgWidth, imgHeight);
  pg3 = createGraphics(imgWidth, imgHeight);
  hs1 = new HScrollbar(2*imgWidth + 46, pg3.height+22, pg3.width, 16, 16);
  hs2 = new HScrollbar(2*imgWidth + 46, pg3.height+38, pg3.width, 16, 16);
}

void draw() {
  // Draw background image on first two canvases.
  pg1.beginDraw();
  pg1.background(img1);
  pg1.endDraw();

  pg2.beginDraw();
  pg2.background(img1);
  pg2.endDraw();
  
  pg2.loadPixels();
  for (int i=0; i<pg2.pixels.length; i++) {
    // Here we go through every pixel of the image, get their RGB values and then overwrite them with the average of the three
    // values to turn the image to grayscale. 
    int avg = int((red(pg2.pixels[i]) + green(pg2.pixels[i]) + blue(pg2.pixels[i])) / 3);
    pg2.pixels[i] = color(avg, avg, avg);
    grays[avg]++;
    // As we do this, we also save said "new color values" to the "grays" array, which we will use to create the histogram.
  }    
  // Another way to create the histogram would include using the brightness method, as shown below.    
  for (int i=0; i<pg2.pixels.length; i++) {
    int brights = (int(brightness(pg2.pixels[i])));
    hist[brights]++;
  }
  pg2.updatePixels();

  int histMax = max(hist);
  pg3.beginDraw();
  for (int i = 0; i < pg3.width; i++) {
    // Map i (from 0..img.width) to a location in the histogram (0..255)
    int which = int(map(i, 0, pg3.width, 0, 255));
    // Convert the histogram value to a location between 
    // the bottom and the top of the picture
    int y = int(map(hist[which], 0, histMax, pg3.height, 0));
    pg3.stroke(int(map(i,0,pg3.width,0,255)));
    pg3.line(i, pg3.height, i, y);
  }
  
  pg3.endDraw();
  float pg3i=2*imgWidth + 46;
  float pg3f= pg3i+pg3.width;

  //println(pg3i);
  //println(pg3f);
  float posh1=int(map(hs1.getPos(), pg3i , pg3f,0,255));
  float posh2=int(map(hs2.getPos(), pg3i , pg3f,0,255));
  float[] intervalo = new float[2];
  if(posh1<posh2){
    intervalo[0]=posh1;
    intervalo[1]=posh2;
  }else{
    intervalo[0]=posh2;
    intervalo[1]=posh1;
  }
  pg2.loadPixels();
  for(int i=0;i<pg2.pixels.length;i++){
    int avg = int((red(pg2.pixels[i]) + green(pg2.pixels[i]) + blue(pg2.pixels[i])) / 3);
    
    if(avg>intervalo[1] || avg<intervalo[0]){
      pg2.pixels[i]=color(105, 200, 190);
    }
  }
  pg2.updatePixels();
  fill(255); 
  //image(pg1, pg1.width/2-img1.width/2 + img1Pos*1.5, 0);
  
  // Get the position of the img2 scrollbar
  // and convert to a value to display the img2 image
  fill(255);
  image(pg1, 15, 15);
  image(pg2, imgWidth + 31, 15);
  image(pg3, 2*imgWidth + 46, 15);
  //image(img1, width/2-img1.width/2 + img2Pos*1.5, height/2);
 
  hs1.update();
  hs2.update();
  hs1.display();
  hs2.display();
  
  stroke(0);
}


class HScrollbar {
  int swidth, sheight;    // width and height of bar
  float xpos, ypos;       // x and y position of bar
  float spos, newspos;    // x position of slider
  float sposMin, sposMax; // max and min values of slider
  int loose;              // how loose/heavy
  boolean over;           // is the mouse over the slider?
  boolean locked;
  float ratio;

  HScrollbar (float xp, float yp, int sw, int sh, int l) {
    swidth = sw;
    sheight = sh;
    int widthtoheight = sw - sh;
    ratio = (float)sw / (float)widthtoheight;
    xpos = xp;
    ypos = yp-sheight/2;
    spos = xpos + swidth/2 - sheight/2;
    newspos = spos;
    sposMin = xpos-1;
    sposMax = xpos + swidth+1;
    loose = l;
  }

  void update() {
    if (overEvent()) {
      over = true;
    } else {
      over = false;
    }
    if (mousePressed && over) {
      locked = true;
    }
    if (!mousePressed) {
      locked = false;
    }
    if (locked) {
      newspos = constrain(mouseX-sheight/2, sposMin, sposMax);
    }
    if (abs(newspos - spos) > 1) {
      spos = spos + (newspos-spos)/loose;
    }
  }

  float constrain(float val, float minv, float maxv) {
    return min(max(val, minv), maxv);
  }

  boolean overEvent() {
    if (mouseX > xpos && mouseX < xpos+swidth &&
       mouseY > ypos && mouseY < ypos+sheight) {
      return true;
    } else {
      return false;
    }
  }

  void display() {
    noStroke();
    fill(204);
    rect(xpos, ypos, swidth, sheight);
    if (over || locked) {
      fill(0, 0, 0);
    } else {
      fill(102, 102, 102);
    }
    rect(spos, ypos, 8, sheight);
  }

  float getPos() {
    // Convert spos to be values between
    // 0 and the total width of the scrollbar
    return spos ;
  }
}
