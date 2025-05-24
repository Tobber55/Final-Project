public class Bullet {
  PVector velocity = new PVector(0, 0);
  int speed = 10;
  PVector position = new PVector(0, 0, 0);
  int size = 112;
  
  public Bullet(PVector pos, PVector vel) {
    position = pos;
    velocity = vel;
    
    //noStroke();
    lights();
    translate(position.x, position.y, position.z);
    sphere(size);
    
  }
  
  //void draw() {
    
  //  noStroke();
  //  lights();
  //  translate(position.x, position.y, position.z);
  //  sphere(size);
    
    
  //}
  
  
  
}
