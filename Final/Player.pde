public class Player{
  float turn = 0;
  float gravity = 0.4;
  float friction = 0.01;  
  float maxspeed = 1;
  PVector position = new PVector(0,0,0);
  PVector velocity = new PVector(0,0,0);
  boolean[] WASD = {false, false, false, false};
  boolean[] TURN = {false, false};
  Tilemap tilemap = new Tilemap();
  
  public Player(){
    position.x = tilemap.length * size / 2;
    position.y = 100;
    position.z = tilemap[0].length * size / 2; 
  }
  
  void movement(){
    position.add(velocity);
  
    velocity.x = constrain(velocity.x, -1 * maxspeed, maxspeed);
    velocity.z = constrain(velocity.z, -1 * maxspeed, maxspeed);
    
    if (position.y >= 100) {
      position.y = 100;
      velocity.y = 0;
    }
    else if ((velocity.y < 0) || (position.y < 100)) {
      velocity.y += gravity;
    }
    
    if (WASD[0]) {
      velocity.x += cos(radians(turn)) * 2;
      velocity.z += sin(radians(turn)) * 2;
    }
    if (WASD[2]) {
      velocity.x -= cos(radians(turn)) * 2;
      velocity.z -= sin(radians(turn)) * 2;
    }
    if (WASD[1]) {
      velocity.x += sin(radians(turn)) * 2;
      velocity.z -= cos(radians(turn)) * 2;
    }
    if (WASD[3]) {
      velocity.x -= sin(radians(turn)) * 2;
      velocity.z += cos(radians(turn)) * 2;
    }
    
    if (TURN[0]) {
      turn += 2;
    }
    if (TURN[1]) {
      turn -= 2;
    }
    
    if (WASD[0] || WASD[1] || WASD[2] || WASD[3]){
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
  
  PVector currentChunk() {
    int xcor = 0;
    int ycor = 0;
    for (int i = 0; i < position.x; i += size) {
      xcor += 1;
    }
    for (int i = 0; i < position.z; i += size) {
      ycor += 1;
    }
    //println(xcor + " " + ycor);
    return(new PVector(xcor, ycor));
  }
  
  void release(){
    if (key == 'w'){
      WASD[0] = false;
    }
    if (key == 'a'){
      WASD[1] = false;
    }
    if (key == 's'){
      WASD[2] = false;
    }
    if (key == 'd'){
      WASD[3] = false;
    }
    if (keyCode == RIGHT) {
        TURN[0] = false;
      }
    if (keyCode == LEFT) {
        TURN[1] = false;
    }
  }
  
  void press(){
    if (key == 'w'){
      WASD[0] = true;
    }
    if (key == 'a'){
      WASD[1] = true;
    }
    if (key == 's'){
      WASD[2] = true;
    }
    if (key == 'd'){
      WASD[3] = true;
    }
    if (keyCode == RIGHT) {
        TURN[0] = true;
    }
    if (keyCode == LEFT) {
        TURN[1] = true;
    }
    if (key == ' ' && position.y == 100) {
      velocity.y = -20;
    }
  }
  
  
  
  
