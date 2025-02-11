//Juan Camilo Ibáñez - 201924835

int tesSize = 20;

void setup() {

  size(500, 500);
  background(#D4E09B);

  strokeWeight(2);
  stroke(#D4E09B);
  fill(#A44A3F);
   for (int i=0; i<width+tesSize; i+=tesSize) {
      circle(i,0,tesSize);
      
   }
  for (int j=height; j<height+tesSize; j+=tesSize){
    for (int i=0; i<width+tesSize; i+=tesSize) {
      circle(i,j,tesSize);
      
    }
  }
  
  for (int j=0; j<height+tesSize; j+=tesSize){
    for (int i=width; i<width+tesSize; i+=tesSize) {
      circle(i,j,tesSize);
      
    }
  }
  for (int j=0; j<height+tesSize; j+=tesSize){
    for (int i=0; i<tesSize; i+=tesSize) {
      circle(i,j,tesSize);
      
    }
  }
  for (int j=tesSize; j<height; j+=tesSize){
    for (int i=tesSize; i<width; i+=tesSize) {
      fill(#94A89A);
      circle(i,j,tesSize);
      
    }
  }
  
  translate(10,10);
  fill(#A44A3F);

  for (int j=tesSize; j<height-tesSize; j+=tesSize){
    for (int i=tesSize; i<width-tesSize; i+=tesSize) {

      circle(i,j,tesSize/2);
      
    }
  }

  fill(#FFFFC5);
  for (int j=height/4; j<(height*3/4)-tesSize; j+=tesSize){
    for (int i=width/4; i<(width*3/4)-tesSize; i+=tesSize) {

      circle(i,j,tesSize/2);
      
    }
  }

}
