public class Ammo{
  PVector currentChunk;
  
  PImage img = loadImage("ammo.png");
  PImage img2 = loadImage("redbull.png");

  String powerup = "ammo";
  
  public Ammo(PVector pos){
    currentChunk = pos;
  }
}
