// Juan Camilo Ibáñez - 201924835
//datos sacados de https://www.kaggle.com/datasets/arpitsinghaiml/youtube-user-by-country-2025/data

Table table;
int nSamples;
float[] totalUsers;

float x;

int currentScene = 0;
int nextScene = 0;
float alpha = 0;
boolean transitioning = false;
boolean fadingOut = true;
float fadeSpeed = 5;

float zoom = 1.0;
boolean zoomingOut = false;

Person[] people;

void setup() {
  size(800, 600);
  textAlign(CENTER);

  // Primero carga los datos
  table = loadTable("youtube2025.csv", "header");
  nSamples = table.getRowCount();
  totalUsers = new float[nSamples];

  for (int i = 0; i < nSamples; i++) {
    totalUsers[i] = table.getFloat(i, "YouTubeUsers_TotalUsers_Num_2024Feb");
  }

  people = new Person[25];
  for (int i = 0; i < people.length; i++) {
    people[i] = new Person(random(width), random(height));
  }
}

void draw() {
  background(50); // O el color que prefieras por defecto antes de que las escenas dibujen

  // Mostrar la escena actual
  switch(currentScene) {
    case 0:
      sceneOne();
      break;
    case 1:
      sceneTwo();
      break;
    case 2:
      sceneThree();
      break;
  }

  // Si hay transición, dibujar el fade
  if (transitioning) {
    fill(0, alpha);
    rect(0, 0, width, height);

    if (fadingOut) {
      alpha += fadeSpeed;
      if (alpha >= 255) {
        alpha = 255;
        currentScene = nextScene;
        fadingOut = false;
        // Si la nueva escena es la 0 (sceneOne), resetea el zoom.
        if (currentScene == 0) {
            resetZoom();
        }
      }
    } else { // Fading In
      alpha -= fadeSpeed;
      if (alpha <= 0) {
        alpha = 0;
        transitioning = false;
        fadingOut = true;
      }
    }
  }


  // Si hay transición, dibujar el fade
if (transitioning) {
    fill(0, alpha);
    rect(0, 0, width, height);

    if (fadingOut) {
      alpha += fadeSpeed;
      if (alpha >= 255) {
        // cambio de escena una vez pantalla está completamente negra
        currentScene = nextScene;
        fadingOut = false;
      }
    } else {
      alpha -= fadeSpeed;
      if (alpha <= 0) {
        alpha = 0;
        transitioning = false;
        fadingOut = true;
      }
    }
  }
}

void keyPressed() {
  if (key == ' ' && !transitioning) { // Solo si no hay una transición en curso
    nextScene = (currentScene + 1) % 3;

    if (currentScene == 0 && nextScene == 1) { // De Escena 0 a Escena 1
      transitioning = true;
      alpha = 0;
      fadingOut = true;
    } else if (currentScene == 2 && nextScene == 0) { // De Escena 2 (sceneThree) a Escena 0 (sceneOne)
      // Esta es la transición que quieres activar con espacio desde sceneThree
      transitioning = true;
      alpha = 0;
      fadingOut = true;
      // resetZoom() será llamado por la lógica en draw() cuando currentScene se vuelva 0
    } else {
      // Para otras transiciones (ej. Escena 1 a Escena 2), cambio instantáneo
      currentScene = nextScene;
      // No se necesita resetZoom() aquí porque la escena 2 no lo usa al inicio
      // y la escena 0 ya se maneja arriba y en draw().
    }
  }
}

void sceneOne() {
  background(#87a1ab);
  for (Person p : people) {
    p.update();
    p.display();
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
    fill(255, 100, 100);  // cabeza rosada
    ellipse(x, y, 20, 20);       // cabeza
    fill(bodyColor);            // ropa morada
    ellipse(x, y + 25, 15, 30);  // cuerpo
  }
}

void sceneTwo() {
  background(0);
  textAlign(CENTER, CENTER);
  textSize(14);
  fill(random(120, 200), random(0, 80), random(120, 255));
  
  for (Person p : people) {
    p.update();
    text(int(p.userData), p.x, p.y);  // Mostrar el número como dato
  }
}

void sceneThree() {
  background(0);

  pushMatrix();
  translate(width/2, height/2);
  scale(zoom); // Aplicar el zoom actual
  translate(-width/2, -height/2);

  for (Person p : people) {
    fill(random(120, 200), random(0, 80), random(120, 255));
    rect(p.x, p.y, 10, 10);
  }
  popMatrix();

  // Continuar el efecto de zoom out si no estamos en medio de una transición de salida
  if (!transitioning) {
    zoom *= 0.98;
    // Opcional: poner un límite al zoom para que no se vuelva demasiado pequeño
    if (zoom < 0.05) { // Un valor pequeño, ajusta según sea necesario
        zoom = 0.05;
    }
  }

  // Dibujar el marco del teléfono si el zoom es lo suficientemente pequeño
  // Esto permitirá que se vea incluso si la escena está haciendo un fade out
  if (zoom < 0.3) {
    drawPhoneFrame();
  }
  // Ya NO hay transición automática desde aquí
}

void resetZoom() {
  zoom = 1.0;
}

void drawPhoneFrame() {
  stroke(255);
  noFill();
  strokeWeight(4);
  rect(width/2 - 150, height/2 - 300, 300, 600);
  strokeWeight(1);
}
