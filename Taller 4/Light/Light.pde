PShape can;
float angle;
boolean vert=true;
boolean b=true;
PShader pixlightShader;
int state=0;
void setup() {
  size(640, 360, P3D);
  can = createCan(100, 200, 32);
  
}
 
void draw() {   
  
  if(vert){  
    switch(state) {
    case 0:
      pixlightShader = loadShader("pixlightfragamb.glsl", "pixlightvert.glsl");
      println("FragmentShader Ambiente");

      break;
    case 1:
      pixlightShader = loadShader("pixlightfragdif.glsl", "pixlightvert.glsl");
      println("FragmentShader Difusa");
      break;
    case 2:
      pixlightShader = loadShader("pixlightfragspec.glsl", "pixlightvert.glsl");
      println("FragmentShader Especular");
      break;
    case 3:
      pixlightShader = loadShader("pixlightfragambspec.glsl", "pixlightvert.glsl");
      println("FragmentShader Ambiente+Especular");
      break;
    case 4:
      pixlightShader = loadShader("pixlightfragambdif.glsl", "pixlightvert.glsl");
      println("FragmentShader Ambiente+Difusa");
      break;
    case 5:
      pixlightShader = loadShader("pixlightfragdifspec.glsl", "pixlightvert.glsl");
      println("FragmentShader Especular+Difusa");
      break;
    case 6:
      pixlightShader = loadShader("pixlightfragcomb.glsl", "pixlightvert.glsl");
      println("FragmentShader All In");
      break;
    }
  }else{
    switch(state) {
    case 0:
      pixlightShader = loadShader("pixlightfrag.glsl", "pixlightvertamb.glsl");
      println("VertexShader Ambiente");
      break;
    case 1:
      pixlightShader = loadShader("pixlightfrag.glsl", "pixlightvertdif.glsl");
      println("VertexShader Difusa");
      break;
    case 2:
      pixlightShader = loadShader("pixlightfrag.glsl", "pixlightvertspec.glsl");
      println("VertexShader Especular");
      break;
    case 3:
      pixlightShader = loadShader("pixlightfrag.glsl", "pixlightvertambspec.glsl");
      println("VertexShader Ambiente+Especular");
      break;
    case 4:
      pixlightShader = loadShader("pixlightfrag.glsl", "pixlightvertambdif.glsl");
      println("VertexShader Ambiente+Difusa");
      break;
    case 5:
      pixlightShader = loadShader("pixlightfrag.glsl", "pixlightvertdifspec.glsl");
      println("VertexShader Especular+Difusa");
      break;
    case 6:
      pixlightShader = loadShader("pixlightfrag.glsl", "pixlightvertcomb.glsl");
      println("VertexShader All In");
      break;  
  }
}
    
  if(b){
    background(0);
  }else{
    background(225);
  }
  
  pointLight(255, 255, 255, mouseX, mouseY, 200);
  shader(pixlightShader);
  translate(width/2, height/2);
  rotateY(angle);  
  shape(can);  
  angle += 0.01;
}


PShape createCan(float r, float h, int detail) {
  textureMode(NORMAL);
  PShape sh = createShape();
  sh.beginShape(QUAD_STRIP);
  sh.noStroke();
  for (int i = 0; i <= detail; i++) {
    float angle = TWO_PI / detail;
    float x = sin(i * angle);
    float z = cos(i * angle);
    float u = float(i) / detail;
    sh.normal(x, 0, z);
    sh.vertex(x * r, -h/2, z * r, u, 0);
    sh.vertex(x * r, +h/2, z * r, u, 1);
  }
  sh.endShape(); 
  return sh;
}

void keyPressed() {
  if (key == 'b' || key=='B') {
    b=!b;
  }
  if (key == ' '){
    vert=!vert;
  }
}
void mouseClicked() {
  print(state);
  if (state <6) {
    state+=1;
  } else {
    state=0;
  }
}
