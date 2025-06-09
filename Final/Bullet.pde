public class Bullet {
  PVector dir;
  int speed = 15;
  PVector position;
  boolean players;

  boolean homing;
  
  PVector target;
  
  public Bullet(PVector pos, PVector velocity, boolean p, boolean homing) {
    position = pos;
    dir = velocity.normalize();
    players = p;
    this.homing = homing;
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
      int enemytarget = -1;
      for (int i = 0; i < enemies.size(); i ++){
        
      }
      PVector temp = new PVector(target.x - position.x, target.y - position.z).normalize();
      dir.x = lerp(dir.x, temp.x, 0.08);
      dir.y = lerp(dir.y, temp.y, 0.08);
    }
    if (entitymap[xcor][ycor] > 0) return(true);
    return false;
  }
}
  
