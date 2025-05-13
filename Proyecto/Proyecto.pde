// Juan Camilo Ibáñez - 201924835

int currentScene = 0;
int nextScene = 0;
float alpha = 0;
boolean transitioning = false;
boolean fadingOut = true;
float fadeSpeed = 5;

float zoom = 1.0;
boolean zoomingOut = false;

Person[] people;

void draw() {
  background(255);

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
  if (key == ' ' && !transitioning) {
    nextScene = (currentScene + 1) % 3;

    // Solo aplicar transición entre escena 0 y 1
    if (currentScene == 0 && nextScene == 1) {
      transitioning = true;
      alpha = 0;
      fadingOut = true;
    } else {
      currentScene = nextScene;
      if (currentScene == 0) {
        resetZoom(); // volver a zoom normal si pasamos de escena 2 a 0
      }
    }
  }
}



void setup() {
  size(800, 600);
  people = new Person[10];
  for (int i = 0; i < people.length; i++) {
    people[i] = new Person(random(width), random(height));
  }
}

void sceneOne() {
  background(200, 200, 255);
  for (Person p : people) {
    p.update();
    p.display();
  }
}

class Person {
  float x, y;
  float speed;
  color bodyColor;

  Person(float x, float y) {
    this.x = x;
    this.y = y;
    this.speed = random(1, 3);
    // tonos morados (mezcla de azul y rojo)
    bodyColor = color(random(120, 200), random(0, 80), random(120, 255));
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
  for (Person p : people) {
    p.update();
    fill(0, 255, 0);
    rect(p.x, p.y, 10, 10);  // Representa datos
  }
}

void sceneThree() {
  background(0);

  // Zoom-out
  pushMatrix();
  translate(width/2, height/2);
  scale(zoom);
  translate(-width/2, -height/2);

  for (Person p : people) {
    fill(0, 255, 0);
    rect(p.x, p.y, 10, 10);
  }
  popMatrix();

  zoom *= 0.98;

  if (zoom < 0.3) {
    drawPhoneFrame();
    delay(500);  // pequeña pausa para el efecto
    currentScene = 0;  // regresar al inicio
    resetZoom();
  }
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
