int distancia = 30;

void setup(){

  size(500,500);
  if(distancia == 50){
    print("sí");
  }else{
    print("no");
  }
}

void draw(){
  background(0);
  ellipse(mouseX,mouseY,50,50);
}
