public class UI {
  
  int forward = 50;
  
  float turnOffset = 0;
  PVector wasdOffset = new PVector(0, 0);
  
  public UI() {
    
  }
  
  public void update(PVector position, float turn, boolean[] TURN, boolean[] WASD) {
    camera();
    rect(0, 25, 125, 18);
    pushMatrix();
    
    translate(position.x + (cos(turn / (180 / PI)) * forward), position.y, position.z + (sin(turn / (180 / PI)) * forward));
    
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
    
    println(position.x + (cos(turn / (180 / PI)) * forward));
    
    // UI
    
    //fill(169, 169, 169);
    //rect(turnOffset, 25, 125, 18);
    
    //fill(129, 133, 137);
    //rect(turnOffset + 32, 25, 1, 18);
    //rect(turnOffset + 8, 25, 1, 18);
    //rect(turnOffset - 8, 25, 1, 18);
    //rect(turnOffset - 32, 25, 1, 18);
    
    //fill(0, 0, 0);
    //rect(turnOffset, 25, 15, 18);
    
    //fill(178, 190, 181, -30);
    //textSize(12);
    //text("word", 0, 0); 
    
    //circle(turnOffset, 0, 10);  
    
    popMatrix();
    
    
  }
  
}
