PImage base_img, bump_map;
float x_pos, y_pos;    // Starting position of light square. Determined via random floats.
float speed = 2;     // Speed by which the square of light moves in every direction.
int direction = 5;

int[] normal_x, normal_y;
float[] envMap;
int environment = 256;

void setup() {
  size(832, 468);
  base_img=loadImage("original_image.png");
  bump_map = loadImage("original_image.png");
  normal_x = new int[base_img.pixels.length];
  normal_y = new int[base_img.pixels.length];
  bump_map.loadPixels();
  for (int i=1; i<bump_map.width-1; i++) {
    for (int j=1; j<bump_map.height-1; j++) {
      normal_x[i+bump_map.width*j] = round((bump_map.pixels[(i+1)+bump_map.width*j] >> 16 & 0xFF) - (bump_map.pixels[(i-1)+bump_map.width*j]>> 16 & 0xFF));
      normal_y[i+bump_map.width*j] =  round((bump_map.pixels[i+bump_map.width*(j+1)] >> 16 & 0xFF) -  (bump_map.pixels[i+bump_map.width*(j-1)] >> 16 & 0xFF));
    }
  }
  envMap = new float[environment*environment];
  for (int j=0; j<environment; j++) {
    for (int i=0; i<environment; i++) {
      float Nx = (i - 800)/800;
      float Ny = (j - 800)/800;
      float Nz = 1 - sqrt(Nx * Nx + Ny * Ny);
      if (Nz<0)
        Nz = 0;
      envMap[i+environment*j] = Nz*256;
    }
  }
  float r1 = random(0, width);
  float r2 = random(0, height);
  print("origin", r1, " ", r2);
  x_pos = r1;
  y_pos = r2;
}

void keyReleased() {
  if (key==' ') {
    direction = 0;
  } else if (keyCode == RIGHT) {
    direction=1;
  } else if (keyCode == LEFT) {
    direction=2;
  } else if (keyCode == UP) {
    direction=3;
  } else if (keyCode == DOWN) {
    direction=4;
  } else if (key == 'f') {
    direction=5;
  }
}

void draw() {
  background(0);
  PImage modified_base_img = bumpMapper(round(x_pos), round(y_pos));
  image(modified_base_img, 0, 0);
  if (direction==0) {
    // stay still
  } else if (direction==1) {
    x_pos = x_pos + speed;
  } else if (direction==2) {
    x_pos = x_pos - speed;
  } else if (direction==3) {
    y_pos = y_pos - speed;
  } else if (direction==4) {
    y_pos = y_pos + speed;
  } else if (direction==5) {
    image(base_img, 0, 0); //show original image
    fill(0);
    textSize(40);
    text("MOVE WITH ARROWS", 320, 75);
  }
}

PImage bumpMapper(int lightX, int lightY) {
  PImage lookup_array = createImage(base_img.width, base_img.height, RGB);
  lookup_array.loadPixels();
  base_img.loadPixels();
  lightX +=128;
  lightY +=128;
  for (int i=0; i<base_img.width; i++) {
    for (int j=0; j<base_img.height; j++) {
      int nX = normal_x[i+base_img.width*j];
      int nY = normal_y[i+base_img.width*j];
      int lDistX = i-lightX;
      int lDistY = j-lightY;
      nX -= lDistX;
      nY -= lDistY;
      if (nX<0 || nX>=environment)
        nX = 0;
      if (nY<0 || nY>=environment)
        nY = 0;
      color base_imgColor = base_img.pixels[i+base_img.width*j];
      color nuColor = color(norm(envMap[nX+environment*nY], 0, 255)*red(base_imgColor), norm(envMap[nX+environment*nY], 0, 255)*green(base_imgColor), norm(envMap[nX+environment*nY], 0, 255)*blue(base_imgColor));
      lookup_array.pixels[i+base_img.width*j] = nuColor;
    }
  }
  lookup_array.updatePixels();
  return lookup_array;
}
