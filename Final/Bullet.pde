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
      if (target == null) {
        for (int k = 1; k < 10; k++) {
          for (int i = -1 * k; i < k + 1; i++) {
            for (int j = -1 * k; j < k + 1; j++) {
              if (ycor + i < entitymap.length && ycor + i >= 0 && xcor + j < entitymap[0].length && xcor + j >= 0) {
                if (entitymap[ycor + i][xcor + j] > 0) {
                  target = new PVector(xcor + j, ycor + i);
                }
              }
            }
          }
        }
      }
      else {
        PVector temp = new PVector(target.x - position.x, target.y - position.z).normalize();
        println(temp.x + " " + temp.y);
        dir.x = lerp(dir.x, temp.x, 0.08);
        dir.y = lerp(dir.y, temp.y, 0.08);
      }
    }
    if (entitymap[xcor][ycor] > 0) return(true);
    return false;
  }
}
  
