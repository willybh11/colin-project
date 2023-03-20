import processing.video.*;
Movie myMovie;

void setup() {
  size(1920, 1080);
  myMovie = new Movie(this, "file_example_MOV_480_700kB.mov");
  myMovie.play();
}

void draw() {
  image(myMovie, 0, 0);
}

void movieEvent(Movie m) {
  m.read();
}
