int posX;
int posY;

int speedX;
int speedY;

void setup(){
  size(500,500);
  noStroke();
  frameRate(180);
  
  posX = 0;
  posY = 0;
  
  speedX = 3;
  speedY = 1;
}

void draw(){
  background(0);
  posX+=speedX;
  posY+=speedY;
  
  if(posX > width || posX < 0){
    speedX*=-1;
    fill(random(255),random(255),random(255));
  }else if(posY > height || posY < 0){
    speedY*=-1;
    fill(random(255),random(255),random(255));
  }
  
  ellipse(posX,posY,50,50);
}
