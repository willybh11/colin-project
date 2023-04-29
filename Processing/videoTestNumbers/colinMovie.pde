import processing.video.*;
import java.util.Map;
import java.util.HashMap;

public class colinMovie {
    private Movie movie;
    private int opacity;
    private int x;
    private int y;
    private float extra;
    protected float timeScale;
    
    public colinMovie(PApplet papp, String filename, int velocity) {
        start(papp, filename, velocity);
    }

    protected void start(PApplet papp, String filename, int velocity) {
        movie = new Movie(papp, filename);
        timeScale = Math.min(((float) velocity)/127 * 2 + .4, 4);
        if (DEBUG) {
          println(this.timeScale);
        }
        
        x = ((int) random(1900)) + 10;
        y = ((int) random(1060)) + 10;
        extra = random(4);

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

        try {
            scale(0.25);
            image(movie, x*4, y*4);//, (int) (72 + extra * 72), (int) (128 + extra * 128));
            scale(4);
        } catch (ArrayIndexOutOfBoundsException e) {
            if (DEBUG) {
              println("Daaayyuu- aw...");
            }
        }
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
        image = loadImage(note);
        timeScale = Math.min(((float) velocity)/127 * 2 + .4, 4);
        startMillis = millis();
    }

    @Override
    public void drawMovie() {
        tint(255, calcOpacity());
        image(image, width/2, height/2);
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
