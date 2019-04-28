import processing.video.*;

PImage myImage, bwImage;
PGraphics pg1, pg2, pg3, pg4, pg5;
int imgWidth, imgHeight;
int[] hist = new int[256];

Capture video;

void setup() {
  size(961, 630);
  // background(255, 255, 0)
  myImage = loadImage("nba.jpg");
  imgWidth = myImage.width;
  imgHeight = myImage.height;
  pg1 = createGraphics(imgWidth, imgHeight);
  pg2 = createGraphics(imgWidth, imgHeight);
  pg3 = createGraphics(imgWidth, imgHeight);
  pg4 = createGraphics(320, 240);
  pg5 = createGraphics(320, 240);

  // Step 3. Initialize Capture object.
  video = new Capture(this, 320, 240);

  // Step 4. Start the capturing process.
  video.start();
}

void draw() {

  // Draw background image on first two canvases.
  pg1.beginDraw();
  pg1.background(myImage);
  pg1.endDraw();

  pg2.beginDraw();
  pg2.background(myImage);
  pg2.endDraw();

  //noLoop();
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

  // Now we save the second canvas (the one we modified) to an image file and proceed to use it as the background for the third canvas.
  pg2.save("bw.png");
  bwImage = loadImage("bw.png");
  int histMax = max(hist);
  pg3.beginDraw();
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

  image(pg1, 15, 15);
  image(pg2, imgWidth + 31, 15);
  image(pg3, 2*imgWidth + 46, 15);
  image(pg4, 15, 330);
  image(pg5, 350, 330);
  
  pg4.beginDraw();
  pg4.background(video);
  pg4.endDraw();
  
  pg5.beginDraw();
  pg5.background(video);
    if (video.available()) {
    video.read();
    video.loadPixels();
    pg5.loadPixels();
    for (int i = 0; i < video.pixels.length; i++) {
      int avg = int((red(video.pixels[i]) + green(video.pixels[i]) + blue(video.pixels[i])) / 3);
      pg5.pixels[i] = color(avg, avg, avg);
    }
    pg5.updatePixels();
  }
  pg5.endDraw();

  //image(video, 15, 330);
}
