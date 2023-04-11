import processing.video.*;
import processing.net.*;
import java.util.Set;
import java.util.List;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentLinkedQueue;
import java.util.NoSuchElementException;
import java.util.Arrays;

ConcurrentHashMap<String, colinMovie> colinMovies;
Client client;
String dataBuffer;

final String JSON_STREAM_DELIMITER_AVYAY = "<!>";
final int MILES_LIMIT = 7;

int millisTimeOfKill = -1000;

void setup() {
    size(1920, 1080);
    
    colinMovies = new ConcurrentHashMap<String, colinMovie>();
    client = new Client(this, "127.0.0.1", 3000);
    dataBuffer = "";

    Movie dummyMovie = new Movie(this, "C2.mov");
    dummyMovie.dispose();
}  


void draw() {    
    background(0);
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
            println("incoming.length: " + incoming.length);
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
    if (colinMovies.size() < MILES_LIMIT) {
        JSONArray arr = object.getJSONArray("notes_pressed");
    
        for (int i = 0; i < arr.size(); i++) {
                JSONArray note = arr.getJSONArray(i);
                String pitch = note.getString(0); //note 
                int velocity = note.getInt(1); //velocity
      
                println("Playing " + pitch + " with velocity " + velocity + "fr: " + frameRate);
                playMovie(pitch, velocity);
        }
    }
}

void movieEvent(Movie m) {
    m.read();
}

String random_funny(ArrayList<String> names) {
    return names.get(random(names.size() - 1));
}

void playMovie(String note, int velocity) {
    String name = note + str(millis());
    // if (!doesFileExist(note.replaceAll("\\^(d+)", "4") + ".mov")) return;
    // colinMovies.put(name, new colinMovie(this, random_funny(), velocity));
    colinMovies.put(name, new colinMovie(this, note + ".mov", velocity));
}


// boolean doesFileExist(String filePath) {
//   return new File(dataPath(filePath)).exists();
// }


void keyPressed() {
    if (key == 'q') {
        println("clearing movies");
        colinMovies.clear();

        String[] incoming = dataBuffer.split(JSON_STREAM_DELIMITER_AVYAY);
        if (incoming.length != 0)
            dataBuffer = incoming[incoming.length - 1];
    }
}
