public class Player{
  float turn = 0;
  float gravity = 0.4;
  float maxspeed = 1;
  PVector position = new PVector(0,0,0);
  PVector velocity = new PVector(0,0,0);
  boolean[] WASD = {false, false, false, false};
  boolean[] TURN = {false, false};
  int shootcool = 0;
  int powercool = 0;
  
  int ammo = 6;
  int health = 100;
  int armor = 100;
  
  String player = "";
  
  public Player(String player){
    position.x = tilemap.tilemap().length * size / 2;
    position.y = 100;
    position.z = tilemap.tilemap()[0].length * size / 2; 
    this.player = player;
  }
  
  void movement(){
    
    if (shootcool > 0){
      shootcool --;
    }
    
    if (powercool > 0){
      powercool --;
    }
    
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
      turn += 1.5;
    }
    if (TURN[1]) {
      turn -= 1.5;
    }
    
    if (WASD[0] || WASD[1] || WASD[2] || WASD[3]){
      PVector coords = currentChunk(position.x, position.z);
      //println(coords.x + " " + coords.y);
      int[][] temp = tilemap.tilemap();
      
      for (int i = -2; i < 2; i ++){
        if ((temp[(int)coords.x + 1][(int)coords.y + i] > 0 && velocity.x > 0) || (temp[(int)coords.x - 2][(int)coords.y + i] > 0) && velocity.x < 0){
          velocity.x = 0;
        }
      }
      for (int i = -2; i < 2; i ++){
        if ((temp[(int)coords.x + i][(int)coords.y - 2] > 0 && velocity.z < 0) || (temp[(int)coords.x + i][(int)coords.y + 1] > 0) && velocity.z > 0){
          velocity.z = 0;
        }
      }
    }
    else {
      velocity.x = 0;
      velocity.z = 0;
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
  
  void shoot(){
    if ((shootcool <= 0) && (ammo > 0)) {
      Bullet bullet = new Bullet(new PVector(position.x + cos(radians(turn)) * 60, position.y + 50, position.z + sin(radians(turn)) * 60), new PVector(cos(radians(turn)), sin(radians(turn))), true);
      bullets.add(bullet);
      ammo -= 1;
      shootcool = 60;
    }
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
      velocity.y = -10;
    }
    
    if (keyCode == UP && shootcool <= 0){
      shoot();
    }
    
    if (key == 'f' && powercool <= 0) {
      if (player == "Alvin") { ///////////////// MOGGING
        
        
      }
      else if (player == "Alex") { ///////////////// TIME STOP
        
        
      }
      else if (player == "Thamidur") { ///////////////// 
        
        
      }
      powercool = 150;
    }
    
  }
}
  
  
  
  
