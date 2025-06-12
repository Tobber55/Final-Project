public class Enemy {
  
  PVector position;
  PVector velocity = new PVector(0, 0, 0);
  
  int health = 100;
  
  int damage = 20;
  int cooldown = 0;
  
  int positionInArray = -1;
  
  float maxspeed = 2;
  int rotation = 0;
  
  PVector currentChunk;
  
  boolean inRange = false;
  
  PImage img = loadImage("TemuCthulhu.png");
  
  int playerinvis = 0;
  int timeslow = 0;
  
  public Enemy(PVector chunk) {
    this.position = new PVector(chunk.x * size, 108, chunk.y * size);
    currentChunk = chunk;
  }
  
  public void update() {
    
    if (timeslow > 0){
      timeslow --;
      maxspeed = 0.8;
    } else {
      maxspeed = 2;
    }

    if (cooldown > 0) cooldown -= 1;
    
    currentChunk();
    
    position.add(velocity);
    
    pushMatrix();
    translate(position.x, position.y, position.z);
    PVector temp = new PVector(position.x - player.position.x, position.z - player.position.z);
    temp.normalize();
    if (temp.y < 0) {
      if (temp.x >= 0) {
        rotateY(PI - asin(temp.x));
      } else {
        rotateY(abs(asin(temp.x)) + PI);
      }
    } else {
      if (temp.x >= 0) {
        rotateY(asin(temp.x));
      } else {
        rotateY(2 * PI + (asin(temp.x)));
      }
    }
    
    translate(-32, 0, 0);
    image(img, 0, 0);
    img.resize(80, 80);
    popMatrix();
    
    
    if (inRange == true && playerinvis == 0) {
      if (cooldown <= 0) {
        player.health -= damage - (damage * ((player.armor/100.0) - 1)); 
        cooldown = 50;
      }
      velocity.x = 0;
      velocity.z = 0;
    }
    else if (playerinvis == 0 && dist(position.x, position.z, player.position.x, player.position.z) < size * 10) {
      velocity.x = (player.position.x - position.x)/100;
      velocity.z = (player.position.z - position.z)/100;
    } else {
      if (playerinvis > 0){
        playerinvis --;
      }
      if (frameCount % 60 == 0){
        velocity.x = (random(200, 1700) - position.x)/100;
        velocity.z = (random(200, 1700) - position.z)/100;
      }
    }
    
    velocity.x = constrain(velocity.x, maxspeed * -1, maxspeed);
    velocity.z = constrain(velocity.z, maxspeed * -1, maxspeed);

    
    if (health <= 0) {
      
      entitymap[(int)currentChunk.x][(int)currentChunk.y] = null;  ////////// Kills everything in that spot?
      if (random(1) > 0.2){
        int[][] map = tilemap.map;
        map[round(currentChunk.x)][round(currentChunk.y)] = -1;
        PVector tempvector = new PVector(round(currentChunk.x), round(currentChunk.y));
        Ammo ammo = new Ammo(tempvector);
        if (random(1) < 0.6){
          ammo.powerup = "ammo";
        } else if (random(1) < 0.5){
          ammo.powerup = "health";
          ammo.img = loadImage("health.png");
        } else {
          ammo.powerup = "armor";
          ammo.img = loadImage("sheild.png");
        }
        ammos.add(ammo);
      }
      enemies.remove(positionInArray);
    }
    
    inRange = inRange();
    
    //println(velocity);
    
  }
  
  boolean inRange() {
    for (int i = -1; i < 2; i++) {
      for (int j = -1; j < 2; j++) {
        if ((currentChunk(player.position.x, player.position.z).x == currentChunk.x + i) && (currentChunk(player.position.x, player.position.z).y == currentChunk.y + j)) {
          return(true);
        }
      }
    }
    return(false);
  }
  
  void currentChunk() {
    int xcor = 0;
    int ycor = 0;
    for (int i = 0; i < position.x; i += size) {
      xcor += 1;
    }
    for (int i = 0; i < position.z; i += size) {
      ycor += 1;
    }
    //println(xcor + " " + ycor);
    
    PVector chunk = new PVector(xcor, ycor);
    
    if (chunk != currentChunk) {
      entitymap[(int)currentChunk.x][(int)currentChunk.y] = null;
      entitymap[(int)chunk.x][(int)chunk.y] = this;
      currentChunk = chunk;
    }
  }
  
  PVector currentChunk(float posx, float posz){
    int xcor = 0;
    int ycor = 0;
    for (int i = 0; i < posx; i += size) {
      xcor += 1;
    }
    for (int i = 0; i < posz; i += size) {
      ycor += 1;
    }
    //println(xcor + " " + ycor);
    return(new PVector(xcor, ycor));
  }
}
