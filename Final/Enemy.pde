public class Enemy {
  
  PVector position;
  PVector velocity = new PVector(0, 0, 0);
  
  int health = 100;
  
  int positionInArray = -1;
  
  int maxspeed = 2;
  int rotation = 0;
  
  PVector currentChunk;
  
  public Enemy(PVector chunk) {
    this.position = new PVector(chunk.x * size, 118, chunk.y * size);
    currentChunk = chunk;
  }
  
  public void update() {
    currentChunk();
    
    println(health);
    
    position.add(velocity);
    
    pushMatrix();
    fill(135, 70, 21);
    translate(position.x, position.y, position.z);
    rotateX(rotation);
    box(size);
    popMatrix();
    
    velocity.x = (player.position.x - position.x)/100;
    velocity.z = (player.position.z - position.z)/100;
    if (velocity.x > maxspeed) velocity.x = maxspeed;
    if (velocity.x * -1 < maxspeed * -1) velocity.x = -1 * maxspeed;
    if (velocity.z > maxspeed) velocity.z = maxspeed;
    if (velocity.z * -1 < maxspeed * -1) velocity.z = -1 * maxspeed;
    
    if (health <= 0) enemies.remove(positionInArray);
    
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
}

