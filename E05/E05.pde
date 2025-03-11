import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer player;
FFT fft;

int x;
int y;

float rad;
float level;

void setup() {

  size(800, 800);
  frameRate(60);

  minim = new Minim(this);
  player = minim.loadFile("StolenDance.mp3", 1024);
  player.play();

  fft = new FFT(player.bufferSize(), player.sampleRate());
  
  x = width/2;
  y = height/2;
}

void draw() {
  background(0);
  fft.forward(player.mix);
  level = fft.getBand(10);
  rad = (level * 10);

  float r = random(200, 255);
  float g = random(100, 255);
  float b = random(100);

  stroke(r, g, b);
  fill(255, 10);
  circle(x, y, rad);

  delay(100);
}
