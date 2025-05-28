public class UI {
  PVector position = new PVector(0, 0, 0);
  int forward = 100;
  
  public UI() {
    
  }
  
  public void update(PVector position, float turn, boolean[] TURN) {
    pushMatrix();
    translate(position.x + (cos(turn / (180 / PI)) * 100), position.y, position.z + (sin(turn / (180 / PI)) * 100));
    fill(100, 180, 100);
    rotateY(-1 * turn / (180/PI));
    rotateY(PI/2);
    rectMode(CENTER);
    if ((TURN[0] == true) && (TURN[1] == false)) {
      rotateY(PI/90);
      
      // UI
      rect(3.45, 0, 100, 20);
      circle(3.45, 0, 50);
      
      println(1222);
    }
    else if ((TURN[0] == false) && (TURN[1] == true)) {
      rotateY(-PI/90);
      
      // UI
      rect(-3.45, 0, 100, 20); 
      circle(-3.45, 0, 50);
      
    }
    else {
      
      // UI
      rect(0, 0, 100, 20);
      circle(0, 0, 50);
      
      
    }
    popMatrix();
  }
  
}
