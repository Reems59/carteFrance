//globally
import controlP5.*;
//declare the variables corresponding to the column ids for x and y
float minX, maxX;
float minY, maxY;
float x[];
float y[];
int totalCount; // total number of places
float minPopulation, maxPopulation;
int[]tabAltitude = new int[16];
int minPopulationToDisplay= 200000;
double coef = 1.05;
String nameCityDragged="";
float minSurface, maxSurface;
float minAltitude, maxAltitude;
PFont font1;
PImage img;
City[] cityList;
ControlP5 MyController;
void setup() {
  tabAltitude[0] = 20;
  tabAltitude[1] = 40;
  tabAltitude[2] = 70;
  tabAltitude[3] = 150;
  tabAltitude[4] = 200;
  tabAltitude[5] = 300;
  tabAltitude[6] = 400;
  tabAltitude[7] = 500;
  tabAltitude[8] = 650;
  tabAltitude[9] = 800;
  tabAltitude[10] = 1000;
  tabAltitude[11] = 1250;
  tabAltitude[12] = 1500;
  tabAltitude[13] = 1750;
  tabAltitude[14] = 2000;
  tabAltitude[15] = 2300;
  size(1200,1200);
  font1 = createFont("Arial Bold", 18);
  img = loadImage("echelleAltitudeMoyen.png");
  MyController = new ControlP5(this);
  MyController.addSlider("Value")
          .setPosition(20,750)
          .setSize(400, 40)
          .setRange((int)minPopulation, 800000)
          .setValue(25000)
          .setColorCaptionLabel(color(240,0,0));
   //sl = new Slider(MyController, null, "",(int)minPopulation,30000,20000,20,750,400,40);
  //MyController.add(sl);
  textFont(font1); 
  readData();
}

void draw(){
  background(241);
  image(img, 850, 50);
  for (int i = 2 ; i < totalCount - 2 ; i++)
      cityList[i].drawAltitude();
    /*float x_i = mapX(x[i]);
    float y_i = mapY(y[i]);
     set((int) x_i, (int) y_i, black);Colo
  }*/
   for (int i = 2 ; i < totalCount-2 ; i++){
     if(cityList[i].population > minPopulationToDisplay){
      cityList[i].drawVille();
     }
   }
  minPopulationToDisplay =  (int)MyController.getController("Value").getValue();
  text("Populations supérieures à  : " + minPopulationToDisplay,20,720);
}
void keyPressed(){
  if(keyPressed){
    if(key == CODED){
      if(keyCode == UP){
        minPopulationToDisplay = (int)(minPopulationToDisplay * coef);
        redraw();
      }else if(keyCode == DOWN){
        minPopulationToDisplay = (int)(minPopulationToDisplay /coef);
        redraw();
      }
    }
  }
}
void mouseClicked() {
  City p = pick(mouseX, mouseY);
  if(p != null && p.name == nameCityDragged){
    p.clicked = true;
  }
}
    
void mouseMoved(){
  City p = pick(mouseX, mouseY);
  if(p != null && p.name != nameCityDragged){
    nameCityDragged  = p.name;
    
    println(p.name);
  }
  //println("mouseX "+ mouseX + "mouseY" + mouseY);
}

City pick(int px, int py){
  int indexOfVille= -1;
  float popuInit = maxPopulation;
  for(int i=2; i< cityList.length -2; i++){
      cityList[i].afficherVille = false;
      if(nameCityDragged != cityList[i].name)
        cityList[i].clicked=false;
      if( cityList[i].contains(px, py) && cityList[i].population > minPopulationToDisplay){
        if(cityList[i].population <= popuInit){
            indexOfVille = i;
            popuInit = cityList[i].population;
        }
      }
    }
    if(indexOfVille != -1){
      cityList[indexOfVille].afficherVille = true;
      return cityList[indexOfVille];
    }else{
      return null;
    }
}

void readData() {
  String[] lines = loadStrings("./villes.tsv");
   parseInfo(lines[0]); // read the header line
   cityList = new City[totalCount];

  for (int i = 2 ; i < totalCount ; ++i){
    String[] columns  = split(lines[i], TAB);
    City c = new City();
    c.postalcode = int (columns[0]);
    c.x = float (columns[1]);
    c.x_f = mapX(c.x);
    c.y = float (columns[2]);
    c.y_f = mapY(c.y);
    c.name = new String(columns[4]);
    c.population = int (columns[5]);
    c.density =float (columns[5]) / float (columns[6]) ;
    c.altitude = float(columns[7]);
    cityList[i-2] = c;
  }
  calculColorAltitude();
}

void calculColorAltitude(){
  for(int i = 0; i< totalCount-2; i++){
    int x=0;
    while(x < tabAltitude.length && (int)cityList[i].altitude > tabAltitude[x]){
      x++;
     }
      // Use color variable 'c' as fill color
    switch(x) {
      case 0: 
        cityList[i].altitudeC =  color(19,94,1);
        break;
      case 1: 
        cityList[i].altitudeC = color(20,107,0);
        break;
      case 2: 
        cityList[i].altitudeC = color(24,134,1);
        break;
      case 3: 
        cityList[i].altitudeC = color(33,153,6);
        break;
      case 4:
        cityList[i].altitudeC = color(65,174,7);
        break;
      case 5: 
        cityList[i].altitudeC = color(90,187,19);
        break;
      case 6: 
        cityList[i].altitudeC = color(121,198,30);
        break;
      case 7:
        cityList[i].altitudeC = color(160,231,75);      
        break;
      case 8: 
        cityList[i].altitudeC = color(198,237,96);
        break;
      case 9: 
        cityList[i].altitudeC = color(247,242,138);
        break;
      case 10: 
        cityList[i].altitudeC = color(239,186,82);
        break;
      case 11: 
        cityList[i].altitudeC = color(242,160,66);
        break;
      case 12: 
        cityList[i].altitudeC = color(219,136,47);
        break;
      case 13: 
        cityList[i].altitudeC = color(182,108,34);
        break;
      case 14: 
        cityList[i].altitudeC = color(129,77,24);
        break;
      case 15: 
        cityList[i].altitudeC = color(51,25,0);
        break;
    }
  }
}
float mapX(float x) {
 return map(x, minX, maxX, 0, 800);
}
float mapY(float y) {
 return map(y, minY, maxY, 800, 0);
}
void parseInfo(String line) {
  String infoString = line.substring(2); // remove the #
  String[] infoPieces = split(infoString, ',');
  totalCount = int(infoPieces[0]);
  minX = float(infoPieces[1]);
  maxX = float(infoPieces[2]);
  minY = float(infoPieces[3]);
  maxY = float(infoPieces[4]);
  minPopulation = float(infoPieces[5]);
  maxPopulation = float(infoPieces[6]);
  minSurface = float(infoPieces[7]);
  maxSurface = float(infoPieces[8]);
  minAltitude = float(infoPieces[9]);
  maxAltitude = float(infoPieces[10]);
}