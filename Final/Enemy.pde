
public class Enemy {
  
  PVector position;
  PVector velocity = new PVector(0, 0, 0);
  
  int health = 100;
  
  int damage = 20;
  int cooldown = 0;
  
  int positionInArray = -1;
  
  int maxspeed = 2;
  int rotation = 0;
  
  PVector currentChunk;
  
  boolean inRange = false;
  
  public Enemy(PVector chunk) {
    this.position = new PVector(chunk.x * size, 118, chunk.y * size);
    currentChunk = chunk;
  }
  
  public void update() {
    
    if (cooldown > 0) cooldown -= 1;
    
    currentChunk();
    
    position.add(velocity);
    
    pushMatrix();
    fill(135, 70, 21);
    translate(position.x, position.y, position.z);
    rotateX(rotation);
    box(size);
    popMatrix();
    
    
    if (inRange == true) {
      if (cooldown <= 0) {
        player.health -= damage - (damage * ((player.armor/100) - 1)); 
        cooldown = 50;
      }
      velocity.x = 0;
      velocity.z = 0;
    }
    else {
      velocity.x = (player.position.x - position.x)/100;
      velocity.z = (player.position.z - position.z)/100;
    }
    
    if (velocity.x > maxspeed) velocity.x = maxspeed;
    if (velocity.x * -1 < maxspeed * -1) velocity.x = -1 * maxspeed;
    if (velocity.z > maxspeed) velocity.z = maxspeed;
    if (velocity.z * -1 < maxspeed * -1) velocity.z = -1 * maxspeed;
    
    if (health <= 0) {
      
      entitymap[(int)currentChunk.x][(int)currentChunk.y] = null;  ////////// Kills everything in that spot?
      
      enemies.remove(positionInArray);
    }
    
    
    println(currentChunk(player.position.x, player.position.z));
    
    for (int i = -1; i < 2; i++) {
      for (int j = -1; j < 2; j++) {
        if ((currentChunk(player.position.x, player.position.z).x == currentChunk.x + i) && (currentChunk(player.position.x, player.position.z).y == currentChunk.y + j)) {
          inRange = true;
          break;
        }
      }
    }
    
    //println(velocity);
    
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
  
