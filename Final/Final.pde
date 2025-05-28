
int size = 64;
int floor = 200;

ArrayList<Bullet> bullets = new ArrayList<Bullet>();

Player player;
Tilemap tilemap;
UI ui;

void setup() {
  size(800, 450, P3D);
  
  tilemap = new Tilemap();
  player = new Player();
  ui = new UI();
}

void draw() {
  
  if (turn > 360) {
    turn = 0;
  }
  if (turn < -360) {
    turn = 0;
  }
  
  
  background(120, 160, 200);
  PVector playerpos = player.position;
  float turn = player.turn;
  camera(playerpos.x, playerpos.y, playerpos.z, playerpos.x + cos(radians(turn)), playerpos.y, playerpos.z + sin(radians(turn)), 0, 1, 0);

  drawScene();
  player.movement();
  ui.update(position, turn, TURN);
  
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
    for (int i = 0; i < bullets.size(); i ++){
    Bullet bullet = bullets.get(i);
    bullet.position.x += bullet.dir.x * bullet.speed;
    bullet.position.z += bullet.dir.y * bullet.speed;
    pushMatrix();
    fill(0, 0, 0);
    translate(bullet.position.x, 100, bullet.position.z);
    sphere(size/8);
    popMatrix();
    if (bullet.collision()) bullets.remove(i);
    }
  
}

void keyReleased(){
  player.release();
}

void keyPressed(){
  player.press();
}
