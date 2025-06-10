public class Enemy {

  PVector position;
  PVector velocity = new PVector(0, 0, 0);

  int maxspeed = 1;
  int rotation = 0;

  PVector currentChunk;

  PImage img = loadImage("ammo.png");

  public Enemy(PVector chunk) {
    this.position = new PVector(chunk.x * size, 118, chunk.y * size);
    currentChunk = chunk;
  }

  public void update() {
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

    velocity.x = (player.position.x - position.x)/100;
    velocity.z = (player.position.z - position.z)/100;
    if (velocity.x > maxspeed) velocity.x = maxspeed;
    if (velocity.x * -1 < maxspeed * -1) velocity.x = -1 * maxspeed;
    if (velocity.z > maxspeed) velocity.z = maxspeed;
    if (velocity.z * -1 < maxspeed * -1) velocity.z = -1 * maxspeed;

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
      entitymap[(int)currentChunk.x][(int)currentChunk.y] -= 1;
      entitymap[(int)chunk.x][(int)chunk.y] += 1;
      currentChunk = chunk;
    }
  }
}
