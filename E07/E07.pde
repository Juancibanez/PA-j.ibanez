//datos sacados de https://www.kaggle.com/datasets/arpitsinghaiml/youtube-user-by-country-2025/data

Table table;
int nSamples;
float[] totalUsers;
String[] country;

PFont font;

FallingText[] fallingTexts;

void setup(){
  
  font = createFont("Haettenschweiler", 24); //fuente a usar
  textFont(font);
  
  size(1000, 600);
  textAlign(CENTER);
  background(0);
  noStroke();
  
  table = loadTable("youtube2025.csv", "header");
  nSamples = table.getRowCount();
  
  totalUsers = new float[nSamples]; //usuarios por país
  country = new String[nSamples]; //país
  fallingTexts = new FallingText[nSamples];
  
  //Configuración de la tabla (usuarios de YouTube) y la colunmna a usar (Country)

  for(int i = 0; i < nSamples; i++){
    totalUsers[i] = table.getFloat(i, "YouTubeUsers_TotalUsers_Num_2024Feb");
    country[i] = table.getString(i, "country");
    
    //En un inicio la tabla se mapea cantidad de usuarios por país
    float x = map(i, 0, nSamples, 10, width);
    
    //Cada país es una instancia de "fallingTexts"
    fallingTexts[i] = new FallingText(country[i], x, random(-100, 0));
  }
}

void draw(){
  
  fill(0, 30); // negro con alpha bajo
  rect(0, 0, width, height); // Fondo semitransparente para dejar el rasto
  
  fill(200);
  //triángulo estático
  triangle((width/2)-15,(height/2)+20, (width/2)-15, (height/2)-20, (width/2)+20, (height/2));
  
  //acción por frame de los textos
  for (int i = 0; i < nSamples; i++){
    fallingTexts[i].update();
    fallingTexts[i].display();
  }
}

class FallingText { //clase que define cómo se ven los paises
  String word;
  float x;
  float y;
  float speed = 15;

  FallingText(String word, float x, float y){
    this.word = word;
    this.x = x;
    this.y = y;
  }

  void update(){
    y += speed; //en cada iteración las letras bajan a una velocidad dada
    if (y > height + word.length()*14) {
      y = random(-100, 0); //reinicio de posición de las palabras
    }
  }

  void display(){ //En esta parte me ayudé con inteligencia artificial
    for (int i = 0; i < word.length(); i++){
      float yPos = y + i * 14;

      if (yPos < height) {
        // Las letras se van apagando contransparencia de abajo hacia arriba (rastro)
        fill(random(150,255), 0, 0, 100);
        text(word.charAt(i), x, yPos);
      }
    }
    
    // Se define la última letra del país como la más brillante para darle contraste
    int lastIndex = word.length() - 1;
    float lastY = y + lastIndex * 14;
    if (lastY < height) {
      fill(random(150,255), random(100), random(100)); // rojo brillante y aleatorio
      text(word.charAt(lastIndex), x, lastY);
    }
  }
}
