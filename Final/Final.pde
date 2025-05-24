

int size = 64;
int floor = 200;

Player player;
Tilemap tilemap;

void setup() {
  size(800, 450, P3D);
  
  player = new Player();
  tilemap = new Tilemap();
  
}

void draw() {
  background(120, 160, 200);
  PVector playerpos = player.position;
  float turn = player.turn;
  camera(playerpos.x, playerpos.y, playerpos.z, playerpos.x + cos(radians(turn)), playerpos.y, playerpos.z + sin(radians(turn)), 0, 1, 0);

  drawScene();
  player.movement();
}

void drawScene() {
  int[][] temp = tilemap.tilemap();
  pushMatrix();
  fill(100, 180, 100);
  translate(temp.length * size / 2, floor, temp[0].length * size / 2);
  rotateX(HALF_PI);
  rectMode(CENTER);
  rect(0, 0, size * temp.length, size * temp.length);
  popMatrix();
  for (int i = 0; i < temp.length; i++) {
    for (int j = 0; j < temp[i].length; j++) {
      for (int k = 0; k < temp[i][j]; k++) {
        pushMatrix();
        fill(255, 100, 100);
        translate(size * i, (floor - size / 2) - (k * size), size * j);
        box(size);
        popMatrix();
      }
    }
  }
  
}

void keyReleased(){
  player.release();
}

void keyPressed(){
  player.press();
}
