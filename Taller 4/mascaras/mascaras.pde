// Texture from Jason Liebig's FLICKR collection of vintage labels and wrappers:
// http://www.flickr.com/photos/jasonliebigstuff/3739263136/in/photostream/

PImage label, myImg;
PShape can;
float angle;
PGraphics pg1;
int state=0;

PShader edgesShader;

void setup() {
  size(380, 360, P3D);
  myImg = loadImage("nba.jpg");
  int imgWidth = myImg.width;
  int imgHeight = myImg.height;
  pg1 = createGraphics(imgWidth, imgHeight);
}

void draw() {    
    switch(state) {
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
    
  image(pg1, 30, 30);
}

void mouseClicked() {
  if (state <4) {
    state+=1;
  } else {
    state=0;
  }
}
