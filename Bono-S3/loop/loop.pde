void setup() {
  //   width, height
  size(500, 500);
  background(0);
  
  for(int i = 0; i < width; i++){
    for(int j = 0; j < height; j++){
      ellipse(i*10,j*10,5,5);
    }
  }
  
}
