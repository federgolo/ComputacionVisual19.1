int up=0, down=0, value=0;
float x1;

void setup(){
  size(900,300);
}
boolean f=true;
void draw() {
  background(255,255,255);
  for(int i=0; i<width;i+=(up%15)+25){
    strokeWeight(up%10+10);
    stroke(value);
    line(i, 0, i, height);
  }
  if(f){
    if(x1+60<=width){
    x1+=1;
    }else{
      f=false;
      }
  }else{
    x1-=1;
    if(x1<=0){
      f=true;
    }
  }
  println(x1);
  noStroke();
  fill(color(0,0,205));
  rect(x1, 50, 60, 50);
  fill(color(250,255,0));
  rect(x1, 150, 60, 50);
} 
 
void mouseWheel(MouseEvent event) {
  float e = event.getAmount();
  if (e>0) {
    up++; 
    down =0;
  }
  if (e<0) {
    down++; 
    up=0;
  }  
}
void mouseClicked() {
  if (value == 0) {
    value = 255;
  } else {
    value = 0;
  }
}
