
public class PitchGroup {
  
  private int groupNumber;
  
  private ArrayList<String> vel_1;
  private ArrayList<String> vel_2;
  private ArrayList<String> vel_3;
  private ArrayList<String> vel_4;
 
  public PitchGroup(int num) {
    
    println("pitchgroup init, num = " + num);
    
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
        if (listOfFiles[i].getName().length() > 13) {
          int groupNum = Integer.parseInt(filename.substring(5,6));
          int velNum = Integer.parseInt(filename.substring(10,11));
          if (groupNum == this.groupNumber) {
            if (velNum == 1) {
              vel_1.add(filename);
              println("Added " + filename + " to pitch group 1");
            } else if (velNum == 2) {
              vel_2.add(filename);
              println("Added " + filename + " to pitch group 2");
            } else if (velNum == 3) {
              vel_3.add(filename);
              println("Added " + filename + " to pitch group 3");
            } else { // velNum == 4
              vel_4.add(filename);
              println("Added " + filename + " to pitch group 4");
            }
          }
        }
      }
    }
  }
  
  public String getMovie(int velocity) {
    
    ArrayList<String> vel_group;

    if (velocity == 1) {
      vel_group = vel_1;
    } else if (velocity == 2) {
      vel_group = vel_2;
    } else if (velocity == 3) {
      vel_group = vel_3;
    } else { // velocity == 4
      vel_group = vel_4;
    }
    
    return vel_group.get(int(random(vel_group.size())));
  }
}
