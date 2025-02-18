int h;
int m;
int s;

String timeString;

void setup(){
  size(500,500);
  noStroke();
  textSize(24);
  textAlign(CENTER,CENTER);
}

void draw(){
  background(#5C80BC);
  fill(#E8C547);
  
  h = hour();
  m = minute();
  s = second();

  timeString = nf(h,2) + ":" + nf(m,2) + ":" + nf(s,2);
  text(timeString,width/2,height/2);
  
}
