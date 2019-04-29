
PImage myImage, bwImage;
PGraphics pg1, pg2, pg3, pg4, pg5, pg6;
int imgWidth, imgHeight;
int[] hist = new int[256];


void setup() {
  size(1224, 605);
  //background(255, 255, 0);
  myImage = loadImage("colors.jpg");
  //myImage = loadImage("nba.jpg");
  imgWidth = myImage.width;
  imgHeight = myImage.height;
  pg1 = createGraphics(imgWidth, imgHeight);
  pg2 = createGraphics(imgWidth, imgHeight);
  pg3 = createGraphics(imgWidth, imgHeight);
  pg4 = createGraphics(imgWidth, imgHeight);
  pg5 = createGraphics(imgWidth, imgHeight);
  pg6 = createGraphics(imgWidth, imgHeight);

  textSize(20);
  fill(0);
  text("Original image", 140, 30);
  text("Gray scale by RGB Average", 480, 30);
  text("Histogram", 969, 30);
  textSize(10);
  text("0", 822, imgHeight + 55);
  text("255", 1198, imgHeight + 55);

  textSize(15);
  int cx = 823;
  int cy = height/4;
  textAlign(CENTER, BOTTOM);

  pushMatrix();
  translate(cx, cy);
  rotate(-HALF_PI);
  text("Frequency", 0, 0);
  popMatrix();

  textSize(20);
  text("Rec. 601", 200, 575);
  text("Rec. 709", 610, 575);
  text("Rec. 2100", 1017, 575);
  textSize(14);
  text("Y' = 0.299R + 0.587G + 0.114B", 210, 592);
  text("Y' = 0.2126R + 0.7152G + 0.0722B", 605, 592);
  text("Y' = 0.2627R + 0.6780G + 0.0593B", 1017, 592);
}

void draw() {

  // Draw background image on first two canvases.
  pg1.beginDraw();
  pg1.background(myImage);
  pg1.endDraw();

  pg2.beginDraw();
  pg2.background(myImage);
  pg2.endDraw();

  pg2.loadPixels();
  for (int i=0; i<pg2.pixels.length; i++) {
    // Here we go through every pixel of the image, get their RGB values and then overwrite them with the average of the three
    // values to turn the image to grayscale. 
    int avg = int((red(pg2.pixels[i]) + green(pg2.pixels[i]) + blue(pg2.pixels[i])) / 3);
    pg2.pixels[i] = color(avg, avg, avg);
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
  pg3.background(0);
  pg3.stroke(255);

  // Draw half of the histogram (skip every second value)
  for (int i = 1; i < pg3.width; i += 2) {
    // Map i (from 0..img.width) to a location in the histogram (0..255)
    int which = int(map(i, 0, pg3.width, 0, 255));
    // Convert the histogram value to a location between 
    // the bottom and the top of the picture
    int y = int(map(hist[which], 0, histMax, pg3.height, 0));
    pg3.line(i, pg3.height, i, y);
  }
  pg3.endDraw();

  pg4.beginDraw();
  pg4.background(myImage);
  pg4.endDraw();

  pg4.loadPixels(); //Rec 601 luma
  for (int i=0; i<pg4.pixels.length; i++) {
    int red = int(red(pg4.pixels[i]));
    int green = int(green(pg4.pixels[i]));
    int blue = int(blue(pg4.pixels[i]));
    float Y = red*0.299 + green*0.587 + blue*0.114;
    pg4.pixels[i] = color(Y, Y, Y);
  }
  pg4.updatePixels();

  pg5.beginDraw();
  pg5.background(myImage);
  pg5.endDraw();

  pg5.loadPixels(); //Rec 709 luma
  for (int i=0; i<pg5.pixels.length; i++) {
    int red = int(red(pg5.pixels[i]));
    int green = int(green(pg5.pixels[i]));
    int blue = int(blue(pg5.pixels[i]));
    float Y = red*0.2126 + green*0.7152 + blue*0.0722;
    pg5.pixels[i] = color(Y, Y, Y);
  }
  pg5.updatePixels();

  pg6.beginDraw();
  pg6.background(myImage);
  pg6.endDraw();

  pg6.loadPixels(); //Rec 2100
  for (int i=0; i<pg6.pixels.length; i++) {
    int red = int(red(pg6.pixels[i]));
    int green = int(green(pg6.pixels[i]));
    int blue = int(blue(pg6.pixels[i]));
    float Y = red*0.2627 + green*0.6780 + blue*0.0593;
    pg6.pixels[i] = color(Y, Y, Y);
  }
  pg6.updatePixels();


  textSize(20);
  fill(0);
  image(pg1, 15, 45);
  image(pg2, imgWidth + 31, 45);
  image(pg3, 2*imgWidth + 56, 45);
  image(pg4, 15, imgHeight + 61);
  image(pg5, imgWidth + 31, imgHeight + 61);
  image(pg6, 2*imgWidth + 56, imgHeight + 61);
}
