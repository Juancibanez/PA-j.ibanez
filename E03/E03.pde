int posXball = 75;
int posYball;
int posX = 60;
int bounds = 75;
int speedX = 5;
int speedY = 3;
int randomS = 2;
int speedLimit = 15;
int j;

void setup() {
  size(800, 600);
  frameRate(60);

  posYball = height / 2;  // Se inicializa correctamente
}

void draw() {
  background(0);
  noFill();
  stroke(255);
  strokeWeight(3);
  rect(25,25,width-50,height-50);
  
  strokeWeight(15);
  rect((width/2)-125,50,50,100);
  rect((width/2)+75,50,50,100);
  
  translate(-8,0);
  
  // Movimiento de la bola por frame
  posXball += speedX;
  posYball += speedY;

  // Colisión con las paredes laterales
  if (posXball >= width - bounds) {
    speedX *= -1;
    speedX -= random(randomS); // añade un valor random para velocidad luego de colisión
    //limites de velocidad baja y alta
    if (speedX <= 0.5 || speedX >= -0.5) speedX = -2;
    if (speedX <= speedLimit) speedX = -5;
  } 
  else if (posXball <= bounds) {
    speedX *= -1;
    speedX += random(randomS); // añade un valor random para velocidad luego de colisión
    //limites de velocidad baja y alta
    if (speedX <= 0.5 || speedX >= -0.5) speedX = 2;
    if (speedX >= -speedLimit) speedX = 5;
  }

  // Colisión con las paredes superior e inferior
  if (posYball >= height - bounds) {
    speedY *= -1;
    speedY -= random(randomS); // añade un valor random para velocidad luego de colisión
    //limites de velocidad baja y alta
    if (speedY <= 0.5 || speedY >= -0.5) speedY = -2;
    if (speedX <= speedLimit) speedY = -3;
  }
  else if (posYball <= bounds) {
    speedY *= -1;
    speedY += random(randomS); // añade un valor random para velocidad luego de colisión
    //limites de velocidad baja y alta
    if (speedY <= 0.5 || speedY >= -0.5) speedY = 2;
    if (speedX >= -speedLimit) speedY = 3;
  }

  noStroke();
  fill(255);
  
  for(j=50;j<height-50;j+=20){
    rect(width/2, j, 5, 10);
  }
  
  translate(0,-10);
  // Dibujar la bola y las paletas
  square(posXball, posYball, 15);
  
  translate(0,-30);
  rect(posX, posYball, 15, 75);  // Simulación de la paleta izquierda
  rect(width - posX, posYball, 15, 75); // Simulación de la paleta derecha
}
