import processing.sound.*;

ArrayList<Escena> escenas;
int escenaActual = 0;

void setup() {
  size(800, 600);
  escenas = new ArrayList<Escena>();

  escenas.add(new Escena("Había una vez una encantadora princesa"));
  escenas.add(new Escena("Pero estaba condenada por un hechizo"));
  escenas.add(new Escena("Que sólo podía romperse con el primer beso de su verdadero amor"));
  escenas.add(new Escena("La habían encerrado en un castillo"));
  escenas.add(new Escena("Que vigilaba un dragón que escupía fuego"));
  escenas.add(new Escena("Muchos valientes caballeros habían intentado liberarla de esa sombría prisión"));
  escenas.add(new Escena("Pero ninguno lo había logrado"));
  escenas.add(new Escena("Y custodiada por el dragón, en lo más alto de la torre…"));
  escenas.add(new Escena("Esperaba por el primer beso de su verdadero amor."));
  escenas.add(new Escena("¡IRRUMPE SHREK!", true)); // acción especial
  
  textAlign(CENTER, CENTER);
  textSize(28);
}

void draw() {
  background(0);
  escenas.get(escenaActual).mostrar();
}

void keyPressed() {
  if (keyCode == RIGHT || key == ENTER) {
    escenaActual++;
    if (escenaActual >= escenas.size()) {
      escenaActual = escenas.size() - 1;
    }
  }
}

void mousePressed() {
  
}

// Clase Escena
class Escena {
  String texto;
  PImage img;
  SoundFile audio;

  Escena(String texto, PImage img, SoundFile audio) {
    this.texto = texto;
    this.img = img;
    this.audio = audio;
  }

  void mostrar() {
    fill(255);
    text(texto, width / 2, height / 2);
  }

}
