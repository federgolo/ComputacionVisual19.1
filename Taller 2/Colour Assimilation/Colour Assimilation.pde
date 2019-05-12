int directionX=width/4+50, directionY=0;

void setup(){
  size(950, 700);
  for(int i=0;i<height-50;i+=12){
    strokeWeight(4);
    stroke(255, 0 , 0);
    line(0, i, width, i);
    stroke(0, 255, 0);
    line(0, i+4, width, i+4);
    stroke(0, 0, 255);
    line(0, i+8, width, i+8);
  } 
}

void draw(){
  float posGrid1=mouseX;
  float posGrid2=mouseX;
  float posGrid3=mouseX;
  println(mouseX);
  noStroke();
  rect(100,120, 200, 200);
  rect(width-500, 120, 200, 200);
  rect(width/2-200, height-300, 200,200);
  for(int i=120;i<320;i+=12){
    strokeWeight(4);
    stroke(255, 0, 0);
    constrain(posGrid1,100,300);
    line(100, i, posGrid1%320, i);
    stroke(0, 255, 0);
    line(100, i+4, posGrid1%320, i+4);
  }
  for(int i=120;i<320;i+=12){
    strokeWeight(4);
    stroke(255, 0, 0);
    constrain(posGrid2,width-500,width-300);
    line(width-500, i, width-500+((posGrid2)%(width-500)), i);
    stroke(0, 0, 255);
    line(width-500, i+8, width-500+((posGrid2)%(width-500)), i+8);
  }
    for(int i=height-300;i<height-100;i+=12){
    strokeWeight(4);
    stroke(0, 255, 0);
    constrain(posGrid3,width/2-200,width/2);
    line(width/2-200, i, width/2-200+((posGrid2)%(width/2)), i);
    stroke(0, 0, 255);
    line(width/2-200, i+4, width/2-200+((posGrid2)%(width/2)), i+4);
    }
  
}
