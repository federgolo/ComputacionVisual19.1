Heart loops;
int directionX = 0, directionY = 0;
float x=20, y=20, speed=0.5;
color col = color(255, 0, 0);
color col2 = color(0, 0, 255);

void setup() {
  size(1000, 500);
  background(255);
  smooth();
}

void draw() {   
  x=x+speed*directionX;
  y=y+speed*directionY;
  if(y<=-200 || y>=height-150){
    directionY*=-1;
  }
  println(x);
  if(x<=-600 || x>=150){
    directionX*=-1;
  }
  background(255);
  loops = new Heart(width/2, height/2, 500, 30, col);
  loops.drawCircle();
  loops = new Heart(width-width/4+x, height/2+y, 500, 30, col2);
  loops.drawCircle();
}

class Heart {
  float x, y;
  int dia;
  int steps;
  color col;
  Heart(float _x, float _y, int _dia, int _steps, color _col) {
    x = _x;
    y = _y;
    dia = _dia;
    steps = _steps;
    col=_col;
  }
  void drawCircle() {
    for (int i = dia; i > 0; i-=steps) {
      noFill();
      strokeWeight(8); 
      stroke(col);      
      ellipse(x, y, i, i);
    }
  }
}

void keyPressed()
{
  if (key == CODED)
  {
    if (keyCode == LEFT)
    {
      //if (directionX>0) { 
      directionX=-1;
      directionY=0;
      //}
    } else if (keyCode == RIGHT)
    {
      //if (directionX<0) {  
      directionX=1;
      directionY=0;
      //}
    } else if (keyCode == UP)
    {
      //if (directionY<0) {
      directionY=-1;
      directionX=0;
      //}
    } else if (keyCode == DOWN)
    {
      //if (directionY<0) { 
      directionY=1;
      directionX=0;
      //}
    }
  }
}
