int x;
int y;

void setup(){
 size(500,500); 
 frameRate(180);
 x = width/2;
 y = 0;
}

void draw(){
 background(255);
 
 if (y >= height || y <= 0) y=0;
 drawEllipse(x,y++,50,50);

}

void drawEllipse(float x,float y,float w,float h){
  ellipse(x,y,w,h);
}
