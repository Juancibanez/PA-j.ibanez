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
  frameRate(120);

  minim = new Minim(this);
  player = minim.loadFile("StolenDance.mp3", 1024);
  player.play();

  fft = new FFT(player.bufferSize(), player.sampleRate());
  
  x = width/2;
  y = -1;
}

void draw() {
  background(0);
  fft.forward(player.mix);
  level = fft.getBand(10);
  rad = (level * 5);

  float r = random(100);
  float g = random(200, 255);
  float b = random(100, 255);

  stroke(r, g, b);
  fill(255,25);
  rect(0*100, y, 50, rad);
  rect(1*100, y, 50, rad);
  rect(2*100, y, 50, rad);
  rect(3*100, y, 50, rad);
  rect(4*100, y, 50, rad);
  rect(5*100, y, 50, rad);
  rect(6*100, y, 50, rad);
  rect(7*100, y, 50, rad);

  delay(20);
}
