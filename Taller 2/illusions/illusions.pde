color blue = #0000ff;
color yellow = #ffff00;

// Angle and angular velocity
float r, r1, theta, theta_vel;
float[] xPos = new float[12];
float[] yPos = new float[12];
int crater=0;

void setup() {
  size(950, 700);
  // Initialize all values
  r = 320;
  r1 = 320-160;
  theta = 0;
  theta_vel = 0.01;
}

void draw() {
  background(0);
  textAlign(CENTER);
  textSize(32);
  text("Stereokinetic \neffect", 800, 50);
  stroke(yellow);
  line(700, 120, 900, 120);
  fill(255);
  textSize(20);
  text("La rotación de figuras" +"\n"+ "adecuadas crea una" +"\n"+ "ilusión tridimensional.", 800, 150);
  text("- COMANDOS -", 800, 270);
  text("1: encender crater" +"\n"+ "2: apagar crater", 800, 300);
  
  
  // Convert polar to cartesian
  if (keyPressed) {
    if (key == '1') {
      crater=0;
    }
    else if (key == '2') {
      crater=1;
    }
  }
  switch(crater) {
  case 0:
    for (int i=0; i<6; i++) {
    float x = (r1+(16*i)) * cos(theta);
    float y = (r1+(16*i)) * sin(theta);
    xPos[i] = x;
    yPos[i] = y;
  }
  for (int i=6; i<12; i++) {
    float x = (r-(16*i)) * cos(theta);
    float y = (r-(16*i)) * sin(theta);
    xPos[i] = x;
    yPos[i] = y;
  }
    break;
  case 1:
    for (int i=0; i<12; i++) {
    float x = (r-(16*i)) * cos(theta);
    float y = (r-(16*i)) * sin(theta);
    xPos[i] = x;
    yPos[i] = y;
  }
    break;
  default:
    System.out.println("error");
}

  // Translate the origin point to the center of the screen
  translate(700/2, 700/2);

  // Draw the ellipse at the cartesian coordinate
  ellipseMode(CENTER);
  noStroke();

  for (int i=11; i>-1; i--) {
    if (i%2==0)
      fill(yellow);
    else fill(blue);
    ellipse(xPos[i], yPos[i], 32*(i+1), 32*(i+1));
  }

  // Apply acceleration and velocity to angle (r remains static in this example)
  theta += theta_vel;
}
