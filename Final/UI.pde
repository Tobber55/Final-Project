public class UI {
  
  int forward = 50;
  
  float turnOffset = 0;
  PVector wasdOffset = new PVector(0, 0);
  
  PImage sze = loadImage("Sze.png");
  PImage rudi = loadImage("Rudi.png");
  PImage alex = loadImage("Alex.png");
  
  boolean startscreen = true;
  
  int stage = 1;
  
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
    
    if ((player.ammo < 100) && (player.ammo > 9)) text(player.ammo, -645, 440); 
    else text(player.ammo, -610, 440); 
    if (player.health >= 100) text(player.health + "%", -420, 440); //// CENTER
    else if ((player.health < 100) && (player.health > 9)) text(player.health + "%", -390, 440);
    else text(player.health + "%", -360, 440);
    text(player.armor + "%", 125, 440); 
    scale(1/0.095, 1/0.07);
    
    
    if (player.player == "Shadow") {
      scale(0.0081, 0.007);
      image(sze, -1200, 3100);
      scale(1/0.007, 1/0.007);
    }
    if (player.player == "Tobber") {
      scale(0.0063, 0.0055);
      image(rudi, -1500, 3800);
      scale(1/0.0063, 1/0.0055);
    }
    if (player.player == "Aria") {
      scale(0.0075, 0.007);
      image(alex, -1285, 3100);
      scale(1/0.0075, 1/0.007);
    }
  }
  
  public void uiStart() {
    camera();
    background(0);
    
    // Start Button
    if (stage == 1) {
      if ((mouseX > 275) && (mouseX < 525) && (mouseY > 250) && (mouseY < 325)) {
        fill(218, 165, 32);
        stroke(255, 215, 0);
        rect(275, 250, 250, 75);
        textSize(40);
        
        fill(255);
        strokeWeight(5);
        text("Start", 350, 300);
      }
      else {
        fill(120,120,120);
        stroke(255, 215, 0);
        rect(275, 250, 250, 75);
        textSize(40);
        
        fill(255);
        strokeWeight(5);
        text("Start", 350, 300); 
      }
    }
    else if (stage == 2) {
      
      if (!((mouseX > 50) && (mouseX < 230) && (mouseY > 35) && (mouseY < 415))) {
        fill(135, 206, 235);
        strokeWeight(5);
        stroke(255, 215, 0);
        rect(50, 35, 180, 380);
        textSize(40);
        
        fill(255);
        text("Tobber", 75, 230);
      }
      else {
        fill(135, 206, 235);
        strokeWeight(2);
        stroke(255, 215, 0);
        rect(50, 35, 180, 380);
        textSize(20);
        
        fill(255);
        strokeWeight(5);
        text("After tinkering for weeks, he has enhanced his finger gun to support full-auto. This allows the bullets to home into enemies for a few seconds at a time.", 65, 60, 150, 380);
        textSize(17);
        strokeWeight(1);
        text("Weapon", 70, 335);
        line(70, 335, 70 + textWidth("Weapon"), 335);
        text("Finger Rifle", 60, 400);
        text("Ability", 165, 335);
        line(165, 335, 165 + textWidth("Ability"), 335);
        text("Homing", 159, 400);
      }
      if (!((mouseX > 300) && (mouseX < 480) && (mouseY > 35) && (mouseY < 415))) {
        fill(210, 43, 43);
        strokeWeight(5);
        stroke(255, 215, 0);
        rect(300, 35, 180, 380);
        textSize(40);
        
        fill(255);
        text("Shadow", 320, 230);
      }
      else {
        fill(210, 43, 43);
        strokeWeight(2);
        stroke(255, 215, 0);
        rect(300, 35, 180, 380);
        textSize(20);
        
        fill(255);
        text("Following 17 years of training, he has mastered the art of emo. Able to temporarily become a shadow, he is intangible and indetectable to all enemies.", 315, 60, 150, 380);
        textSize(17);
        strokeWeight(1);
        text("Weapon", 320, 335);
        line(320, 335, 320 + textWidth("Weapon"), 335);
        text("Finger Gun", 312, 400);
        text("Ability", 415, 335);
        line(415, 335, 415 + textWidth("Ability"), 335);
        text("Shadow", 409, 400);
      }
      if (!((mouseX > 550) && (mouseX < 730) && (mouseY > 35) && (mouseY < 415))) {
        fill(76, 187, 23);
        strokeWeight(5);
        stroke(255, 215, 0);
        rect(550, 35, 180, 380);
        textSize(40);
        
        fill(255);
        text("Aria", 605, 230);
      }
      else {
        fill(76, 187, 23);
        strokeWeight(2);
        stroke(255, 215, 0);
        rect(550, 35, 180, 380);
        textSize(20);
        
        fill(255);
        text("The boy who can control time. His insane martial arts skills allows him to tear a hole through time, breifly slowing everything while he can still move.", 565, 60, 150, 380);
        textSize(17);
        strokeWeight(1);
        text("Weapon", 570, 335);
        line(570, 335, 570 + textWidth("Weapon"), 335);
        text("Boxing Glove", 556, 400);
        text("Ability", 665, 335);
        line(665, 335, 665 + textWidth("Ability"), 335);
        text("Time Stop", 654, 400);
      }
    }
    
    
  }
  
  public boolean readInput(PVector mouse, Player player) {
    if (stage == 1) {
      if ((mouse.x > 275) && (mouse.x < 525) && (mouse.y > 250) && (mouse.y < 325)) {
        fill(255);
        stroke(255, 215, 0);
        rect(275, 250, 250, 75);
        textSize(40);
          
        fill(255);
        strokeWeight(5);
        text("Start", 350, 300); 
        stage = 2;
      }
    }
    else if (stage == 2) {
      if ((mouse.x > 50) && (mouse.x < 230) && (mouse.y > 35) && (mouse.y < 415)) {
        stroke(0);
        strokeWeight(1);
        player.player = "Tobber";
        player.maxammo = 30;
        player.ammo = player.maxammo;
        player.shootmaxcool = 10;
        stage = 3;
        return(false);
      }
      if ((mouse.x > 300) && (mouse.x < 480) && (mouse.y > 35) && (mouse.y < 415)) {
        stroke(0);
        strokeWeight(1);
        player.player = "Shadow";
        player.maxammo = 6;
        player.ammo = player.maxammo;
        player.shootmaxcool = 60;
        stage = 3;
        return(false);
      }
      if ((mouse.x > 550) && (mouse.x < 730) && (mouse.y > 35) && (mouse.y < 415)) {
        stroke(0);
        strokeWeight(1);
        player.player = "Aria";
        player.maxammo = 0;
        player.ammo = player.maxammo;
        player.shootmaxcool = 10;
        stage = 3;
        return(false);
      }
    }
    return(true);
  }
  
  
}
