PFont font;
String timeString; // variable que controla horas y minutos en formato estándar

int x; // posición de los segundos en x
int y; // posición de los segundos en y

int offsety; // offset para la posición de los segundos en y

String h; //hora
String m; //minuto
String s; //segundo

int intensidad = 1; // variable que controla la opacidad de los segundos

void setup(){
  size(500,500);
  background(#5C80BC);
  noStroke();
  font = createFont("Franchise Regular", 128); // importar la fuente
  textFont(font);

  offsety = 80;
  
  timeString = nf(hour(),2) + ":" + nf(minute(),2); //inicialización timeString
  textAlign(CENTER);
  textSize(125);
  fill(255,100);
  text(timeString,width/2,height/2);
  
  x = (int(nf(second(),2))%10) * (width/10) - (width/10); //inicialización x:
  //se hace esta operación para garantizar que el segundo actual quede bien posicionado en x
  //dentro de una matriz invisible en el canvas de 6 filas y 10 columnas (6*10 = 60 segundos)
  //ejemplo: (54%10 = 4) * (500/10 = 50) - (width/10:offset en x para la primera iteración)
  
  
  y = (int(nf(second(),2))/10) * (height/6)+offsety; //inicialización y:
  //se hace esta operación para garantizar que el segundo actual quede bien posicionado en y
  //dentro de una matriz invisible en el canvas de 6 filas y 10 columnas (6*10 = 60 segundos)
  //ejemplo: int(54/10 = 5) * (500/6 = 83.333) + (offsety = 80)
  
}

void draw(){
  
  h = nf(hour(),2);
  m = nf(minute(),2);
  s = nf(second(),2);
  
  if (int(s) == 01){
    intensidad = 1; // reinicia la intensidad cuando los segundos sean 1
    background(#5C80BC); // reinicia el background cuando los segundos sean 1
    fill(255,100);
    textSize(125);
    textAlign(CENTER); // timeString centrado
    text(timeString,width/2,height/2); // imprime el timeString cuando los segundos sean 1
  }
  
  timeString = h + ":" + m;
  
  textSize(60); // tamaño de los segundos
  fill(#E8C547,intensidad*255/60); // fuente amarilla y la intensidad que se le asigna
  textAlign(BASELINE);
  text(s,x,y/2); // matriz de segundos en la parte de arriba
  text(s,x,height/2+y/2); // matriz de segundos en la parte de abajo
  
  //se llenan las matrices de segundos cada segundo que pasa
  if(y < height+offsety){
    x = (int(s)%10)*(width/10);
    if(x == 0){
      y = (int(s)/10)*(height/6)+offsety;
    }
  }
  
  intensidad++; //cada segundo la intensidad sube
  
  delay(1000); // cada iteración del draw() se da en un segundo
}
