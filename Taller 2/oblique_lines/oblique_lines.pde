color light_blue = #ddebfc;
color sky_blue = #95b3e7;
color gray = #7f7f7f;
float theta = -PI/4.0;
float x, y;

void setup() {
  size(750, 475);
    noStroke();

  for (int i=0; i<8; i++) {
    fill(gray);
    rect(-25+(i*100), 0, 50, height);
    fill(light_blue);
    rect(25+(i*100), 0, 50, height);
  }

  for (int i=0; i<5; i++) {
    fill(sky_blue);
    rect(0, 50+(i*100), width, 50);
  }
}

void draw() {
  //translate(width/2, height/2);


  rotate(PI/4.0);

  for (int i=1; i<10; i++) {
    switch(i) {
      case(2):
      case(3):
      case(6):
      case(7):
      for (int j=0; j<8; j++) {
        // Takes cartesian coordinates and calculates its' equivalent on the rotated axis plain.
        x =  transformX(-(25+(j*100)), 50*i);
        y =  transformY(-(25+(j*100)), 50*i);

        // Draws diamonds with BLACK at top/bottom and WHITE at left/tight.
        fill(255);
        rect(x, y, -8, -8);
        rect(x, y, 8, 8);
        fill(0);
        rect(x, y, 8, -8);
        rect(x, y, -8, 8);

        // Takes cartesian coordinates and calculates its' equivalent on the rotated axis plain.
        x =  transformX(-(75+(j*100)), 50*i);
        y =  transformY(-(75+(j*100)), 50*i);

        // Draws diamonds with WHITE at top/bottom and BLACK at left/tight.
        fill(0);
        rect(x, y, -8, -8);
        rect(x, y, 8, 8);
        fill(255);
        rect(x, y, 8, -8);
        rect(x, y, -8, 8);
      }
      break;
      case(1):
      case(4):
      case(5):
      case(8):
      case(9):
      for (int j=0; j<8; j++) {
        // Takes cartesian coordinates and calculates its' equivalent on the rotated axis plain.
        x =  transformX(-(25+(j*100)), 50*i);
        y =  transformY(-(25+(j*100)), 50*i);

        // Draws diamonds with BLACK at top/bottom and WHITE at left/tight.
        fill(0);
        rect(x, y, -8, -8);
        rect(x, y, 8, 8);
        fill(255);
        rect(x, y, 8, -8);
        rect(x, y, -8, 8);

        // Takes cartesian coordinates and calculates its' equivalent on the rotated axis plain.
        x =  transformX(-(75+(j*100)), 50*i);
        y =  transformY(-(75+(j*100)), 50*i);

        // Draws diamonds with WHITE at top/bottom and BLACK at left/tight.
        fill(255);
        rect(x, y, -8, -8);
        rect(x, y, 8, 8);
        fill(0);
        rect(x, y, 8, -8);
        rect(x, y, -8, 8);
      }
      break;
    }
  }
}

float transformX(int x, int y) {
  float X = y*cos(theta) + x*sin(theta);
  return X;
}

float transformY(int x, int y) {
  float Y = -y*sin(theta) + x*cos(theta);
  return Y;
}
