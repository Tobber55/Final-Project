public class Bullet {
  PVector velocity = new PVector(0, 0);
  int speed = 10;
  PVector position = new PVector(0, 0, 0);
  int size = 50;
  
  public Bullet(PVector pos, PVector vel) {
    position = pos;
    velocity = vel;
    
    //noStroke();
    pushMatrix();
    lights();
    translate(position.x, position.y, position.z);
    sphere(size);
    popMatrix();
  }
  
  public void update() {
    
    //position.x += 1;
    
    pushMatrix();
    lights();
    translate(position.x, position.y, position.z);
    sphere(size);
    popMatrix();
    
    //translate(position.x, position.y, position.z);
    //sphere(size);
    
    
    
  }
  
  
}
