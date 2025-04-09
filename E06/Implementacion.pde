import processing.sound.*;

ArrayList<Escena> escenas;
int escenaActual = 0;
int escenaAnterior = 0;

PFont font;

float alpha = 0;
boolean transicionando = false; //si está haciendo una transición
int transicionDuracion = 30; // frames de duración
int transicionContador = 0;

int tiempoUltimaEscena = 0;
int esperaEntreEscenas = 4000; // milisegundos para esperar entre escenas

PImage img1, img2, img3, img4, img5, img6, img7, img8, img9, img10, img11, img12;
SoundFile snd1, snd2, snd3, snd4, snd5, snd6, snd7, snd8, snd9, snd10, snd11, snd12;

void setup() {
  size(600, 750);
  
  font = createFont("Book Antiqua", 32); //fuente a usar
  escenas = new ArrayList<Escena>(); //lista de escenas en la narrativa

  img1 = loadImage("Shrek1.png");
  img2 = loadImage("Shrek2.png");
  img3 = loadImage("Shrek3.png");
  img4 = loadImage("Shrek4.png");
  img5 = loadImage("Shrek5.png");
  img6 = loadImage("Shrek6.png");
  img7 = loadImage("Shrek7.png");
  img8 = loadImage("Shrek8.png");
  img9 = loadImage("Shrek9.png");
  img10 = loadImage("Shrek10.png");
  img11 = loadImage("Shrek11.png");
  img12 = loadImage("Shrek12.png");

  snd1 = new SoundFile(this, "Shrek1.mp3");
  snd2 = new SoundFile(this, "Shrek2.mp3");
  snd3 = new SoundFile(this, "Shrek3.mp3");
  snd4 = new SoundFile(this, "Shrek4.mp3");
  snd5 = new SoundFile(this, "Shrek5.mp3");
  snd6 = new SoundFile(this, "Shrek6.mp3");
  snd7 = new SoundFile(this, "Shrek7.mp3");
  snd8 = new SoundFile(this, "Shrek8.mp3");
  snd9 = new SoundFile(this, "Shrek9.mp3");
  snd10 = new SoundFile(this, "Shrek10.mp3");
  snd11 = new SoundFile(this, "Shrek11.mp3");
  snd12 = new SoundFile(this, "Shrek12.mp3");

  escenas.add(new Escena("Pulsa ´→´ o ´Enter´ \n para continuar", img1, snd1));
  escenas.add(new Escena("Había una vez una \n encantadora princesa", img2, snd2));
  escenas.add(new Escena("Pero estaba condenada\n por un hechizo", img3, snd3));
  escenas.add(new Escena("Que sólo podía romperse\n con el primer beso\n de su verdadero amor", img4, snd4));
  escenas.add(new Escena("La habían encerrado en un castillo", img5, snd5));
  escenas.add(new Escena("Que vigilaba un \n dragón que escupía fuego", img6, snd6));
  escenas.add(new Escena("Muchos valientes caballeros\n habían intentado liberarla \nde esa sombría prisión", img7, snd7));
  escenas.add(new Escena("Pero ninguno lo había logrado", img8, snd8));
  escenas.add(new Escena("Y custodiada por el dragón, \n en lo más alto de la torre…", img9, snd9));
  escenas.add(new Escena("Esperaba por el primer beso \n de su verdadero amor.", img10, snd10));
  escenas.add(new Escena("Como si esas cosas pasaran.", img11, snd11));
  escenas.add(new Escena("Esto es pura...", img12, snd12));
  
  textFont(font);
  textAlign(CENTER, CENTER);

  escenas.get(0).reproducir(); //reproduce el audio de la primera escena
}

void draw() {
  if (transicionando) { //proceso de transición entre escenas para las imágenes
    float progreso = map(transicionContador, 0, transicionDuracion, 0, 1);
    
    PImage imgAnt = escenas.get(escenaAnterior).img;
    PImage imgAct = escenas.get(escenaActual).img;

    tint(255, 255 * (1 - progreso));
    image(imgAnt, 0, 0, width, height);

    tint(255, 255 * progreso);
    image(imgAct, 0, 0, width, height);

    noTint();

    //proceso de transición entre escenas para el texto
    if (escenaActual < escenas.size() - 2) {
      fill(#FFDF00, 255 * progreso);
      text(escenas.get(escenaActual).texto, width / 2, height-125);
    }

    transicionContador++; //determina el estado de la transición
    if (transicionContador >= transicionDuracion) {
      transicionando = false;
      transicionContador = 0;
    }

  } else { //Cuando no hay una transición activa se muestran los elementos estáticamente
    image(escenas.get(escenaActual).img, 0, 0, width, height);
    // Muestra el texto para todas las escenas excepto las últimas dos
    if (escenaActual < escenas.size() - 2) {
      fill(#FFDF00);
      text(escenas.get(escenaActual).texto, width / 2, height-125);
    }
  }
}

void keyPressed() {
  int tiempoActual = millis();
  //Si se pulsa enter o flecha a la derecha se cambia de escena.
  //No se puede activar esta opción hasta que hayan pasado 4 segundos desde el
  //último cambio de escena.
  if (!transicionando && (keyCode == RIGHT || key == ENTER) && tiempoActual - tiempoUltimaEscena > esperaEntreEscenas) {
    escenaAnterior = escenaActual;
    escenaActual++;
    if (escenaActual >= escenas.size()) {
      escenaActual = escenas.size() - 1;
    }
    escenas.get(escenaActual).reproducir();
    transicionando = true;
    transicionContador = 0;
    tiempoUltimaEscena = tiempoActual;
  }
}

//Cada escena debe tener una imagen, texto y audio
class Escena {
  String texto;
  PImage img;
  SoundFile audio;

  Escena(String texto, PImage img, SoundFile audio) {
    this.texto = texto;
    this.img = img;
    this.audio = audio;
  }

  void reproducir() { //método para reproducir el audio correspondiente
    audio.play();
  }
}
