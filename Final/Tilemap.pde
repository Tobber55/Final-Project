public class Tilemap{
  int[][] map = new int[64][64];
  
  public Tilemap() {
    for (int i = 0; i < map.length; i++) {
      for (int j = 0; j < map[i].length; j++) {
        if ((i == 0) || i == map.length - 1) {
          map[i][j] = int(random(4, 7));
        }
        if ((j == 0) || j == map[i].length - 1) {
          map[i][j] = int(random(4, 7));
        }
        //print(map[i][j] + " ");
      }
      //println();
    }
    for(int i = 0; i < 10; i ++){
      map[i][48] = int(random(4, 7));
    }
    for(int i = 18; i < 64; i ++){
      map[i][48] = int(random(4, 7));
    }
    for(int i = 32; i < 49; i ++){
      map[24][i] = int(random(4, 7));
    }
    for(int i = 0; i < 25; i ++){
      map[i][23] = int(random(4, 7));
    }
    for(int i = 48; i < 56; i ++){
      map[38][i] = int(random(4, 7));
    }
    for(int i = 25; i < 55; i ++){
      map[i][35] = int(random(4, 7));
    }
    for(int i = 9; i < 25; i ++){
      map[24][i] = int(random(4, 7));
    }
    for(int i = 33; i < 55; i ++){
      map[i][23] = int(random(4, 7));
    }
    for(int i = 0; i < 24; i ++){
      map[43][i] = int(random(4, 7));
    }
  }
  
  public int[][] tilemap(){
    return map;
  }
}
