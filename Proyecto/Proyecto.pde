// Juan Camilo Ibáñez - 201924835

//Propuesta de diseño: la deshumanización de las personas por medio de los datos de algoritmos empresariales.

//datos sacados de https://www.kaggle.com/datasets/arpitsinghaiml/youtube-user-by-country-2025/data

import processing.sound.*;

// Variables relacionadas con los datos
Table table;    // Tabla para almacenar los datos cargados desde CSV
int nSamples;      // Número de filas/muestras en la tabla
float[] totalUsers;    // Arreglo que almacena la cantidad de usuarios por país

// Variables generales
float x;   // Variable auxiliar, no utilizada en este fragmento

PFont font;  // Fuente utilizada para el texto

// Control de escenas
int currentScene = 0;  // Índice de la escena actual
int nextScene = 0;   // Índice de la siguiente escena durante una transición
float alpha = 0;   // Nivel de opacidad para efecto de fundido
boolean transitioning = false; // Indica si hay una transición en curso
boolean fadingOut = true;  // Indica si estamos en la fase de fundido de salida
float fadeSpeed = 5;  // Velocidad de cambio de opacidad

// Control de zoom
float zoom = 1.0;   // Escala de zoom para la escena actual
boolean zoomingOut = false; // Bandera para controlar si se está haciendo zoom out

// Modos de transición entre escenas
int transitionMode = 0;    // 0: Fundido, 1: Zoom out, 2: Zoom inverso
float sceneTransitionZoom = 1.0;  // Escala usada durante el zoom out entre escenas
float sceneTransitionZoomSpeed = 0.025; // Velocidad del zoom out

// Transición de entrada estilo "aterrizaje" para la escena 3 (SceneThree)
float sceneEntryZoom = 5;  // Escala inicial de entrada de escena
float sceneEntryZoomTarget = 1;  // Escala objetivo al finalizar el aterrizaje
float sceneEntryZoomSpeed = 0.035; // Velocidad de "encogimiento"

// Arreglos de entidades visuales
Person[] people;   // Arreglo de personas que se mueven por la pantalla
int numPersonas = 40;   // Número total de personas

Piedra[] piedras;    // Arreglo de piedras decorativas
int numPiedras = 7;   // Número de piedras en escena

// Archivos de sonido
SoundFile snd1;     // Sonido ambiental para la escena 1
SoundFile snd2;     // Sonido para la escena 2

// --- FUNCIONES PRINCIPALES ---

void setup() {
  size(800, 600);
  textAlign(CENTER);
  
  font = createFont("Courier New Bold", 32);
  textFont(font);
  textAlign(CENTER, CENTER);

  // Cargar sonidos
  snd1 = new SoundFile(this, "PedestriansSound.mp3");
  snd2 = new SoundFile(this, "DATASound.mp3");

  // Cargar datos de usuarios de YouTube desde archivo CSV
  table = loadTable("youtube2025.csv", "header");
  nSamples = table.getRowCount();
  totalUsers = new float[nSamples];

  for (int i = 0; i < nSamples; i++) {
    totalUsers[i] = table.getFloat(i, "YouTubeUsers_TotalUsers_Num_2024Feb");
  }

  // Inicializar personas con posiciones y colores aleatorios
  people = new Person[numPersonas];
  for (int i = 0; i < people.length; i++) {
    people[i] = new Person(random(width), random(-25,height));
  }

  // Inicializar piedras con posiciones y formas aleatorias
  piedras = new Piedra[numPiedras];
  for (int i = 0; i < numPiedras; i++) {
    piedras[i] = new Piedra(random(width), random(-25,height));
  }

  // Iniciar sonido de la primera escena
  if (currentScene == 0 && snd1 != null) {
    snd1.loop();
  } else if (currentScene == 1 && snd2 != null) {
    snd2.loop();
  }
}

