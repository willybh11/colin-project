
public class ColinMovieNames {
  
  private PitchGroup group_1;
  private PitchGroup group_2;
  private PitchGroup group_3;
  private PitchGroup group_4;
  
  private HashMap<String, Integer> noteGroupMap;
 
  public ColinMovieNames() {
    group_1 = new PitchGroup(1);
    group_2 = new PitchGroup(2);
    group_3 = new PitchGroup(3);
    group_4 = new PitchGroup(4);
    
    noteGroupMap = new HashMap<String, Integer>();
    noteGroupMap.put("C2",  1);
    noteGroupMap.put("Db2", 1);
    noteGroupMap.put("D2",  1);
    noteGroupMap.put("Eb2", 1);
    noteGroupMap.put("E2",  1);
    noteGroupMap.put("F2",  1);
    noteGroupMap.put("Gb2", 1);
    noteGroupMap.put("G2",  1);
    noteGroupMap.put("Ab2", 1);
    noteGroupMap.put("A2",  1);
    noteGroupMap.put("Bb2", 1);
    noteGroupMap.put("B2",  1);
    noteGroupMap.put("C3",  1);
    noteGroupMap.put("Db3", 1);
    noteGroupMap.put("D3",  1);
    noteGroupMap.put("Eb3", 1);
    noteGroupMap.put("E3",  2);
    noteGroupMap.put("F3",  2);
    noteGroupMap.put("Gb3", 2);
    noteGroupMap.put("G3",  2);
    noteGroupMap.put("Ab3", 2);
    noteGroupMap.put("A3",  2);
    noteGroupMap.put("Bb3", 2);
    noteGroupMap.put("B3",  2);
    noteGroupMap.put("C4",  2);
    noteGroupMap.put("Db4", 2);
    noteGroupMap.put("D4",  2);
    noteGroupMap.put("Eb4", 2);
    noteGroupMap.put("E4",  2);
    noteGroupMap.put("F4",  2);
    noteGroupMap.put("Gb4", 2);
    noteGroupMap.put("G4",  2);
    noteGroupMap.put("Ab4", 3);
    noteGroupMap.put("A4",  3);
    noteGroupMap.put("Bb4", 3);
    noteGroupMap.put("B4",  3);
    noteGroupMap.put("C5",  3);
    noteGroupMap.put("Db5", 3);
    noteGroupMap.put("D5",  3);
    noteGroupMap.put("Eb5", 3);
    noteGroupMap.put("E5",  3);
    noteGroupMap.put("F5",  3);
    noteGroupMap.put("Gb5", 3);
    noteGroupMap.put("G5",  3);
    noteGroupMap.put("Ab5", 3);
    noteGroupMap.put("A5",  4);
    noteGroupMap.put("Bb5", 4);
    noteGroupMap.put("B5",  4);
    noteGroupMap.put("C6",  4);
    noteGroupMap.put("Db6", 4);
    noteGroupMap.put("D6",  4);
    noteGroupMap.put("Eb6", 4);
    noteGroupMap.put("E6",  4);
    noteGroupMap.put("F6",  4);
    noteGroupMap.put("Gb6", 4);
    noteGroupMap.put("G6",  4);
    noteGroupMap.put("Ab6", 4);
    noteGroupMap.put("A6",  4);
    noteGroupMap.put("Bb6", 4);
    noteGroupMap.put("B6",  4);
    noteGroupMap.put("C7",  4);
  }
  
  public String getMovie(String pitch, int velocity) {
    if (noteGroupMap.get(pitch) == 1) {
      return group_1.getMovie(velocity);
    } else if (noteGroupMap.get(pitch) == 2) { 
      return group_2.getMovie(velocity);
    } else if (noteGroupMap.get(pitch) == 3) {
      return group_3.getMovie(velocity);
    } else { // noteGroupMap.get(pitch) == 4
      return group_4.getMovie(velocity);
    }
  }
}
