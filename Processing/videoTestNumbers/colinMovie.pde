import processing.video.*;
import java.util.Map;
import java.util.HashMap;

private static Map<String, colinMovie> _map = new HashMap<>();

public static boolean isAlreadyPlaying(String name) {
  return false;
    //return _map.containsKey(name);
}

public class colinMovie {
    public Movie movie;
    private boolean fadingIn, fadingOut;
    private int opacity, fadeIncrement;   
    private float timeScale;
    private String filename;
    
    public colinMovie(PApplet papp, String filename, int velocity) {
        this.filename = filename;
        this.movie = new Movie(papp, filename);
        this.fadeIncrement = 15;
        this.fadingIn = true;
        this.fadingOut = false;
        this.opacity = 0;
        this.timeScale = Math.min(((float) velocity)/127 * 2 + .4, 4);
        println(this.timeScale);
        
        this.movie.noLoop();
        this.movie.play();
        
        //_map.put(filename, this);
    }
    
    public double time() {
      return this.movie.time() * timeScale;
    }
    
    public double duration() {
      return this.movie.duration(); // * timeScale;
    }
    
    public double progress() {
       return time()/duration()/timeScale; 
    }
    
    public int calcOpacity() {
      return (int) (255 * (-16 * Math.pow(time()/duration() - .5, 4) + 1));
    }
    
    public void drawMovie() {
        //if (this.opacity < 255 && this.fadingIn) {
        //    this.opacity = min(this.opacity + getFadeIncrement(), 255);
        //    if (this.opacity == 255) {
        //        this.fadingIn = false;
        //    }
        //} else if (this.movie.time() > this.movie.duration() - 0.5) {
        //    this.fadingOut = true;
        //}
        
        this.opacity = calcOpacity();
        //println(this.opacity);
        
        //this.movie.read();
        
        //TODO: fade out
        //if (this.opacity > 0 && this.fadingOut) {
        //    println("I am fading out: opacity=" + this.opacity);
        //    this.opacity = max(this.opacity - getFadeIncrement(), 0);
        //    if (this.opacity == 0) {
        //        this.fadingOut = false;
        //    }
        //}
        
        tint(255, this.opacity);
        image(this.movie, 0,0); 
    }
    
    private int getFadeIncrement() {
        return int(this.fadeIncrement * (30/frameRate));
    }

    public boolean pauseIfOver() {
        if ((progress() >= 0.8)){
            this.movie.pause();
            this.movie.dispose();
            //_map.remove(this.filename);
            return true;
        } 
        return false;
    }
}
