// Juan Camilo Ibáñez - 201924835
//datos sacados de https://www.kaggle.com/datasets/arpitsinghaiml/youtube-user-by-country-2025/data

import processing.sound.*;

Table table;
int nSamples;
float[] totalUsers;

float x;

PFont font;

int currentScene = 0;
int nextScene = 0;
float alpha = 0;
boolean transitioning = false;
boolean fadingOut = true;
float fadeSpeed = 5;

float zoom = 1.0;
boolean zoomingOut = false;

int transitionMode = 0; // 0 para Fundido (Fade), 1 para Zoom Out de Escena
float sceneTransitionZoom = 1.0; // Para el efecto de zoom out de toda la escena
float sceneTransitionZoomSpeed = 0.025; // Velocidad del zoom out de escena (ajusta)

float sceneEntryZoom = 2.5; // Zoom inicial para la entrada de escena (más grande que la pantalla)
float sceneEntryZoomTarget = 1.0;
float sceneEntryZoomSpeed = 0.035; // Velocidad de "encogimiento", ajusta si es necesario

Person[] people;
int numPersonas = 40;

Piedra[] piedras;
int numPiedras = 7; // Ajusta la cantidad

void setup() {
  size(800, 600);
  textAlign(CENTER);
  
  font = createFont("Courier New Bold", 32); //fuente a usar
  textFont(font);
  textAlign(CENTER, CENTER);

  // Primero carga los datos
  table = loadTable("youtube2025.csv", "header");
  nSamples = table.getRowCount();
  totalUsers = new float[nSamples];

  for (int i = 0; i < nSamples; i++) {
    totalUsers[i] = table.getFloat(i, "YouTubeUsers_TotalUsers_Num_2024Feb");
  }

  people = new Person[numPersonas];
  for (int i = 0; i < people.length; i++) {
    people[i] = new Person(random(width), random(-25,height));
  }
  
  piedras = new Piedra[numPiedras];
  for (int i = 0; i < numPiedras; i++) {
    // Distribuir piedras, quizás más en la parte inferior para simular suelo
    piedras[i] = new Piedra(random(width), random(-25,height));
  }
  
}

void draw() {
  if (transitioning) {
    if (transitionMode == 0) { // MODO FUNDIDO (FADE)
      // ... (tu código de FADE existente y correcto está aquí) ...
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
    } else if (transitionMode == 1) { // MODO ZOOM OUT DE ESCENA (SceneThree a SceneOne)
      // ... (tu código de ZOOM OUT DE ESCENA existente y correcto está aquí) ...
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
            resetZoom(); 
            transitionMode = 0; 
        }
    } else if (transitionMode == 2) { // NUEVO: MODO ZOOM "INVERSO" (SceneTwo a SceneThree)
      // currentScene es 1 (SceneTwo), nextScene es 2 (SceneThree)

      // 1. Dibuja SceneTwo (datos) como fondo.
      drawSceneContent(1); 

      // 2. Dibuja SceneThree (celular y su futuro contenido) encima, escalado.
      //    SceneThree dibujará su propio fondo (#87a1ab), cubriendo SceneTwo a medida que "aterriza".
      pushMatrix();
      translate(width/2, height/2);
      scale(sceneEntryZoom); // Escalar SceneThree (empieza grande > 1.0, va hacia 1.0)
      translate(-width/2, -height/2);
      
      // Forzamos el zoom de contenido interno de SceneThree a 1.0 durante esta transición de "aterrizaje",
      // porque es el celular entero el que se escala, no su contenido interno aún.
      float previousContentZoom = zoom; 
      zoom = 1.0; 
      drawSceneContent(2); // Dibuja SceneThree
      zoom = previousContentZoom; // Restaurar (aunque resetZoom() lo ajustará al final si es necesario)
      
      popMatrix();

      sceneEntryZoom -= sceneEntryZoomSpeed; // Encoger hacia el objetivo
      if (sceneEntryZoom <= sceneEntryZoomTarget) {
        sceneEntryZoom = sceneEntryZoomTarget; // Asegurar que llegue a 1.0
        transitioning = false;
        currentScene = nextScene; // Oficialmente estamos en SceneThree
        resetZoom(); // Asegura que el 'zoom' de contenido de SceneThree esté en 1.0 para su uso normal
        // transitionMode = 0; // No es necesario resetear aquí, la próxima transición lo definirá
      }
    }
  } else { // No hay transición, dibujar la escena actual normalmente
    drawSceneContent(currentScene);
  }
  // EL BLOQUE DUPLICADO YA DEBERÍA HABER SIDO ELIMINADO DE AQUÍ
}

