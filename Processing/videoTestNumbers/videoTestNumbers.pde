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

double[] current_color = {0, 0, 0};

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
    size(2560, 1080);
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

    println(object);
    
    if (colinMovies.size() < MILES_LIMIT) {
        JSONArray colorBears = object.getJSONArray("color");
        JSONArray arr = object.getJSONArray("notes_pressed");

        if (colorBears != null && colorBears.size() >= 3) {
            int r = colorBears.getInt(0);
            int g = colorBears.getInt(1);
            int b = colorBears.getInt(2);

            current_color[0] = (double) r;
            current_color[1] = (double) g;
            current_color[2] = (double) b;

            for (int i = 0; i < arr.size(); i++) {
                JSONArray note = arr.getJSONArray(i);
                String pitch = note.getString(0); //note 
                int velocity = note.getInt(1); //velocity
                
                if (DEBUG) {
                    println("Playing " + pitch + " with velocity " + velocity + "fr: " + frameRate);
                }

                playMovie(pitch, velocity, r, g, b);
            }
        }

        JSONArray arr2 = object.getJSONArray("notes_released");
        
        for (int i = 0; i < arr2.size(); i++) {
            String note = arr2.getString(i);    
            println("Releasing " + note);
            releaseMovies(note);
        }
    }
}

void movieEvent(Movie m) {
    m.read();
}

int offset(int range) {
    return (int) random(-range/2, range/2);
}

void playMovie(String source_note, int velocity, int r, int g, int b) {
    String name = source_note + str(millis());
    try {
        String filename = colinMovieNames.getMovie(source_note, velocity);
        if (filename.endsWith(".png")) {
            colinMovies.put(name, new colinImage(this, filename, velocity, r + offset(4), g + offset(4), b + offset(4)));
        } else { // .mov
            colinMovies.put(name, new colinMovie(this, filename, velocity, r + offset(4), g + offset(4), b + offset(4)));
        }
    } catch (NullPointerException e) {
        if (DEBUG) {
            println("Error, note out of range!");
        }
    }
}

void releaseMovies(String note) {
    for (String key: colinMovies.keySet()) {
        if (key.startsWith(note)) {
            colinMovie movie = colinMovies.get(key);
            movie.setTargetColor(current_color[0], current_color[1], current_color[2]);
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
