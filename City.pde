class City { 
  int postalcode; 
  String name; 
  float x; 
  float y; 
  int population; 
  float altitude;
  float density;
  float x_f;
  float y_f;
  color altitudeC;
  int radius = 3;
  boolean afficherVille= false;
  float diametrePopu=0; 
  boolean clicked = false;
  
  /*void draw(){
    drawAltitude();
    afficherVille();
  }*/

 
  // put a drawing function in here and call from main drawing loop }
  void drawAltitude(){
    //set((int)x_f,(int) y_f, color(0));*
    noStroke();  // Don't draw a stroke around shapes
    fill(altitudeC);
    ellipse((int)x_f, (int) y_f,7,7);
  }
  
 void drawVille(){
    diametrePopu = 200 * (population/maxPopulation);
     
    //fill(255,0,0);
    stroke(240,0,0);
     noFill();
    if(!afficherVille){
       ellipse(x_f, y_f, diametrePopu, diametrePopu);
    }else{
      strokeWeight(3);
      fill(240,0,0,125);
      ellipse(x_f, y_f, diametrePopu, diametrePopu);
      textAlign(CENTER, BOTTOM);
      float sw = textWidth(name);
      strokeWeight(2);
      fill(0,0,0);
      stroke(0,0,0);
      text(name, x_f , y_f + 35);
      line(x_f  - sw/2, y_f +36, x_f + sw/2, y_f +36);
      if(clicked){
         textAlign(0,BOTTOM);
        text("Informations sur la ville de " + name  + "(" + postalcode + ")", 100, 850);
        text( "Population : " + population + " habitants" , 120, 880);
        text( "Densité de  la population : "  + (int)density  + " habitants/km2" , 120, 900);
        text( "Alitude : " + (int)altitude + " m" , 120, 920);
      }
    }
    strokeWeight(1);
    textAlign(0,0);
    //textSize(14);
    fill(0,0,0);
    
  //ellipse(mapX(x), mapY(y), radius*2, radius*2);
 }
 boolean contains(int px, int py){
   return dist(mapX(x), mapY(y), px, py) <= diametrePopu/2 +1;
 }
}