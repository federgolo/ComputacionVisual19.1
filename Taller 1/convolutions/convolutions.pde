import processing.video.*;

PImage myImg;
PGraphics pg1, pg2, pg3, pg4, pg5, pg6, pg;
int imgWidth;
int imgHeight;
int w = 120;
int state = 0;

Capture video;
// It's possible to convolve the image with many different 
// matrices to produce different effects. This is a high-pass 
// filter; it accentuates the edges. 

float[][] sharpen = {{ 0, -1, 0 }, 
  { -1, 5, -1}, 
  { 0, -1, 0 } };

float[][] box_blur = {{ 0.1, 0.1, 0.1 }, 
  { 0.1, 0.1, 0.1}, 
  {0.1, 0.1, 0.1} };

float[][] highlight_edges = {{ -1, -1, -1 }, 
  { -1, 9, -1 }, 
  { -1, -1, -1 } }; 

float[][] negative_edges =  {{ 0, 1, 0}, 
  { 1, -4, 1}, 
  { 0, 1, 0} };   

float[][] relief_edges = {{ -2, -1, 0}, 
  { -1, 1, 1}, 
  {  0, 1, 2} };  

float[][] saturation = {{ 1, 2, 1 }, 
  { 2/6, 4/6, 2/16}, 
  { 1/6, 2/6, 1/6 } };

float[][] matrix;

void setup() {
  size(1020, 630);
  frameRate(14);

  myImg = loadImage("nba.jpg");
  imgWidth = myImg.width;
  imgHeight = myImg.height;
  pg1 = createGraphics(imgWidth, imgHeight);
  pg2 = createGraphics(imgWidth, imgHeight);
  pg3 = createGraphics(imgWidth, imgHeight);
  pg4 = createGraphics(320, 240);
  pg5 = createGraphics(320, 240);
  pg6 = createGraphics(320, 240);
  pg = createGraphics(50, 50);

  // Initialize Capture object.
  video = new Capture(this, 320, 240);

  // Start the capturing process.
  video.start();
}

void draw() {

  //pg.beginDraw();
  //pg.text(frameRate, 5, 10);
  //pg.endDraw();
  //image(pg, 5, 15);

  switch(state) {
  case 0:
    matrix = box_blur;
    break;
  case 1:
    matrix = highlight_edges;
    break;
  case 2:
    matrix = negative_edges;
    break;
  case 3:
    matrix = relief_edges;
    break;
  case 4:
    matrix = saturation;
    break;
  }

  // We're only going to process a portion of the image
  // so let's set the whole image as the background first
  pg1.beginDraw();
  pg1.background(myImg);
  pg1.endDraw();

  pg2.beginDraw();
  pg2.background(myImg);
  pg2.endDraw();

  pg3.beginDraw();
  pg3.background(myImg);
  pg3.endDraw();

  image(pg1, 30, 30);

  // Calculate the small rectangle we will process
  int xstart = constrain(mouseX - w/2, 0, myImg.width);
  int ystart = constrain(mouseY - w/2, 0, myImg.height);
  int xend = constrain(mouseX + w/2, 0, myImg.width);
  int yend = constrain(mouseY + w/2, 0, myImg.height); 
  int matrixsize = matrix.length;
  pg2.loadPixels();
  // Begin our loop for every pixel in the smaller image
  for (int x = xstart; x < xend; x++) {
    for (int y = ystart; y < yend; y++ ) {
      color c = convolution(x, y, matrix, matrixsize, myImg);
      int loc = x + y*myImg.width;
      pg2.pixels[loc] = c;
    }
  }
  pg2.updatePixels();
  image(pg2, myImg.width+60, 30);

  // Now do it for the whole image
  pg3.loadPixels();
  // Begin our loop for every pixel in the image
  for (int x = 0; x < myImg.width; x++) {
    for (int y = 0; y < myImg.height; y++ ) {
      color c = convolution(x, y, matrix, matrixsize, myImg);
      int loc = x + y*myImg.width;
      pg3.pixels[loc] = c;
    }
  }
  pg3.updatePixels();
  image(pg3, myImg.width*2+90, 30);

  pg4.beginDraw();
  pg4.background(video);
  pg4.fill(0);
  pg4.text(frameRate + " fps" , 0, 10);
  pg4.endDraw();

  pg5.beginDraw();
  pg5.background(video);
  if (video.available()) {
    video.read();
    video.loadPixels();
    pg5.loadPixels();
    for (int x = 0; x < video.width ; x++) {
      for (int y = 0; y < video.height; y++ ) {
        color c = convolution(x, y, matrix, matrixsize, video);
        int loc = x + y*video.width;
        pg5.pixels[loc] = c;
      }
    }

    //for (int x = video.width / 2; x < video.width; x++) {
    //  for (int y = 0; y < video.height; y++ ) {
    //    int loc = x + y*video.width;
    //    int avg = int((red(video.pixels[loc]) + green(video.pixels[loc]) + blue(video.pixels[loc])) / 3);
    //    pg5.pixels[loc] = color(avg);
    //  }
    //}
    pg5.updatePixels();
  }
  pg5.endDraw();

  pg6.beginDraw();
  pg6.background(video);

  video.loadPixels();
  pg6.loadPixels();
  for (int i = 0; i < video.pixels.length; i++) {
    int avg = int((red(video.pixels[i]) + green(video.pixels[i]) + blue(video.pixels[i])) / 3);
    pg6.pixels[i] = color(avg);
  }
  pg6.updatePixels();
  pg6.endDraw();

  image(pg4, 20, 360);
  image(pg5, 350, 360);
  image(pg6, 680, 360);
}

void mouseClicked() {
  if (state <4) {
    state+=1;
  } else {
    state=0;
  }
}


color convolution(int x, int y, float[][] matrix, int matrixsize, PImage img)
{
  float rtotal = 0.0;
  float gtotal = 0.0;
  float btotal = 0.0;
  int offset = matrixsize / 2;
  for (int i = 0; i < matrixsize; i++) {
    for (int j= 0; j < matrixsize; j++) {
      // What pixel are we testing
      int xloc = x+i-offset;
      int yloc = y+j-offset;
      int loc = xloc + img.width*yloc;
      // Make sure we haven't walked off our image, we could do better here
      loc = constrain(loc, 0, img.pixels.length-1);
      // Calculate the convolution
      rtotal += (red(img.pixels[loc]) * matrix[i][j]);
      gtotal += (green(img.pixels[loc]) * matrix[i][j]);
      btotal += (blue(img.pixels[loc]) * matrix[i][j]);
    }
  }
  // Make sure RGB is within range
  rtotal = constrain(rtotal, 0, 255);
  gtotal = constrain(gtotal, 0, 255);
  btotal = constrain(btotal, 0, 255);
  // Return the resulting color
  return color(rtotal, gtotal, btotal);
}
