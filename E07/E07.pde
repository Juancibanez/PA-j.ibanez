Table table;
int nSamples;
float[] totalUsers;
String[] country;

void setup(){
  size(1920,500);

  textAlign(CENTER);

  table = loadTable("youtube2025.csv", "header");

  nSamples = table.getRowCount();
  
  totalUsers = new float[nSamples];
  country = new String[nSamples];

  for(int i = 0; i<nSamples; i++){
    totalUsers[i] = table.getFloat(i, "YouTubeUsers_TotalUsers_Num_2024Feb");
    country[i] = table.getString(i, "flagCode");
  }
}

void draw(){
 background(255);
 
 fill(0);
 textSize(24);
 text("Cuentas de YT por país", width/2, 50);
 
 for(int i = 0; i < nSamples; i++){
   float x = map(i,0,nSamples,50, width-50);
   float y = map(totalUsers[i],0,max(totalUsers),height-50, 50);
   
   fill(0);
   textSize(12);
   text(country[i], x+3, y-6);
   fill(i*2);
   noStroke();
   circle(x,y,10);
 }
}
