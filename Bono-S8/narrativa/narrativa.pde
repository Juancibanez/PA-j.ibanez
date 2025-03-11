PImage inicio, nudo, fin;
int fase;

void setup(){
  size(500,500);
  
  inicio = loadImage("inicio.jpeg");
  nudo = loadImage("nudo.jpeg");
  fin = loadImage("final.jpeg");
  fase = 0;
}

void draw(){
  background(0);
  
  if(fase == 0) image(inicio,0,0);
  else if(fase == 1) image(nudo,0,0);
  else if(fase == 2) image(fin,0,0);

  if (fase > 2) fase = 0;

}

void mousePressed(){
  fase++;
}
