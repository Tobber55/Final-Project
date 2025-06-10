
int size = 64;
int floor = 200;

ArrayList<Bullet> bullets = new ArrayList<Bullet>();
ArrayList<Bullet> enemybullets = new ArrayList<Bullet>();

ArrayList<Ammo> ammos = new ArrayList<Ammo>();
ArrayList<Enemy> enemies = new ArrayList<Enemy>();

boolean startscreen = true;

Player player;
Tilemap tilemap;
Enemy[][] entitymap;

UI ui;

void setup() {
  size(800, 450, P3D);
  
  tilemap = new Tilemap();

  entitymap = new Enemy[tilemap.tilemap().length][tilemap.tilemap().length];
  player = new Player();
  ui = new UI();
  
  enemies.add(new Enemy(new PVector(20, 24)));
  
  int[][] map = tilemap.tilemap();
  for (int x = 0; x < map.length; x ++) {
    for (int y = 0; y < map[0].length; y ++){
      if (map[x][y] == -1){
        PVector temp = new PVector(x, y);
        ammos.add(new Ammo(temp));
      }
    }
  }
}

void draw() {
  
  if (player.turn > 360) {
    player.turn = 0;
  }
  if (player.turn < -360) {
    player.turn = 0;
  }
  
  PVector playerpos = player.position;
  float turn = player.turn;
  camera(playerpos.x, playerpos.y, playerpos.z, playerpos.x + cos(radians(turn)), playerpos.y, playerpos.z + sin(radians(turn)), 0, 1, 0);
  

  
  if (startscreen == false) {
    background(120, 160, 200);
    drawScene();
    player.movement();
    ui.update(player);
  }
  else {
    ui.uiStart();
  }

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
  
  for (int i = 0; i < enemies.size(); i++) {
    enemies.get(i).positionInArray = i;
  }
  
  for (int j = 0; j < entitymap.length; j++) {
      for (int k = 0; k < entitymap[j].length; k++) {
        if (entitymap[j][k] != null) {
        //  pushMatrix();
        //  fill(255, 100, 100);
        //  translate(size * j, (floor - size / 2), size * k);
        //  println(new PVector(size * j, (floor - size / 2), size * k));
        //  box(size);
        //  popMatrix();
          println(j + " " + k);
        }
      }
    }
    
    for (int i = 0; i < bullets.size(); i ++){
      Bullet bullet = bullets.get(i);
      if (bullet.collision()) bullets.remove(i); 
      bullet.position.x += bullet.dir.x * bullet.speed;
      bullet.position.z += bullet.dir.y * bullet.speed;
      pushMatrix();
      fill(0, 0, 0);

      translate(bullet.position.x, bullet.position.y, bullet.position.z);

      sphere(size/8);
      popMatrix();
    }
    
    
    for (int i = 0; i < enemies.size(); i++) {
      enemies.get(i).update();
      
    }
    
    
    for (int i = 0; i < ammos.size(); i ++){
      pushMatrix();
      //println(ammos.get(i).currentChunk.x + " " + ammos.get(i).currentChunk.y);
      translate(size * ammos.get(i).currentChunk.x, 100, size * ammos.get(i).currentChunk.y);
      rotateY(frameCount * 0.05);
      translate(-32, 0, 0);
      image(ammos.get(i).img, 0, 0);
      ammos.get(i).img.resize(64, 64);
      popMatrix();

      //println(ammos.get(i).currentChunk + " " + player.currentChunk(player.positHThamidurion.x, player.position.z));
      if (abs(ammos.get(i).currentChunk.x - player.currentChunk(player.position.x, player.position.z).x) <= 1 &&
      abs(ammos.get(i).currentChunk.y - player.currentChunk(player.position.x, player.position.z).y) <= 1){
        player.allammo += player.maxammo;
        tilemap.map[int(ammos.get(i).currentChunk.x)][int(ammos.get(i).currentChunk.y)] = 0;
        ammos.remove(i);
      }
    }
  
}

void keyReleased(){
  if (startscreen == false) player.release();
}

void keyPressed(){
  if (startscreen == false) player.press();
}

void mousePressed() {
  if (startscreen == true) startscreen = ui.readInput(new PVector(mouseX, mouseY), player);

}
