
float turn = 0;

float gravity = 0.02;
float friction = 0.01;


float maxspeed = 1;

int size = 64;

int floor = 200;

int[][] tilemap = new int[32][32];

PVector position = new PVector(0,0,0);
PVector velocity = new PVector(0,0,0);


void setup() {
  size(800, 450, P3D);
  position.x = tilemap.length * size / 2;
  position.y = 100;
  position.z = tilemap[0].length * size / 2; 

  for (int i = 0; i < tilemap.length; i++) {
    for (int j = 0; j < tilemap[i].length; j++) {
      if ((i == 0) || i == tilemap.length - 1) {
        tilemap[i][j] = 5;
      }
      if ((j == 0) || j == tilemap[i].length - 1) {
        tilemap[i][j] = 5;
      }
      print(tilemap[i][j] + " ");
    }
    println();
  }
  tilemap[9][14] = 5;
  tilemap[10][14] = 5;
  tilemap[12][10] = 5;
}

void draw() {
  background(120, 160, 200);
  
  position.add(velocity);
  
  if (velocity.x > maxspeed) {
    velocity.x = maxspeed;
  }
  if (velocity.x < -1 * maxspeed) {
    velocity.x = -1 * maxspeed;
  }
  if (velocity.z > maxspeed) {
    velocity.z = maxspeed;
  }
  if (velocity.z < -1 * maxspeed) {
    velocity.z = -1 * maxspeed;
  }
  
  
  
  if (position.y >= 100) {
    position.y = 100;
    velocity.y = 0;
  }
  else if ((velocity.y < 0) || (position.y < 100)) {
    velocity.y += gravity;
  }
  
  camera(position.x, position.y, position.z, position.x + cos(radians(turn)), position.y, position.z + sin(radians(turn)), 0, 1, 0);

  drawScene();
  handleMovement();
  
  //println(velocity.z);
}

void drawScene() {
  
  
  pushMatrix();
  fill(100, 180, 100);
  translate(tilemap.length * size / 2, floor, tilemap[0].length * size / 2);
  rotateX(HALF_PI);
  rectMode(CENTER);
  rect(0, 0, size * tilemap.length, size * tilemap.length);
  popMatrix();


  //pushMatrix();
  //fill(255, 100, 100);
  //translate(0, 150, 0);
  //box(32);
  //popMatrix();
  //pushMatrix();
  //fill(255, 100, 100);
  //translate(0, 0, 0);
  //box(32);
  //popMatrix();
  
  updateMap();
  
  //popMatrix();
}

void updateMap() {
  for (int i = 0; i < tilemap.length; i++) {
    for (int j = 0; j < tilemap[i].length; j++) {
      for (int k = 0; k < tilemap[i][j]; k++) {
        pushMatrix();
        fill(255, 100, 100);
        translate(size * i, (floor - size / 2) - (k * size), size * j);
        box(size);
        popMatrix();
      }
    }
  }
}

PVector currentChunk() {
  int xcor = 0;
  int ycor = 0;
  for (int i = 0; i < position.x; i += size) {
    xcor += 1;
  }
  for (int i = 0; i < position.z; i += size) {
    ycor += 1;
  }
  println(xcor + " " + ycor);
  return(new PVector(xcor, ycor));
}

