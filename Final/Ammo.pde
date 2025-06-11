public class Ammo{
  PVector currentChunk;
  PImage img = loadImage("ammo.png");
  
  String powerup = "ammo";
  
  public Ammo(PVector pos){
    currentChunk = pos;
  }
}
