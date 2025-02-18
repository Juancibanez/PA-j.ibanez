int size;

String timeString;

void setup(){
  size(500,500);
  noStroke();
  textAlign(CENTER,CENTER);
  size = 15;
}

void draw(){
  background(#5C80BC);
  textSize(size);
  fill(#E8C547);
  
  if(mousePressed && (mouseButton == LEFT))  size+=5;
  else if(mousePressed && (mouseButton == RIGHT)) size-=5;

  timeString = nf(hour(),2) + ":" + nf(minute(),2) + ":" + nf(second(),2);
  text(timeString,width/2,height/2);
  println(size);
  
}
