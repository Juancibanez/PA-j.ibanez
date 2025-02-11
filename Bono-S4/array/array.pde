int[] arregloX;
int[] arregloY;
int x = 0;
int y = 0;

void setup(){
 size(500,500);
 background(0);
 noStroke();
 
 arregloX = new int[8];
 arregloY = new int[8];
 
 while(y<arregloY.length){
   x = 0;
   arregloY[y] = int(random(height));
   while(x<arregloX.length){
     arregloX[x] = int(random(width));
     ellipse(arregloX[x],arregloY[y],50,50);
     x++;
   }
  y++;
 }
 
}
