//fondo
size(500,500);
background(66, 103, 210);

noStroke();

fill(52, 168, 83);
triangle(0, 500, 500, 0, 500, 500);

//oreja atrás
fill(170);
triangle(220, 100, 250, 140, 220, 200);

//cabeza
fill(225);
ellipse(250,250,250,250);

//oreja izquierda
beginShape();
fill(250);
vertex(100, 250);
vertex(200, 100);
vertex(220, 100);
vertex(220, 200);
vertex(150, 270);
endShape();

//oreja derecha
beginShape();
fill(250);
vertex(270, 130);
vertex(255, 50);
vertex(270, 0);
vertex(320, 0);
vertex(335, 30);
vertex(320, 150);
endShape();

//nariz
fill(80);
ellipse(250,275,50,40);

//bigotes
stroke(255);
strokeWeight(3);
line(300, 260, 400, 250);
line(295, 270, 410, 270);
line(300, 280, 400, 290);

line(200, 260, 120, 250);
line(205, 270, 90, 270);
line(200, 280, 100, 290);

//boca
stroke(80);
noFill();
curve(200,270,265,300, 280,300,300,270);
