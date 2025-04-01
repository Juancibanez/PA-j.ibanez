Gato myCat;
Perro myDog;
Elefante myEleph;

void setup(){
  size(800,800);
  frameRate(180);
  myDog = new Perro(color(1,1,1),10,50,5,10);
  myCat = new Gato(color(255,100,100),width/2,0,10,10);
  myEleph = new Elefante(color(100),width-50,height/2,10,10);
}

void draw(){
  background(255);
  
  myDog.display();
  myDog.run();
  myDog.ladrar();
  
  myCat.display();
  myCat.run();
  myCat.maullar();
  
  myEleph.display();
  myEleph.caminarDeLado();
  
  delay(5);
  
}

class Mamifero{
 
  color C;
  float PosX;
  float PosY;
  float Speed;
  
  Mamifero(color C, float PosX, float PosY, float Speed){
    this.C = C;
    this.PosX = PosX;
    this.PosY = PosY;
    this.Speed = Speed;
  }
  
  void display(){
    stroke(0);
    fill(C);
    ellipse(PosX,PosY,50,50);
  }
  
  void run(){
   PosY += Speed;
   if(PosY > height || PosY < 0){
    Speed *= -1; 
   }
  }  
}

class Perro extends Mamifero{
  float lengthTail;
  Perro(color C, float PosX, float PosY, float Speed, float lengthTail){
    super(C, PosX, PosY, Speed);
    this.lengthTail = lengthTail;
  }
  
  void ladrar(){
    println("Wow");
  }
}

class Gato extends Mamifero{
  float lengthNails;
  Gato(color C, float PosX, float PosY, float Speed, float lengthNails){
    super(C, PosX, PosY, Speed);
    this.lengthNails = lengthNails;
  }
  
  void maullar(){
    println("Meow");
  }
}

class Elefante extends Mamifero{
  float lengthTail;
  Elefante(color C, float PosX, float PosY, float Speed, float lengthTail){
    super(C, PosX, PosY, Speed);
    this.lengthTail = lengthTail;
  }
  
  void caminarDeLado(){
    PosX+=Speed;
    if(PosX > width || PosX < 0){
      Speed *= -1; 
   }
  }
}
