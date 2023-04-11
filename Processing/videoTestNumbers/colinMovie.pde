import processing.video.*;
import java.util.Map;
import java.util.HashMap;


public class colinMovie {
    public Movie movie;
    private int opacity;
    private float timeScale;
    
    public colinMovie(PApplet papp, String filename, int velocity) {
        this.movie = new Movie(papp, filename);
        this.opacity = 0;
        this.timeScale = Math.min(((float) velocity)/127 * 2 + .4, 4);
        println(this.timeScale);
        
        this.movie.noLoop();
        this.movie.play();
    }
    
    public double time() {
      return this.movie.time() * timeScale;
    }
    
    private double duration() {
      return this.movie.duration(); // * timeScale;
    }
    
    public double progress() {
       return time()/duration()/timeScale; 
    }
    
    public int calcOpacity() {
      return (int) (255 * (-16 * Math.pow(time()/duration() - .5, 4) + 1));
    }
    
    public void drawMovie() {
        this.opacity = calcOpacity();
        tint(255, this.opacity);
        image(this.movie, 0,0); 
    }

    public boolean pauseIfOver() {
        if ((progress() >= 0.8)){
            this.movie.pause();
            this.movie.dispose();
            return true;
        } 
        return false;
    }
}
