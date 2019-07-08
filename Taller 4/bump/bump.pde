PImage img;
PImage bump_map;
int mode = 0;
int size = 60;
float x_pos, y_pos;    // Starting position of shape. Determined via random floats.
float speed = 6.5;     // Speed by which the ball of light moves in any direction.
int x_dir = -1;        // -1 means move to the left, 1 means to the right.
int y_dir = -1;        // -1 means move upwards, 1 means move downwards.

// normal vectors
int[] normal_x;
int[] normal_y;

// environment map
float[] envMap;
int envMapSize = 255;

// light
float AMB = 0;
float DIFFUSE = 200;
float SPECULAR = 100.0;
boolean perlin = false;
boolean phong = false;
boolean diagonal_movement = true;


void setup() {
  img=loadImage("imagen.png");
  size(832, 468);
  normal_x = new int[img.pixels.length];
  normal_y = new int[img.pixels.length];
  mapToVectors();
  envMap = new float[envMapSize*envMapSize];
  calculateEnvMap();
  float r1 = random(0, width);
  float r2 = random(0, height);
  //print(r1, r2);
  x_pos = r1;
  y_pos = r2;
}

PImage generateBumpMap() {
  if (perlin) {
    float noiseScale = 0.05;
    PImage noisy = createImage(width, height, RGB);
    noisy.loadPixels();
    for (int i=0; ++i<width; ) {
      for (int j=0; ++j<height; ) {
        noisy.pixels[i+j*width] = color(255*noise(i*noiseScale, j*noiseScale));
      }
    }
    noisy.updatePixels();
    return noisy;
  } else {
    return loadImage("imagen.png");
  }
}

void keyReleased() {
  if (key==' ') {
    mode = (mode+1)%2;
  } else if (key == 'p') {
    phong = !phong;
    calculateEnvMap();
  }
  // else if (key == 'b') {
  //  perlin = !perlin;
  //  mapToVectors();
  //}
}

void draw() {
  if (mode==0) {
    background(0);
    PImage s = bumpMapper(round(x_pos), round(y_pos));
    image(s, 0, 0);
    if (diagonal_movement) {
      x_pos = x_pos + ( speed * x_dir );
      y_pos = y_pos + ( speed * y_dir );
    }
    if (x_pos > width-size || x_pos < 0) {
      x_dir *= -1;
    }
    if (y_pos > height-size || y_pos < 0) {
      y_dir *= -1;
    }
  }
}

void mapToVectors() {
  bump_map = generateBumpMap();
  bump_map.loadPixels();
  for (int i=1; i<bump_map.width-1; i++) {
    for (int j=1; j<bump_map.height-1; j++) {
      normal_x[i+bump_map.width*j] = round((bump_map.pixels[(i+1)+bump_map.width*j] >> 16 & 0xFF) - (bump_map.pixels[(i-1)+bump_map.width*j]>> 16 & 0xFF));
      normal_y[i+bump_map.width*j] =  round((bump_map.pixels[i+bump_map.width*(j+1)] >> 16 & 0xFF) -  (bump_map.pixels[i+bump_map.width*(j-1)] >> 16 & 0xFF));
    }
  }
}

void calculateEnvMap() {
  for (int j=0; j<envMapSize; j++) {
    for (int i=0; i<envMapSize; i++) {
      float Nx = (i - 128)/128.0;
      float Ny = (j - 128)/128.0;
      float Nz = 1 - sqrt(Nx * Nx + Ny * Ny);
      if (Nz<0)
        Nz = 0;
      if (phong) {
        envMap[i+envMapSize*j] = AMB + min(255-AMB, (Nz*DIFFUSE+Nz*Nz*SPECULAR));//Phong = ambient + dif*dot + dot^2*spec
      } else {
        envMap[i+envMapSize*j] = Nz*256; 
      }
    }
  }
}

PImage bumpMapper(int lightX, int lightY) {
  PImage lookup_array = createImage(img.width, img.height, RGB);
  lookup_array.loadPixels();
  img.loadPixels();
  lightX +=128;
  lightY +=128;
  for (int i=0; i<img.width; i++) {
    for (int j=0; j<img.height; j++) {
      int nX = normal_x[i+img.width*j];
      int nY = normal_y[i+img.width*j];
      int lDistX = i-lightX;
      int lDistY = j-lightY;
      nX -= lDistX;
      nY -= lDistY;
      if (nX<0 || nX>=envMapSize)
        nX = 0;
      if (nY<0 || nY>=envMapSize)
        nY = 0;
      color imgColor = img.pixels[i+img.width*j];
      color nuColor = color(norm(envMap[nX+envMapSize*nY], 0, 255)*red(imgColor), norm(envMap[nX+envMapSize*nY], 0, 255)*green(imgColor), norm(envMap[nX+envMapSize*nY], 0, 255)*blue(imgColor));
      lookup_array.pixels[i+img.width*j] = nuColor;
    }
  }
  lookup_array.updatePixels();
  return lookup_array;
}
