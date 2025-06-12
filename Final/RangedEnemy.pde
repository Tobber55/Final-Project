public class RangedEnemy extends Enemy {
  
  PImage img = loadImage("TemuBlaze.png");
  
  public RangedEnemy(PVector chunk) {
    super(chunk);
  }
  
  public void update() {
    
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
    img.resize(64, 64);
    popMatrix();
    
    
    if (inRange == true && playerinvis == 0) {
      if (cooldown <= 0) {
        float turn;
        if (temp.y > 0){
          turn = PI - asin(temp.x) + HALF_PI;
        } else {
          turn = -1 * (PI - asin(temp.x) + HALF_PI);       
        }
        //println(temp);
        Bullet bullet;
        bullet = new Bullet(new PVector(position.x + cos(turn) * 60, position.y + 30, position.z + sin(turn) * 60), new PVector(cos(turn), sin(turn)), true, false, "", 16, true);
        bullets.add(bullet);
        cooldown = 90;
      }
      velocity.x = 0;
      velocity.z = 0;
    }
    else if (playerinvis == 0 && dist(position.x, position.z, player.position.x, player.position.z) < size * 5) {
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
      
      enemies.remove(positionInArray);
    }
    
    inRange = inRange();
    
    //println(velocity);
    
  }
  
  boolean inRange() {
    for (int i = -10; i < 11; i++) {
      for (int j = -10; j < 11; j++) {
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
