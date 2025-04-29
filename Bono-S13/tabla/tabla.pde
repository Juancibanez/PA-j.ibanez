//Table table;
//float appUsage;
//float screenOn;

//void setup(){
// size(1000,1000);
// background(0);
// table = loadTable("user_behavior_dataset.csv", "header");
// //print(table.getRowCount());
 
// for(TableRow row: table.rows()){
//   appUsage = row.getFloat("App Usage Time (min/day)");
//   screenOn = row.getFloat("Screen On Time (hours/day)");
//   println("appUsage " + appUsage);
// }
//}

Table table;
int nSamples;
float[] appUsageTime;
float[] screenOnTime;

void setup(){
  size(1000,1000);

  table = loadTable("user_behavior_dataset.csv", "header");

  nSamples = table.getRowCount();
  
  appUsageTime = new float[nSamples];
  screenOnTime = new float[nSamples];

  for(int i = 0; i<=nSamples-1; i++){
    appUsageTime[i] = table.getFloat(i, "App Usage Time (min/day)");
    screenOnTime[i] = table.getFloat(i, "Screen On Time (hours/day)");
  }
}

void draw(){
 background(0);
 for(int i = 0; i < nSamples; i++){
   float x = map(appUsageTime[i],0,max(appUsageTime),0, width);
   float y = map(screenOnTime[i],0,max(screenOnTime),height, 0);
   
   fill(random(100),random(255),random(200,255));
   noStroke();
   circle(x,y,10);
 }
}
