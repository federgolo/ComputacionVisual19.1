color cream = #ffffcc;
color blue = #000066;
color green = #00ff99;
int grid=1;

void setup() {
  background(255);
  size(640, 480);
  noStroke();
  fill(blue);
  rect(0, 0, width/2, 400);
  fill(cream);
  rect(width/2, 0, width/2, 400);

  fill(green);
  // Draws left tree.
  rect(160, 320, 20, 40);
  triangle(100, 320, 240, 320, 170, 80);
  // Draws right tree.
  rect(460, 260, 20, 40);
  triangle(400, 260, 540, 260, 470, 20);
  
  textAlign(CENTER);
  textSize(28);
  fill(0);
  text("Blanca Navidad - Ilusión de color", 320, 429);
  textSize(20);
  text("Presione una tecla para ocultar las barras.", 320, 459);
}

void draw() {

  if (keyPressed){
   setup();
  }
  else {
    for (int i=0; i<20; i++) {
      fill(cream);
      if (i%2==0)
        rect(0, i*20, width/2, 20);
      else {
        fill(blue);
        rect(width/2, i*20, width/2, 20);
      }
    }
  }
}
