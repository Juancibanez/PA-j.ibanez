int x = 0;
int y = 0;

float level;
float rad;

void setup(){
   size(500,500);
   background(255);
  // for(int y = 0; y <= height; y+=50){
  //  for(int x = 0; x <= width; x+=50){
  //    rad = (random(0,1) * width/2);
  //    fill(random(100),10);
  //    stroke(100,random(100,200),random(100));
  //    circle(x,y,rad);
  //  }
  //}
}

void draw(){

  rad = (random(0,1) * width/2);
  
  fill(random(100),10);
  stroke(100,random(100,200),random(100));
  circle(x,y,rad);
  
  if(y < height){
    x+=50;
    if(x > width){
      x = 0;
      y+=50;
    }
  }else{
    noLoop();
  }

  delay(25);

}
