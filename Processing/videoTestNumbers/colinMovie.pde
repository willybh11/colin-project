import processing.video.*;
import java.util.Map;
import java.util.HashMap;


public class colinMovie {
    protected float timeScale;
    private Movie movie;
    
    public colinMovie(PApplet papp, String note, int velocity) {
        start(papp, note, velocity);
    }

    protected void start(PApplet papp, String note, int velocity) {
        movie = new Movie(papp, note + ".mov");
        timeScale = Math.min(((float) velocity)/127 * 2 + .4, 4);
        println(this.timeScale);
        movie.noLoop();
        movie.play();
    }
    
    protected double time() {
        return movie.time() * timeScale;
    }
    
    protected double duration() {
        return movie.duration();
    }
    
    protected double progress() {
        return time()/duration()/timeScale; 
    }
    
    protected int calcOpacity() {
        return (int) (255 * (-16 * Math.pow(time()/duration() - .5, 4) + 1));
    }
    
    public void drawMovie() {
        tint(255, calcOpacity());
        image(movie, 0,0); 
    }

    public boolean pauseIfOver() {
        if (progress() >= 0.8){
            movie.pause();
            movie.dispose();
            return true;
        } 
        return false;
    }
}

public class colinImage extends colinMovie {
    protected float timeScale;
    private PImage image;
    private int startMillis;

    public colinImage(PApplet papp, String note, int velocity) {
        super(papp, note, velocity);
    }

    @Override
    protected void start(PApplet papp, String note, int velocity) {
        image = loadImage(note + ".png");
        timeScale = Math.min(((float) velocity)/127 * 2 + .4, 4);
        startMillis = millis();
    }

    @Override
    public void drawMovie() {
        tint(255, calcOpacity());
        image(image, 0, 0);
    }

    @Override
    protected double progress() {
        return time()/duration()/timeScale; 
    }

    @Override
    protected double time() {
        return ((millis()/1000.0) - (startMillis/1000.0)) * timeScale;
    }
    
    @Override
    protected double duration() {
        return 3;
    }

    @Override
    public boolean pauseIfOver() {
      return (progress() >= 0.8);
    }
}
