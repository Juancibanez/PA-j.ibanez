Cat myCat;
Dog myDog;

void setup(){
  size(800,800);
  myCat = new Cat(color(255,100,100),width/2,0,10);
  myDog = new Dog(color(1,1,1),10,50,5);
}

void draw(){
  background(255);
  myCat.display();
  myCat.run();
  
  myDog.display();
  myDog.run();
  
}

class Cat{
  
  color C;
  float PosX;
  float PosY;
  float Speed;
  
  Cat(color C, float PosX, float PosY, float Speed){
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

class Dog{
  
  color C;
  float PosX;
  float PosY;
  float Speed;
  
  Dog(color C, float PosX, float PosY, float Speed){
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
