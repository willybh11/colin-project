
public class PitchGroup {
  
  private int groupNumber;
  
  private ArrayList<String> vel_1;
  private ArrayList<String> vel_2;
  private ArrayList<String> vel_3;
  private ArrayList<String> vel_4;
 
  public PitchGroup(int num) {
    
    groupNumber = num;
    
    vel_1 = new ArrayList<String>();
    vel_2 = new ArrayList<String>();
    vel_3 = new ArrayList<String>();
    vel_4 = new ArrayList<String>();
    
    File dataFolder = new File("C:/colin-project/Processing/videoTestNumbers/data");
    File[] listOfFiles = dataFolder.listFiles();
    
    for (int i = 0; i < listOfFiles.length; i++) {
      if (listOfFiles[i].isFile()) {
        String filename = listOfFiles[i].getName();
        //System.out.println("File " + filename);
        if (listOfFiles[i].getName().length() > 7) {
          int groupNum = int(listOfFiles[i].getName().substring(6,7));
          int velNum = int(listOfFiles[i].getName().substring(12,13));
          //println("group: " + groupNum + " vel: " + velNum);
          if (groupNum == this.groupNumber) {
            if (velNum == 1) {
              vel_1.add(filename);
              //println("added to group 1");
            } else if (velNum == 2) {
              vel_2.add(filename);
              //println("added to group 2");
            } else if (velNum == 3) {
              vel_3.add(filename);
              //println("added to group 3");
            } else { // velNum == 4
              vel_4.add(filename);
              //println("added to group 4");
            }
          }
        }
      }
    }
  }
}
