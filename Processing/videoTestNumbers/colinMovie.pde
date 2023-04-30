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
    
    private double r;
    private double g;
    private double b;
    
    private double r1;
    private double g1;
    private double b1;
    
    public colinMovie(PApplet papp, String filename, int velocity, int r, int g, int b) {
        setColor(r, g, b);
        setTargetColor(r + velocity * .25, g + velocity * .25, b + velocity * .25);
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
    
    public void setColor(int r, int g, int b) {
        this.r = (double) r;
        this.g = (double) g;
        this.b = (double) b;
    }
    
    public void setTargetColor(double r1, double g1, double b1) {
        this.r1 = r1;
        this.g1 = g1;
        this.b1 = b1;
    }

    private double lerp(double a, double b, double n) {
        return a + ((b - a) * n);
    }

    private void lerpColor(double n) {
        r = lerp(r, r1, n);
        g = lerp(g, g1, n);
        b = lerp(b, b1, n);
    }

    public void updateColor() {
        tint((int) r, (int) g, (int) b, calcOpacity());
        lerpColor(.2);
    }

    public void drawMovie() {
        updateColor();

        try {
            //scale(0.25);
            image(movie, x*4, y*4);//, (int) (72 + extra * 72), (int) (128 + extra * 128));
            //scale(4);
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

    public colinImage(PApplet papp, String note, int velocity, int r, int g, int b) {
        super(papp, note, velocity, r, g, b);
    }

    @Override
    protected void start(PApplet papp, String note, int velocity) {
        image = loadImage(note);
        timeScale = Math.min(((float) velocity)/127 * 2 + .4, 4);
        startMillis = millis();
    }

    @Override
    public void drawMovie() {
        updateColor();
        scale(4);
        image(image, width/2, height/2);
        scale(0.25);
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
