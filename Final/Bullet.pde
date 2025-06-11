public class Bullet {
  PVector dir;
  int speed = 15;
  PVector position;
  boolean players;

  boolean homing;
  
  String player;
  
  PVector target;
  int targetnumber;
  
  int range = -1;
  
  public Bullet(PVector pos, PVector velocity, boolean p, boolean homing, String player, int range) {
    position = pos;
    dir = velocity.normalize();
    players = p;
    this.homing = homing;
    this.player = player;
    if (player == "Aria") this.range = range;
    
    if (enemies.size() > 0 && homing){
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
    if (enemies.size() <= targetnumber) homing = false;
    for (int x = -8; x < 9; x ++){
      for (int y = -8; y < 9; y ++){
        int tempx = round((position.x + x) / size);
        int tempy = round((position.z + y) / size);
        if (tilemap.tilemap()[tempx][tempy] > 0 || entitymap[tempx][tempy] != null){
          if (entitymap[tempx][tempy] != null) {
            if (player == "Tobber") entitymap[tempx][tempy].health -= 15;
            if (player == "Alvin") entitymap[tempx][tempy].health -= 50;
            if (player == "Aria") entitymap[tempx][tempy].health -= 30;
          }
          return(true);
        }
      }
    }
    
    if (range == 0) return(true);
    else range -= 1;
    
    if (homing == true) {
      if (enemies.get(targetnumber) != null){
        target = enemies.get(targetnumber).position;
        PVector temp = new PVector(target.x - position.x, target.z - position.z).normalize();
        dir.x = lerp(dir.x, temp.x, 0.08);
        dir.y = lerp(dir.y, temp.y, 0.08);
      }
    }
    
    
    return(false);
  }
}
  
