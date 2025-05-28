public class UI {
  PVector position = new PVector(0, 0, 0);
  int forward = 100;
  
  PVector turnOffset = new PVector(0, 0);
  PVector wasdOffset = new PVector(0, 0);
  
  public UI() {
    
  }
  
  public void update(PVector position, float turn, boolean[] TURN, boolean[] WASD) {
    pushMatrix();
    translate(position.x + (cos(turn / (180 / PI)) * 80), position.y, position.z + (sin(turn / (180 / PI)) * 80));
    fill(100, 180, 100);
    rotateY(-1 * turn / (180/PI));
    rotateY(PI/2);
    rectMode(CENTER);
    
    if ((TURN[0] == true) && (TURN[1] == false)) {
      rotateY(PI/90);
      turnOffset.x = 2.60;
    }
    else if ((TURN[0] == false) && (TURN[1] == true)) {
      rotateY(-PI/90);
      turnOffset.x = -2.60;
    }
    else {
      turnOffset.x = 0; 
    }
    
    if (WASD[1] == true) {
      wasdOffset.x = 100;
      println(WASD[1]);
    }
    
    // UI
    rect(turnOffset.x, turnOffset.y, 100, 20);
    circle(turnOffset.x, turnOffset.y, 50);  
    
    popMatrix();
  }
  
}
