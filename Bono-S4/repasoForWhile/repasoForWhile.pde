void setup(){
 size(800,800);
 background(0);

 noStroke();
}

void draw(){
  int j = 25;
  int i = 25;
  
  while(j<height){
    i=25;
    while(i<width){
      
      ellipse(i,j,20,20);
      i+=50;
    }
    j+=50;
  }
//  for(j=25;j<height;j+=50){
//    for(i=25;i<width;i+=50){
//      fill(random(225),random(225),random(225));
//      ellipse(i,j,20,20);
//    }
//  }
}
