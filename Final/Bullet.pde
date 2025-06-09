public class Bullet {
  PVector dir;
  int speed = 15;
  PVector position;
  boolean players;
  boolean homing;
  
  String player;
  
  PVector target;
  int targetnumber;
  
  public Bullet(PVector pos, PVector velocity, boolean p, boolean homing, String player) {
    position = pos;
    dir = velocity.normalize();
    players = p;
    this.homing = homing;
    this.player = player;
    if (homing){
      targetnumber = 0;
      float minimum = new PVector(enemies.get(0).position.x - position.x, enemies.get(0).position.z - position.z).mag();
      for (int i = 1; i < enemies.size(); i ++){
        PVector temp = enemies.get(targetnumber).position;
        if (new PVector(temp.x - position.x, temp.z - position.z).mag() < minimum){
          minimum = new PVector(temp.x - position.x, temp.z - position.z).mag();
          targetnumber = i;
        }
      }
    }
  }
  
  boolean collision() {
    int xcor = round((position.x) / size);
    int ycor = round((position.z) / size);
    for (int x = -8; x < 9; x ++){
      for (int y = -8; y < 9; y ++){
        if (tilemap.tilemap()[round((position.x + x) / size)][round((position.z + y) / size)] > 0){
          return true;
        }
      }
    }
    
    if (homing == true) {
      if (enemies.get(targetnumber) != null){
        target = enemies.get(targetnumber).position;
        PVector temp = new PVector(target.x - position.x, target.z - position.z).normalize();
        dir.x = lerp(dir.x, temp.x, 0.08);
        dir.y = lerp(dir.y, temp.y, 0.08);
        println("target" + target);
      }
    }
    if (entitymap[xcor][ycor] != null) {
      if (player == "Tobber") entitymap[xcor][ycor].health -= 10;
      if (player == "Alvin") entitymap[xcor][ycor].health -= 35;
      return(true);
    }
    return false;
  }
}