void draw() {
  
  // La implementación de transiciones entre escenas fue generada con inteligencia artificial
  if (transitioning) {
    if (transitionMode == 0) { // Transición por fundido

        if (fadingOut) {
            drawSceneContent(currentScene);
        } else {
            drawSceneContent(nextScene); 
        }
        fill(0, alpha);
        rect(0, 0, width, height);
        if (fadingOut) {
            alpha += fadeSpeed;
            if (alpha >= 255) {
                alpha = 255;
                currentScene = nextScene;
                manageSceneAudio(currentScene);
                fadingOut = false;       
                if (currentScene == 0 || currentScene == 2) {
                    resetZoom(); 
                }
            }
        } else { 
            alpha -= fadeSpeed;
            if (alpha <= 0) {
                alpha = 0;
                transitioning = false;
                fadingOut = true; 
            }
        }
    } else if (transitionMode == 1) { // Transición por zoom out de toda la escena
        drawSceneContent(0); 
        pushMatrix();
        translate(width/2, height/2);
        scale(sceneTransitionZoom); 
        translate(-width/2, -height/2);
        drawSceneContent(2); 
        popMatrix();
        sceneTransitionZoom -= sceneTransitionZoomSpeed;
        if (sceneTransitionZoom <= 0.01) { 
            sceneTransitionZoom = 1.0; 
            transitioning = false;
            currentScene = nextScene; 
            manageSceneAudio(currentScene);
            resetZoom(); 
            transitionMode = 0; 
        }
    } else if (transitionMode == 2) { // Transición inversa (zoom in hacia escena 3)

      // Dibuja la segunda escena (datos) como fondo.
      drawSceneContent(1); 
      // Dibuja la tercera escena (celular y su futuro contenido) encima, escalado.
      pushMatrix();
      translate(width/2, height/2);
      scale(sceneEntryZoom); // Escalar la tercera escena (empieza grande > 1.0, va hacia 1.0)
      translate(-width/2, -height/2);
      
      // Fuerza el zoom de contenido interno de la escena 3 a 1.0 durante esta transición de "aterrizaje",
      // porque es el celular entero el que se escala, no su contenido interno aún.
      float previousContentZoom = zoom; 
      zoom = 1.0; 
      drawSceneContent(2); // Dibuja tercera escena
      zoom = previousContentZoom; // Restaurar
      
      popMatrix();

      sceneEntryZoom -= sceneEntryZoomSpeed; // Encoger hacia el objetivo (2.5 a 1.0)
      if (sceneEntryZoom <= sceneEntryZoomTarget) {
        sceneEntryZoom = sceneEntryZoomTarget; // Asegurar que llegue a 1.0
        transitioning = false;
        currentScene = nextScene;
        manageSceneAudio(currentScene);// Se verifica que se llega a la tercera escena
        resetZoom(); // Asegura que el 'zoom' de contenido de SceneThree esté en 1.0 para su uso normal
      }
    }
  } else { // Si no hay transición, dibujar la escena actual normalmente
    drawSceneContent(currentScene);
  }

}

// Función auxiliar para dibujar el contenido de las escenas
void drawSceneContent(int sceneId) {
  switch(sceneId) {
    case 0: sceneOne(); break;
    case 1: sceneTwo(); break;
    case 2: sceneThree(); break;
  }
}

void keyPressed() { // Controla el cambio de escenas cuando se presiona la barra espaciadora
  if (key == ' ' && !transitioning) {
    int prevScene = currentScene;
    nextScene = (currentScene + 1) % 3;
    transitioning = true;

    if (prevScene == 2 && nextScene == 0) { // De la tercera a la primera escena (reinicio)
      transitionMode = 1; // zoom out
      sceneTransitionZoom = 1.0; // Inicia a escala 1 y se encoge
    } else if (prevScene == 1 && nextScene == 2) { // De la primera a la segunda escena
      transitionMode = 2; // zoom inverso
      sceneEntryZoom = 2.5; // Inicia grande y se encoge a 1.0
    } else {
      transitionMode = 0; // fade out para la escena 1 a la 2
      alpha = 0;
      fadingOut = true;
    }
  }
}

class Person {
  float x, y;
  float speed;
  color bodyColor;
  float userData;  // Valor de usuario (dato real "YouTubeUsers_TotalUsers_Num_2024Feb" del csv)

  Person(float x, float y) {
    this.x = x;
    this.y = y;
    this.speed = random(-5, 5);
    // tonos morados (mezcla de azul y rojo)
    bodyColor = color(random(120, 200), random(0, 80), random(120, 255));
    
    int index = int(random(nSamples));  // Escoge un índice aleatorio de totalUsers
    userData = totalUsers[index];
    
  }

  void update() { // Actualiza la posición horizontal de la persona.
    x += speed;
    if (x > width) x = -20;
  }

  void display() { // Dibuja la persona con cabeza y cuerpo (óvalos).
    stroke(0);
    strokeWeight(1);
    fill(#FDDDCA);  // cabeza rosada
    ellipse(x, y, 20, 20);  // cabeza
    fill(bodyColor);  // ropa morada
    ellipse(x, y + 25, 15, 30);  // cuerpo
  }
}

class Piedra {
  float x, y;   // Posición central de la piedra
  float[] w = new float[3];  // Anchos de los rectángulos
  float[] h = new float[3];   // Altos de los rectángulos
  color[] c = new color[3];   // Colores de cada parte de la piedra
  float[] offsetX = new float[3]; // Desplazamientos X
  float[] offsetY = new float[3]; // Desplazamientos Y
  float[] angle = new float[3];  // Rotación individual

