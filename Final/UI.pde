public class UI {
  
  int forward = 50;
  
  float turnOffset = 0;
  PVector wasdOffset = new PVector(0, 0);
  
  PImage img = loadImage("Sze.png");
  
  public UI() {
    
  }
  
  public void update(Player player) {
    camera();
    translate(width / 2, height / 2, 325);
    
    fill(120,120,120);
    rect(0, 30, 155, 18);
    
    fill(129, 133, 137);
    rect(turnOffset + 42, 30, 1, 18);
    rect(turnOffset + 10, 30, 1, 18);
    rect(turnOffset - 10, 30, 1, 18);
    rect(turnOffset - 42, 30, 1, 18);
    
    fill(0, 0, 0);
    rect(turnOffset, 30, 19, 18);
    
    fill(178, 190, 181);
    textSize(128);
    textMode(MODEL);
    scale(0.042, 0.032);
    text("AMMO", -1480, 1125); 
    text("HEALTH", -850, 1125); 
    text("ARMOR", 420, 1125); 
    text("ARMS", 1150, 1125); 
    
    fill(175, 0, 0);
    scale(1/0.042, 1/0.032);
    scale(0.095, 0.07);
    
    text(player.ammo, -610, 440); 
    if (player.health >= 100) text(player.health + "%", -420, 440); //// CENTER
    else if ((player.health < 100) && (player.health > 9)) text(player.health + "%", -390, 440);
    else text(player.health + "%", -360, 440);
    text(player.armor + "%", 125, 440); 
    scale(1/0.095, 1/0.07);
    
    scale(0.0081, 0.007);
    image(img, -1200, 3100);
    scale(1/0.007, 1/0.007);
  }
  
}
