//algoritmo para saber si se puede abrir una puerta

int distancia; //distancia entre la persona y la puerta
boolean disponibilidad; //disponibilidad de manos de la persona

distancia = 7;
disponibilidad = true;

if(distancia > 5 || !disponibilidad) {print("No se puede abrir la puerta");}
else if(distancia <= 5 && disponibilidad) {print("Se puede abrir la puerta");}

//if(distancia > 5 || !disponibilidad) print("No se puede abrir la puerta");
//else print("Se puede abrir la puerta");
