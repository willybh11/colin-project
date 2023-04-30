
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
    noteGroupMap.put("C#2", 1);
    noteGroupMap.put("D2",  1);
    noteGroupMap.put("D#2", 1);
    noteGroupMap.put("E2",  1);
    noteGroupMap.put("F2",  1);
    noteGroupMap.put("F#2", 1);
    noteGroupMap.put("G2",  1);
    noteGroupMap.put("G#2", 1);
    noteGroupMap.put("A2",  1);
    noteGroupMap.put("A#2", 1);
    noteGroupMap.put("B2",  1);
    noteGroupMap.put("C3",  1);
    noteGroupMap.put("C#3", 1);
    noteGroupMap.put("D3",  1);
    noteGroupMap.put("D#3", 1);
    noteGroupMap.put("E3",  2);
    noteGroupMap.put("F3",  2);
    noteGroupMap.put("F#3", 2);
    noteGroupMap.put("G3",  2);
    noteGroupMap.put("G#3", 2);
    noteGroupMap.put("A3",  2);
    noteGroupMap.put("A#3", 2);
    noteGroupMap.put("B3",  2);
    noteGroupMap.put("C4",  2);
    noteGroupMap.put("C#4", 2);
    noteGroupMap.put("D4",  2);
    noteGroupMap.put("D#4", 2);
    noteGroupMap.put("E4",  2);
    noteGroupMap.put("F4",  2);
    noteGroupMap.put("F#4", 2);
    noteGroupMap.put("G4",  2);
    noteGroupMap.put("G#4", 3);
    noteGroupMap.put("A4",  3);
    noteGroupMap.put("A#4", 3);
    noteGroupMap.put("B4",  3);
    noteGroupMap.put("C5",  3);
    noteGroupMap.put("C#5", 3);
    noteGroupMap.put("D5",  3);
    noteGroupMap.put("D#5", 3);
    noteGroupMap.put("E5",  3);
    noteGroupMap.put("F5",  3);
    noteGroupMap.put("F#5", 3);
    noteGroupMap.put("G5",  3);
    noteGroupMap.put("G#5", 3);
    noteGroupMap.put("A5",  4);
    noteGroupMap.put("A#5", 4);
    noteGroupMap.put("B5",  4);
    noteGroupMap.put("C6",  4);
    noteGroupMap.put("C#6", 4);
    noteGroupMap.put("D6",  4);
    noteGroupMap.put("D#6", 4);
    noteGroupMap.put("E6",  4);
    noteGroupMap.put("F6",  4);
    noteGroupMap.put("F#6", 4);
    noteGroupMap.put("G6",  4);
    noteGroupMap.put("G#6", 4);
    noteGroupMap.put("A6",  4);
    noteGroupMap.put("A#6", 4);
    noteGroupMap.put("B6",  4);
    noteGroupMap.put("C7",  4);
  }
  
  public String getMovie(String pitch, int velocity) {
    if (DEBUG) {
      println("called ColinMovieNames.getMovie( " + pitch + ", " + velocity + ")");
    }
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

  public String getFullScreen(String pitch) {
    return (noteGroupMap.get(pitch) == 1);
  }
}
