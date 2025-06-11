
public class Bullet {
  PVector dir;
  int speed = 15;
  PVector position;
  
  Player playerr;
  
  boolean players;

  boolean homing;
  
  String player;
  
  PVector target;
  int targetnumber;
  
  int range = -1;
  
  boolean enemy;
  
  public Bullet(PVector pos, PVector velocity, boolean p, boolean homing, String player, int range, boolean enemy) {

    position = pos;
    dir = velocity.normalize();
    players = p;
    this.homing = homing;
    this.player = player;

    if (player == "Aria") this.range = range;
    
    if (enemies.size() > 0 && homing){
      targetnumber = 0;
      float minimum = dist(enemies.get(0).position.x, enemies.get(0).position.z, position.x, position.z);
      for (int i = 1; i < enemies.size(); i ++){
        PVector temp = enemies.get(targetnumber).position;
        if (dist(temp.x, temp.z, position.x, position.z) < minimum){
          minimum = dist(temp.x, temp.z, position.x, position.z);

          targetnumber = i;
        }
      }
    }
  }
  
  boolean collision() {

    if (enemies.size() <= targetnumber) homing = false;
    for (int x = -8; x < 9; x ++){
      for (int y = -8; y < 9; y ++){
        int tempx = round((position.x + x) / size);
        int tempy = round((position.z + y) / size);
        if (tilemap.tilemap()[tempx][tempy] > 0 || entitymap[tempx][tempy] != null){
          if (entitymap[tempx][tempy] != null) {
            if (player == "Tobber") entitymap[tempx][tempy].health -= 15;
            if (player == "Shadow") entitymap[tempx][tempy].health -= 50;
            if (player == "Aria") entitymap[tempx][tempy].health -= 30;
          }
          return(true);
        }
      }
    }
    
    if (range == 0) return(true);
    else range -= 1;
    
    if (homing == true) {
      if (enemies.get(targetnumber) != null){
        target = enemies.get(targetnumber).position;
        PVector temp = new PVector(target.x - position.x, target.z - position.z).normalize();
        dir.x = lerp(dir.x, temp.x, 0.08);
        dir.y = lerp(dir.y, temp.y, 0.08);
      }
    }
    

    if (enemy == false) {
      if (entitymap[xcor][ycor] != null) {
        if (player == "Tobber") entitymap[xcor][ycor].health -= 15;
        if (player == "Alvin") entitymap[xcor][ycor].health -= 50;
        if (player == "Aria") entitymap[xcor][ycor].health -= 30;
        return(true);
      }
    }
    else {
      println(xcor + ", " + currentChunk(playerr.position.x, playerr.position.y).x);
      if (xcor == currentChunk(playerr.position.x, playerr.position.y).x && ycor == currentChunk(playerr.position.x, playerr.position.y).y) {
        playerr.health -= 20 - (20 * ((playerr.armor/100) - 1)); 
      }
    }
    return(false);
  }
  
  PVector currentChunk(float posx, float posz){
    int xcor = 0;
    int ycor = 0;
    for (int i = 0; i < posx; i += size) {
      xcor += 1;
    }
    for (int i = 0; i < posz; i += size) {
      ycor += 1;
    }
    //println(xcor + " " + ycor);
    return(new PVector(xcor, ycor));
  }
}
    
    return(false);
  }
}
  
