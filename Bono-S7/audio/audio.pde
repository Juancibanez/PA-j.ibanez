import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer player;
FFT fft;

int x = 0;
int y = 50;

float rad;
float level;

void setup() {

  size(800, 800);
  background(0);
  frameRate(500);

  minim = new Minim(this);
  player = minim.loadFile("LaNoche.mp3", 1024);
  player.play();

  fft = new FFT(player.bufferSize(), player.sampleRate());
}

void draw() {

  fft.forward(player.mix);
  level = fft.getBand(10);
  rad = (level * 10);

  float r = random(200, 255);
  float g = random(100, 255);
  float b = random(100);

  stroke(r, g, b);
  fill(255, 10);
  circle(x, y, rad);

  if (x < width) {
    y+=20;
    if (y > height) {
      y = 0;
      x+=20;
    }
  } else {
    noLoop();
    player.pause();
  }

  delay(20);
}
