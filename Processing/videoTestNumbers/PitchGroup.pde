
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
    
    File dataFolder = new File(".");
    File[] listOfFiles = dataFolder.listFiles();
    
    for (int i = 0; i < listOfFiles.length; i++) {
      if (listOfFiles[i].isFile()) {
        System.out.println("File " + listOfFiles[i].getName());
        println(listOfFiles[i].getName().substring(6,7));
      }
    }
  }
  
}