  Piedra(float x, float y) {
    this.x = x;
    this.y = y;

    for (int i = 0; i < 3; i++) {
      w[i] = random(10, 28); // Anchos de los rectángulos
      h[i] = random(10, 28); // Altos de los rectángulos
      float greyTone = random(60, 160);
      c[i] = color(greyTone, greyTone, greyTone); // Tonos de gris
      
      // Pequeños desplazamientos para agrupar los rectángulos de una piedra
      if (i > 0) {
        offsetX[i] = random(-w[0]/3, w[0]/3);
        offsetY[i] = random(-h[0]/3, h[0]/3);
      } else {
        offsetX[i] = 0;
        offsetY[i] = 0;
      }
      angle[i] = random(-PI/12, PI/12); // Pequeña rotación
    }
  }

  void display() { // Dibuja la piedra en la pantalla como un grupo de rectángulos
    pushStyle(); // Aislar rectMode y otros estilos
    rectMode(CENTER);
    noStroke();
    for (int i = 0; i < 3; i++) {
      pushMatrix();
      translate(x + offsetX[i], y + offsetY[i]);
      rotate(angle[i]);
      fill(c[i]);
      rect(0, 0, w[i], h[i]);
      popMatrix();
    }
    popStyle(); // Restaura estilos
  }
}

void manageSceneAudio(int newSceneId) { // Cambia el loop de sonido de fondo según la escena activa
 
  // Detiene todos los sonidos que podrían estar reproduciéndose
  if (snd1 != null && snd1.isPlaying()) {
    snd1.stop();
  }
  if (snd2 != null && snd2.isPlaying()) {
    snd2.stop();
  }

  // Inicia el sonido para la nueva escena (si aplica)
  if (newSceneId == 0) { // Audio para SceneOne
    if (snd1 != null) { // Asegúrate de que el archivo de sonido se cargó correctamente
      snd1.loop(); // Inicia el sonido en bucle
    }
  } else if (newSceneId == 1) { // Audio para SceneTwo
    if (snd2 != null) {
      snd2.loop();
    }
  }
}

void sceneOne() {
  background(#87a1ab);
  
  // Dibujar piedras primero para que estén detrás de las personas y el texto
  for (Piedra pi : piedras) {
    pi.display();
  }
  
  // texto
  fill(#587B89);
  textSize(24);
  textAlign(CENTER, CENTER);
  text("[ presionar espacio para continuar ]",width/2,height/2);
  
  // Dibujar personas
  for (Person p : people) {
    p.update();
    p.display();
  }
}

void sceneTwo() {
  background(40);
  
  // texto
  fill(0);
  textSize(16);
  text("[ espacio ]",width-65,height-25);
  
  textAlign(CENTER, CENTER);
  textSize(14);
  fill(random(120, 200), random(0, 80), random(120, 255));
  
  for (Person p : people) {
    p.update();
    text(int(p.userData), p.x, p.y);  // Mostrar el número como dato
  }
}

void sceneThree() {
  background(#87a1ab); // Mismo color de fondo que la primera escena

  // Texto de ayuda
  pushStyle(); // Aislar textAlign y textSize para el texto de ayuda
  fill(#587B89);
  textSize(16);
  textAlign(RIGHT, BOTTOM); // Posicionar en esquina inferior derecha
  text("[ espacio ]", width - 15, height - 15);
  popStyle(); // Restaurar

  // Lógica del zoom de contenido interno de la escena
  if (currentScene == 2 && (!transitioning || (transitioning && transitionMode == 0 && fadingOut))) {
    zoom *= 0.98; 
    if (zoom < 0.05) {
      zoom = 0.05;
    }
  }

  // Inicio del "mundo del celular" que se escala con 'zoom'
  pushMatrix();
  translate(width/2, height/2); // Centrar
  scale(zoom);        // Aplicar zoom de contenido
  translate(-width/2, -height/2);  // Volver a coordenadas de canvas (pero todo está escalado)

  // Dibujar los datos (texto)
  textAlign(CENTER, CENTER); // Para los datos numéricos
  textSize(14);     // Tamaño base para los datos
  for (Person p : people) {
    fill(random(120, 200), random(0, 80), random(120, 255)); // Color del texto aleatorio
    text(int(p.userData), p.x, p.y); // Usar las posiciones x,y originales de Person
  }
  popMatrix(); // Fin del "mundo del celular" escalado
  noStroke();
  fill(160, 32, 240);
  circle(width/2, height+300, 1000); // cuerpo
  fill(#E0CBBE);
  circle(width/2 + 175, height/2 + 100, 300); // Parte de la mano
  drawPhone(); // Dibujar el marco del teléfono siempre
  fill(#FDDDCA);
  noStroke();
  ellipse(width/2 + 150, height/2 + 175, 200, 100); //pulgar
}

void resetZoom() {
  zoom = 1.0;
}

void drawPhone() {
  stroke(0);
  fill(40);
  strokeWeight(4);
  rect(width/2 - 150, height/2 - 275, 300, 550,15); //celular
  
  // logo instagram
  noFill();
  stroke(color(random(120, 200), random(0, 80), random(120, 255)));
  rect(width/2-50, height/2-50, 100, 100,15);
  circle(width/2, height/2, 50);
  circle(width/2+35, height/2-35, 5);
}
