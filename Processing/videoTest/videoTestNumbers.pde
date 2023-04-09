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

//temp
//int secondsPassed;
//int moviesCreated, moviesDisposed;

final String JSON_STREAM_DELIMITER_AVYAY = "<!>";


void setup() {
    size(1920, 1080);
    
    colinMovies = new ConcurrentHashMap<String, colinMovie>();
    client = new Client(this, "127.0.0.1", 3000);
    dataBuffer = "";

    Movie dummyMovie = new Movie(this, "C2.mov");
    dummyMovie.dispose();
    
    //temp
    //secondsPassed = 0;
    //moviesCreated = 1;
    //moviesDisposed = 1;
    
}  

void draw() {    
    background(0);
    
    //println("Movies created: " + moviesCreated);
    //println("Movies disposed: " + moviesDisposed);
    //println("Length of colinMovies: " + colinMovies.size());
    //println("Framreate: " + frameRate);
    
    getKeysPressed();
    
    Set<String> names = colinMovies.keySet();
    for (String name : names) {
        colinMovie movie = colinMovies.get(name);
        if (movie.pauseIfOver()) {
            colinMovies.remove(name);
            //moviesDisposed += 1;
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
        
        //if (!dataBuffer.isEmpty())
        //  println("New data: \n" + dataBuffer);
        
        String[] incoming = dataBuffer.split(JSON_STREAM_DELIMITER_AVYAY);
        
        if (dataBuffer.endsWith("<!>")) {
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
    JSONArray arr = object.getJSONArray("notes_pressed");
    
    for (int i = 0; i < arr.size(); i++) {
        JSONArray note = arr.getJSONArray(i);
        String pitch = note.getString(0); //note 
        int velocity = note.getInt(1); //velocity
        
        println("Playing " + pitch + " with velocity " + velocity);
        playMovie(pitch, velocity);
    }
    
    //JSONArray rel_arr = object.getJSONArray("notes_released");
    
    //for (int j = 0; j < rel_arr.size(); j++) {
    //    println("Released " + rel_arr.getString(j));
    //}
    
}

void movieEvent(Movie m) {
    m.read();
}  

void playMovie(String note, int velocity) {
    if (isAlreadyPlaying(note + ".mov")) return;
    String name = note + str(millis());
    if (!doesFileExist(note.replaceAll("\\^(d+)", "4") + ".mov")) return;
    colinMovies.put(name, new colinMovie(this, note + ".mov", velocity));
    //moviesCreated += 1;
}

boolean doesFileExist(String filePath) {
  return new File(dataPath(filePath)).exists();
}

//class MoviePlayer implements Runnable {
//    private String note;

//    public MoviePlayer(String note, int velocity) {
//        this.note = note;
//    }

//    public void run() {
//        playMovie(note);
//    }
//}
