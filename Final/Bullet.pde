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
    return tilemap.tilemap()[round(position.x)/size][round(position.z)/size] > 0;
  }
}
  
