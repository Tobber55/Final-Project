public class Bullet{
  PVector dir;
  int speed = 15;
  PVector position;
  boolean players;

  boolean homing;
  
  PVector target;
  
  public Bullet(PVector pos, PVector velocity, boolean p, boolean homing){
    position = pos;
    dir = velocity.normalize();
    players = p;
    this.homing = homing;
  }
  
  boolean collision(){
    int xcor = round((position.x) / size);
    int ycor = round((position.z) / size);
    for (int x = -8; x < 9; x ++){
      for (int y = -8; y < 9; y ++){
        if (tilemap.tilemap()[round((position.x + x) / size)][round((position.z + y) / size)] > 0){
          return true;
        }
      }
    }

    target = new PVector(20 * size, 24 * size);
    PVector temp = new PVector(target.x - position.x, target.z - position.y).normalize();
    if (homing == true){
      dir.x = lerp(dir.x, temp.x, 0.5);
      dir.z = lerp(dir.z, temp.y, 0.5);
    }
    
    //if (homing == true) {
    //  if (target == null) {
    //    for (int k = 1; k < 10; k++) {
    //      for (int i = -1 * k; i < k + 1; i++) {
    //        for (int j = -1 * k; j < k + 1; j++) {
    //          if (ycor + i < entitymap.length && ycor + i >= 0 && xcor + j < entitymap[0].length && xcor + j >= 0) {
    //            if (entitymap[ycor + i][xcor + j] > 0) {
    //              target = new PVector(xcor + j, ycor + i);
    //            }
    //          }
    //        }
    //      }
    //    }
    //  }
    //  else {
    //    if (target.y > xcor) dir.x += (0.02 + 0.1 - ((target.y - xcor) * 0.01));
    //    if (target.y < xcor) dir.x -= (0.02 + 0.1 - ((target.y - xcor) * -0.01));
    //    if (target.x > ycor) dir.y += (0.02 + 0.1 - ((target.x - ycor) * 0.01));
    //    if (target.x < ycor) dir.y -= (0.02 + 0.1 - ((target.y - xcor) * -0.01));
        
    //    if (target.x == ycor && target.y == xcor) return(true);
    //  }
      
    //}

    return false;
  }
}
  
