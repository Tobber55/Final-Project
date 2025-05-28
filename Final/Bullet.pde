public class Bullet{
  PVector dir;
  int speed = 15;
  PVector position;
  boolean players;
  
  public Bullet(PVector pos, PVector velocity, boolean p){
    position = pos;
    dir = velocity.normalize();
    players = p;
  }
  
  boolean collision(){
    for (int x = -8; x < 9; x ++){
      for (int y = -8; y < 9; y ++){
        if (tilemap.tilemap()[round((position.x + x) / size)][round((position.z + y) / size)] > 0){
          return true;
        }
      }
    }
    return false;
  }
}
  
