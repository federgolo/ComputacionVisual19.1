import processing.video.*;

PImage myImg;
int imgWidth, imgHeight;
PGraphics pg1, pg2, pg3;
int w = 120;
int state = 0;

Capture video;

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

float[][] matrix = negative_edges;
int matrixsize = matrix.length;

void setup() {
  size(685, 630);
  frameRate(10);
  pg1 = createGraphics(320, 240);
  pg2 = createGraphics(320, 240);
  pg3 = createGraphics(320, 240);

  // Step 3. Initialize Capture object.
  video = new Capture(this, 320, 240);

  // Step 4. Start the capturing process.
  video.start();
}

void draw() {
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

  pg1.beginDraw();
  pg1.background(video);
  pg1.endDraw();

  pg2.beginDraw();
  pg2.background(video);
  if (video.available()) {
    video.read();
    video.loadPixels();
    pg2.loadPixels();
    for (int x = 0; x < video.width / 2; x++) {
      for (int y = 0; y < video.height; y++ ) {
        color c = convolution(x, y, matrix, matrixsize, video);
        int loc = x + y*video.width;
        pg2.pixels[loc] = c;
      }
    }

    for (int x = video.width / 2; x < video.width; x++) {
      for (int y = 0; y < video.height; y++ ) {
        int loc = x + y*video.width;
        int avg = int((red(video.pixels[loc]) + green(video.pixels[loc]) + blue(video.pixels[loc])) / 3);
        pg2.pixels[loc] = color(avg);
      }
    }
    pg2.updatePixels();
  }
  pg2.endDraw();

  pg3.beginDraw();
  pg3.background(video);
  if (video.available()) {
    video.read();
    video.loadPixels();
    pg3.loadPixels();
    for (int i = 0; i < video.pixels.length; i++) {
      int avg = int((red(video.pixels[i]) + green(video.pixels[i]) + blue(video.pixels[i])) / 3);
      pg3.pixels[i] = color(avg);
    }
    pg3.updatePixels();
  }
  pg3.endDraw();

  image(pg1, (width-video.width)/2, 15);
  image(pg2, 15, 270);
  image(pg3, 360, 270);
}

void mouseClicked() {
  if (state <4) {
    state+=1;
  } else {
    state=0;
  }
}

color convolution(int x, int y, float[][] matrix, int matrixsize, Capture video)
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
      int loc = xloc + video.width*yloc;
      // Make sure we haven't walked off our image, we could do better here
      loc = constrain(loc, 0, video.pixels.length-1);
      // Calculate the convolution
      rtotal += (red(video.pixels[loc]) * matrix[i][j]);
      gtotal += (green(video.pixels[loc]) * matrix[i][j]);
      btotal += (blue(video.pixels[loc]) * matrix[i][j]);
    }
  }
  // Make sure RGB is within range
  rtotal = constrain(rtotal, 0, 255);
  gtotal = constrain(gtotal, 0, 255);
  btotal = constrain(btotal, 0, 255);
  // Return the resulting color
  return color(rtotal, gtotal, btotal);
}
