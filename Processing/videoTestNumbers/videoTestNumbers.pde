import processing.video.*;
import processing.net.*;
import java.util.Set;
import java.util.List;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentLinkedQueue;
import java.util.NoSuchElementException;
import java.util.Arrays;
import java.nio.file.Paths;

final static boolean DEBUG = false;

ConcurrentHashMap<String, colinMovie> colinMovies;
ColinMovieNames colinMovieNames;

Client client;
String dataBuffer;

String[] PITCH_CLASSES = {
    /* 
    "C", "Db", "D", "Eb",
    "E", "F", "Gb", "G",
    "Ab", "A", "Bb", "B" 
    */

    "C", "C#", "D", "D#",
    "E", "F", "F#", "G", 
    "G#", "A", "A#", "B"
};

ArrayList<Integer> indices = new ArrayList<>();

final String JSON_STREAM_DELIMITER_AVYAY = "<!>";
final int MILES_LIMIT = 10;

void setup() {
    size(1920, 1080);
    imageMode(CENTER);
    frameRate(24);
    fullScreen();
    
    // *************************** IMPORTANT ***************************
    //         YOU MUST CLONE THE PROJECT TO C:/colin-project/
    // *****************************************************************
    colinMovieNames = new ColinMovieNames();
    colinMovies = new ConcurrentHashMap<String, colinMovie>();
    client = new Client(this, "127.0.0.1", 3000);
    dataBuffer = "";

    Movie dummyMovie = new Movie(this, colinMovieNames.getMovie("C4", 50));
    dummyMovie.dispose();
}  


void draw() {    
    background(0);
    scale(0.25);
    getKeysPressed();
    
    Set<String> names = colinMovies.keySet();
    for (String name : names) {
        colinMovie movie = colinMovies.get(name);
        if (movie.pauseIfOver()) {
            colinMovies.remove(name);
        } else {
            movie.drawMovie();
        }
    }
    
    fill(255);
    text(frameRate, 30, 30);
}


void getKeysPressed() {
    if (client.available() > 0) {
        String tmp = client.readString();
        
        if (tmp == null) return;
        if (tmp.isEmpty()) return;
        
        dataBuffer += tmp;
        
        String[] incoming = dataBuffer.split(JSON_STREAM_DELIMITER_AVYAY);
        
        if (dataBuffer.endsWith("<!>")) {
            if (DEBUG) {
              println("incoming.length: " + incoming.length);
            }
            for (int i = 0; i < incoming.length; i++) {
                JSONObject e = parseJSONObject(incoming[i]);
                processKeyEvent(e);
            }
            dataBuffer = "";
        } else {
            for (int i = 0; i < incoming.length - 1; i++) {
                JSONObject e = parseJSONObject(incoming[i]);
                processKeyEvent(e);
            }
            dataBuffer = incoming[incoming.length - 1];
        }
    }
}


void processKeyEvent(JSONObject object) {
    // int pitch_wheel = object.getInt("pitch");
    
    // edit_pitch_wheel(pitch_wheel);
    
    if (colinMovies.size() < MILES_LIMIT) {
        JSONArray arr = object.getJSONArray("notes_pressed");
    
        for (int i = 0; i < arr.size(); i++) {
                JSONArray note = arr.getJSONArray(i);
                String pitch = note.getString(0); //note 
                int velocity = note.getInt(1); //velocity
                
                if (DEBUG) {
                  println("Playing " + pitch + " with velocity " + velocity + "fr: " + frameRate);
                }
                playMovie(pitch, velocity);
        }
    }
}

void movieEvent(Movie m) {
    m.read();
}


void playMovie(String source_note, int velocity) {
    String name = source_note + str(millis());
    try {
      String filename = colinMovieNames.getMovie(source_note, velocity);
      if (filename.endsWith(".png")) {
        colinMovies.put(name, new colinImage(this, filename, velocity));
      } else { // .mov
        colinMovies.put(name, new colinMovie(this, filename, velocity));
      }
    } catch (NullPointerException e) {
      if (DEBUG) {
        println("Error, note out of range!");
      }
    }
}

 boolean doesFileExist(String filePath) {
   return new File(dataPath(filePath)).exists();
 }


void keyPressed() {
    if (key == 'q') {
        colinMovies.clear();
        String[] incoming = dataBuffer.split(JSON_STREAM_DELIMITER_AVYAY);
        if (incoming.length != 0)
            dataBuffer = incoming[incoming.length - 1];
    }
}
