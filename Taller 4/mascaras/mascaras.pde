// Texture from Jason Liebig's FLICKR collection of vintage labels and wrappers:
// http://www.flickr.com/photos/jasonliebigstuff/3739263136/in/photostream/
import processing.video.*;

PImage label, myImg;
PShape can;
float angle;
PGraphics pg1, pg4, pg5;
int shader_state=0;

PShader edgesShader;
Capture video;

void setup() {
  size(710, 360, P2D);
  myImg = loadImage("nba.jpg");
  int imgWidth = myImg.width;
  int imgHeight = myImg.height;
  pg1 = createGraphics(imgWidth, imgHeight);
  pg4 = createGraphics(320, 240);
  pg5 = createGraphics(320, 240);

  // Initialize Capture object.
  video = new Capture(this, 320, 240);

  // Start the capturing process.
  video.start();

  textSize(20);
  fill(0);
  
}

void draw() {    

  switch(shader_state) {
  case 0:
    edgesShader = loadShader("edgesfrag.glsl");
    break;
  case 1:
    edgesShader = loadShader("highlight_edges.glsl");
    break;
  case 2:
    edgesShader = loadShader("negative_edges.glsl");
    break;
  case 3:
    edgesShader = loadShader("relief_edges.glsl");
    break;
  case 4:
    edgesShader = loadShader("saturation.glsl");
    break;
  }

  background(220);
  shader(edgesShader);
  pg1.beginDraw();
  pg1.background(myImg);
  pg1.endDraw();

  pg4.beginDraw();
  pg4.background(video);
  pg4.fill(0);
  pg4.text(frameRate + " fps", 0, 10);
  if (video.available()) {
    video.read();
  }
  pg4.endDraw();

  image(pg1, 30, 30);
  image(pg4, myImg.width + 60, 30);
  print(frameRate + " fps\n");
}

void mouseClicked() {
  if (shader_state <4) {
    shader_state+=1;
  } else {
    shader_state=0;
  }
}