void handleMovement() {
  if (keyPressed) {
    if (key == 'w') {
      velocity.x += cos(radians(turn)) * 2;
      velocity.z += sin(radians(turn)) * 2;
    }
    if (key == 's') {
      velocity.x -= cos(radians(turn)) * 2;
      velocity.z -= sin(radians(turn)) * 2;
    }
    if (key == 'a') {
      velocity.x += sin(radians(turn)) * 2;
      velocity.z -= cos(radians(turn)) * 2;
    }
    if (key == 'd') {
      velocity.x -= sin(radians(turn)) * 2;
      velocity.z += cos(radians(turn)) * 2;
    }
    if (keyCode == RIGHT) {
      turn += 2;
    }
    if (keyCode == LEFT) {
      turn -= 2;
    }
    if (key == ' ' && position.y == 100) {
      velocity.y -= 1;
    }
    
    if (((currentChunk().x + 1 >= tilemap.length) && (velocity.x > 0)) || ((currentChunk().x - 1 <= 0) && (velocity.x < 0))) velocity.x = 0;
    if (((currentChunk().y + 1 >= tilemap[0].length) && (velocity.z > 0)) || ((currentChunk().y - 1 <= 0) && (velocity.z < 0))) velocity.z = 0;
    
    //println(velocity.z);
    
    if ((((tilemap[(int)currentChunk().x + 1][(int)currentChunk().y] > 0) || (tilemap[(int)currentChunk().x + 1][(int)currentChunk().y - 1] > 0) || (tilemap[(int)currentChunk().x + 1][(int)currentChunk().y - 2] > 0) || (tilemap[(int)currentChunk().x + 1][(int)currentChunk().y + 1] > 0)) && (velocity.x > 0))
    || (((tilemap[(int)currentChunk().x - 2][(int)currentChunk().y] > 0) || (tilemap[(int)currentChunk().x - 2][(int)currentChunk().y - 1] > 0) || (tilemap[(int)currentChunk().x - 2][(int)currentChunk().y - 2] > 0) || (tilemap[(int)currentChunk().x - 2][(int)currentChunk().y + 1] > 0)) && (velocity.x < 0))) velocity.x = 0;   //// DOESNT CLIP IN. DOESNT SLIDE
    if ((((tilemap[(int)currentChunk().x][(int)currentChunk().y - 2] > 0) || (tilemap[(int)currentChunk().x - 1][(int)currentChunk().y - 2] > 0) || (tilemap[(int)currentChunk().x - 2][(int)currentChunk().y - 2] > 0) || (tilemap[(int)currentChunk().x + 1][(int)currentChunk().y - 2] > 0)) && (velocity.z < 0))
    || (((tilemap[(int)currentChunk().x][(int)currentChunk().y + 1] > 0) || (tilemap[(int)currentChunk().x - 1][(int)currentChunk().y + 1] > 0) || (tilemap[(int)currentChunk().x - 2][(int)currentChunk().y + 1] > 0) || (tilemap[(int)currentChunk().x + 1][(int)currentChunk().y + 1] > 0)) && (velocity.z > 0))) velocity.z = 0;
    
    //if (((tilemap[(int)currentChunk().x + 1][(int)currentChunk().y] > 0) && (velocity.x > 0)) || ((tilemap[(int)currentChunk().x + 1][(int)currentChunk().y - 1] > 0) && (velocity.x > 0))
    //|| ((tilemap[(int)currentChunk().x - 2][(int)currentChunk().y] > 0) && (velocity.x < 0)) || ((tilemap[(int)currentChunk().x - 2][(int)currentChunk().y - 1] > 0) && (velocity.x < 0))) velocity.x = 0;    ////////  DOESNT CLIP IN BUT CAN SOMETIMES. SLIDES
    //if (((tilemap[(int)currentChunk().x][(int)currentChunk().y - 2] > 0) && (velocity.z < 0)) || ((tilemap[(int)currentChunk().x - 1][(int)currentChunk().y - 2] > 0) && (velocity.z < 0))
    //|| ((tilemap[(int)currentChunk().x][(int)currentChunk().y + 1] > 0) && (velocity.z > 0)) || ((tilemap[(int)currentChunk().x - 1][(int)currentChunk().y + 1] > 0) && (velocity.z > 0))) velocity.z = 0;
    
    //if (((tilemap[(int)currentChunk().x][(int)currentChunk().y] > 0) && (velocity.x > 0)) || ((tilemap[(int)currentChunk().x][(int)currentChunk().y - 1] > 0) && (velocity.x > 0))
    //|| ((tilemap[(int)currentChunk().x - 1][(int)currentChunk().y] > 0) && (velocity.x < 0)) || ((tilemap[(int)currentChunk().x - 1][(int)currentChunk().y - 1] > 0) && (velocity.x < 0))) velocity.x = 0;  /// CLIP IN COLLISIONS. DOESNT SLIDE
    //if (((tilemap[(int)currentChunk().x][(int)currentChunk().y - 1] > 0) && (velocity.z < 0)) || ((tilemap[(int)currentChunk().x - 1][(int)currentChunk().y - 1] > 0) && (velocity.z < 0))
    //|| ((tilemap[(int)currentChunk().x][(int)currentChunk().y] > 0) && (velocity.z > 0)) || ((tilemap[(int)currentChunk().x - 1][(int)currentChunk().y] > 0) && (velocity.z > 0))) velocity.z = 0;
  }
  else {
    velocity.x = 0;
    velocity.z = 0;
  }
}
