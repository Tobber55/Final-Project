public class Tilemap{
  int[][] map = new int[32][32];
  
  public Tilemap(){
    for (int i = 0; i < map.length; i++) {
      for (int j = 0; j < map[i].length; j++) {
        if ((i == 0) || i == map.length - 1) {
          map[i][j] = 5;
        }
        if ((j == 0) || j == map[i].length - 1) {
          map[i][j] = 5;
        }
        //print(map[i][j] + " ");
      }
      //println();
    }
    map[9][14] = 5;
    //map[10][14] = 5;
    //map[12][10] = 5;
    
    
  }
  
  public int[][] tilemap(){
    return map;
  }
}
