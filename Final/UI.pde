public class UI {
  
  int forward = 50;
  
  float turnOffset = 0;
  PVector wasdOffset = new PVector(0, 0);
  
  public UI() {
    
  }
  
  public void update(PVector position, float turn, boolean[] TURN, boolean[] WASD) {
    pushMatrix();
    if (WASD[0] == true) {
      translate(position.x + (cos(turn / (180 / PI)) * forward) - forward / (90/PI), position.y, position.z + (sin(turn / (180 / PI)) * forward));
    }
    else {
      translate(position.x + (cos(turn / (180 / PI)) * forward), position.y, position.z + (sin(turn / (180 / PI)) * forward));
    }
    fill(100, 180, 100);
    rotateY(-1 * turn / (180/PI));
    rotateY(PI/2);
    rectMode(CENTER);
    
    if ((TURN[0] == true) && (TURN[1] == false)) {
      rotateY(PI/90);
      turnOffset = forward / (90/PI);
    }
    else if ((TURN[0] == false) && (TURN[1] == true)) {
      rotateY(-PI/90);
      turnOffset = -forward / (90/PI);
    }
    else {
      turnOffset = 0; 
    }
    
    if (WASD[1] == true) {
      wasdOffset.x = -forward / (90/PI);
    }
    else {
      wasdOffset.x = 0;
    }
    
    println(position.x + (cos(turn / (180 / PI)) * forward));
    
    // UI
    rect(turnOffset, 0, 20, 4);
    circle(turnOffset, 0, 10);  
    
    popMatrix();
  }
  
}
