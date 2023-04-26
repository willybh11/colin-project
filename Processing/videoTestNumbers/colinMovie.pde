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
        println(this.timeScale);

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
            image(movie, x, y, (int) (72 + extra * 72), (int) (128 + extra * 128));
        } catch (ArrayIndexOutOfBoundsException e) {
            println("Daaayyuu- aw...");
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
