int size = 80;
int floor = 200;

ArrayList<Bullet> bullets = new ArrayList<Bullet>();

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
  

  enemies.add(new Enemy(new PVector(5, 4)));
  enemies.add(new Enemy(new PVector(19, 5)));
  enemies.add(new Enemy(new PVector(11, 7)));
  enemies.add(new Enemy(new PVector(5, 10)));
  enemies.add(new Enemy(new PVector(10, 10)));
  
  enemies.add(new Enemy(new PVector(16, 10)));
  enemies.add(new Enemy(new PVector(6, 13)));
  enemies.add(new Enemy(new PVector(10, 15)));
  enemies.add(new Enemy(new PVector(19, 16)));
  enemies.add(new Enemy(new PVector(12, 18)));
  
  enemies.add(new Enemy(new PVector(53, 16)));
  enemies.add(new Enemy(new PVector(51, 19)));
  enemies.add(new Enemy(new PVector(11, 32)));
  enemies.add(new Enemy(new PVector(5, 38)));
  enemies.add(new Enemy(new PVector(18, 35)));
  
  enemies.add(new Enemy(new PVector(57, 32)));
  enemies.add(new Enemy(new PVector(58, 36)));
  enemies.add(new Enemy(new PVector(54, 40)));
  enemies.add(new Enemy(new PVector(43, 41)));
  enemies.add(new Enemy(new PVector(35, 41)));
  
  enemies.add(new Enemy(new PVector(7, 57)));
  enemies.add(new Enemy(new PVector(16, 55)));
  enemies.add(new Enemy(new PVector(24, 54)));
  
  enemies.add(new RangedEnemy(new PVector(5, 27)));
  enemies.add(new RangedEnemy(new PVector(53, 5)));
  enemies.add(new RangedEnemy(new PVector(59, 8)));
  enemies.add(new RangedEnemy(new PVector(47, 10)));
  enemies.add(new RangedEnemy(new PVector(32, 12)));
  
  enemies.add(new RangedEnemy(new PVector(36, 16)));
  enemies.add(new RangedEnemy(new PVector(46, 16)));
  enemies.add(new RangedEnemy(new PVector(60, 17)));
  enemies.add(new RangedEnemy(new PVector(39, 29)));
  enemies.add(new RangedEnemy(new PVector(31, 38)));
  
  enemies.add(new RangedEnemy(new PVector(28, 41)));
  enemies.add(new RangedEnemy(new PVector(30, 45)));

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
  

  

  if (startscreen == false && player.health > 0 && enemies.size() != 0) {
    background(120, 160, 200);
    drawScene();
    player.movement();
    ui.update(player);
  }
  else if (player.health <= 0) {
    ui.uiEnd();
  }
  else if (enemies.size() == 0) {
    ui.winScreen();
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
        fill(103, 103, 103);
        translate(size * i, (floor - size / 2) - (k * size), size * j);
        box(size);
        popMatrix();
      }
    }
  }
  
  for (int i = 0; i < enemies.size(); i++) {
    enemies.get(i).positionInArray = i;
  }
    
    for (int i = 0; i < bullets.size(); i ++){
      Bullet bullet = bullets.get(i);

      bullet.playerr = player;

      if (bullet.collision()) bullets.remove(i); 
      if (bullet.enemy && player.player == "Aria" && player.powercool > 1900){
        bullet.position.x += bullet.dir.x * bullet.speed * 0.08;
        bullet.position.z += bullet.dir.y * bullet.speed * 0.08;
      } else {
        bullet.position.x += bullet.dir.x * bullet.speed;
        bullet.position.z += bullet.dir.y * bullet.speed;
      }
      if (player.player != "Aria" || bullet.enemy) {
        pushMatrix();

        if (bullet.enemy) fill(255, 0, 0);
        else fill(0, 0, 0);
  
        translate(bullet.position.x, bullet.position.y, bullet.position.z);
  
        sphere(8);

        popMatrix();
      }
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

        if (ammos.get(i).powerup == "ammo"){
          if (player.player != "Aria") player.allammo += player.maxammo;
          else player.ammo = player.maxammo;
          tilemap.map[int(ammos.get(i).currentChunk.x)][int(ammos.get(i).currentChunk.y)] = 0;
          ammos.remove(i);
        } else if (ammos.get(i).powerup == "health"){
          if (player.health < 100){
            player.health = min(100, player.health + 10);
            tilemap.map[int(ammos.get(i).currentChunk.x)][int(ammos.get(i).currentChunk.y)] = 0;
            ammos.remove(i);
          }
        } else if (ammos.get(i).powerup == "armor"){
          player.armor += 5;
          tilemap.map[int(ammos.get(i).currentChunk.x)][int(ammos.get(i).currentChunk.y)] = 0;
          ammos.remove(i);
        }
        
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
