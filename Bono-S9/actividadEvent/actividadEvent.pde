// Click on the window to give it focus,
// and press the 'B' key.
void setup(){
  size(500,500);

}

void draw() {
  background(0);
  if (keyPressed) {
    if (key == 'b' || key == 'B') {
        circle(50, 50, 50);
    }
  }
}