// Función auxiliar para dibujar el contenido de las escenas
void drawSceneContent(int sceneId) {
  switch(sceneId) {
    case 0: 
      sceneOne(); 
      break;
    case 1: 
      sceneTwo(); 
      break;
    case 2: 
      sceneThree(); 
      break;
    default:
      // Opcional: manejar un caso desconocido, aunque no debería ocurrir
      // con la lógica actual.
      // println("Error: Intentando dibujar una escena desconocida: " + sceneId);
      break;
  }
}

void keyPressed() {
  if (key == ' ' && !transitioning) {
    int prevScene = currentScene;
    nextScene = (currentScene + 1) % 3;
    transitioning = true;

    if (prevScene == 2 && nextScene == 0) { // De SceneThree (2) a SceneOne (0)
      transitionMode = 1; // ZOOM OUT DE ESCENA (SceneThree se encoge)
      sceneTransitionZoom = 1.0; // Inicia a escala 1 y se encoge
    } else if (prevScene == 1 && nextScene == 2) { // De SceneTwo (1) a SceneThree (2)
      transitionMode = 2; // ZOOM "INVERSO" DE CELULAR A ESCENA (SceneThree "aterriza")
      sceneEntryZoom = 2.5; // Inicia grande y se encoge a 1.0
    } else { // Para la transición restante (0->1)
      transitionMode = 0; // FUNDIDO (FADE)
      alpha = 0;
      fadingOut = true;
    }
  }
}

class Person {
  float x, y;
  float speed;
  color bodyColor;
  float userData;  // Valor de usuario (dato real)

  Person(float x, float y) {
    this.x = x;
    this.y = y;
    this.speed = random(-5, 5);
    // tonos morados (mezcla de azul y rojo)
    bodyColor = color(random(120, 200), random(0, 80), random(120, 255));
    
    int index = int(random(nSamples));  // Escoge un índice aleatorio de totalUsers
    userData = totalUsers[index];
    
  }

  void update() {
    x += speed;
    if (x > width) x = -20;
  }

  void display() {
    stroke(0);
    fill(#FDDDCA);  // cabeza rosada
    ellipse(x, y, 20, 20);       // cabeza
    fill(bodyColor);            // ropa morada
    ellipse(x, y + 25, 15, 30);  // cuerpo
  }
}

class Piedra {
  float x, y; // Posición central de la piedra
  float[] w = new float[3];
  float[] h = new float[3];
  color[] c = new color[3];
  float[] offsetX = new float[3];
  float[] offsetY = new float[3];
  float[] angle = new float[3];

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

  void display() {
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
    popStyle(); // Restaurar estilos
  }
}

void sceneOne() {
  background(#87a1ab);
  
  // Dibujar piedras primero para que estén detrás de las personas y el texto
  for (Piedra pi : piedras) {
    pi.display();
  }
  
  fill(#587B89);
  textSize(24);
  textAlign(CENTER, CENTER); // Asegúrate que esto esté antes de text()
  text("[ presionar espacio para continuar ]",width/2,height/2);
  
  // Dibujar personas
  for (Person p : people) {
    p.update();
    p.display();
  }
}

void sceneTwo() {
  background(0);
  
  fill(50);
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
  background(#87a1ab); // Mismo color de fondo que sceneOne

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
  scale(zoom);                   // Aplicar zoom de contenido
  translate(-width/2, -height/2);  // Volver a coordenadas de canvas (pero todo está escalado)

  // Dibujar los datos (texto)
  textAlign(CENTER, CENTER); // Para los datos numéricos
  textSize(14);             // Tamaño base para los datos
  for (Person p : people) {
    // p.update(); // Descomenta si quieres que los datos se muevan dentro del celular
    fill(random(120, 200), random(0, 80), random(120, 255)); // Color del texto aleatorio
    text(int(p.userData), p.x, p.y); // Usar las posiciones x,y originales de Person
  }
  popMatrix(); // Fin del "mundo del celular" escalado
  noStroke();
  fill(#FDDDCA, 200); // Mano un poco transparente
  circle(width/2 + 175, height/2 + 100, 300); // Parte de la mano
  // Dibujar el teléfono y la mano
  drawPhone(); // Dibujar el marco del teléfono siempre
  fill(#FDDDCA);
  ellipse(width/2 + 150, height/2 + 175, 200, 100); // Dedos/pulgar
}

void resetZoom() {
  zoom = 1.0;
}

void drawPhone() {
  stroke(0);
  fill(75);
  strokeWeight(4);
  rect(width/2 - 150, height/2 - 275, 300, 550,15);
  strokeWeight(1);
}
