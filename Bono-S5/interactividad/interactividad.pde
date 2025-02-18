int coordX;
int coordY;

int tamanio = 30;

void setup(){
  size(500,500);
  noStroke();
  
  coordX = width/2;
  coordY = height/2;
}

void draw(){
  background(#5C80BC);
  fill(#E8C547);
  
  if((mouseX>coordX - tamanio/2 && mouseX<coordX + tamanio/2) && 
     (mouseY>coordY - tamanio/2 && mouseY<coordY + tamanio/2)){
    fill(#30323D);
    if(mousePressed){
       coordX = int(random(width));
       coordY = int(random(height));
      
    }
  }
  
  square(coordX - tamanio/2,coordY - tamanio/2,tamanio);
}
