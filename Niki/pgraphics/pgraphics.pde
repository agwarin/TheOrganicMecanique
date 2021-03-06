//Oil slick
float[][] z1, v1, z2, v2;


pathfinder[] paths;
Crack[] cracks;
//all variables for digitaltree
int numCracks = 100;
int k = 0;
float stemPosX;
float stemPosY;
float stemVelX;
float stemVelY;
float stemLife;
float stemColor;
float stemFruit;
int deathCount = 10;
float diameter;

PGraphics natTree;
PGraphics mechTree;



void setup() {
  //fullScreen();
  frameRate(20);
  size(800, 600,P2D);
  //pixelDensity(2);
  background(0);
  smooth();
  
//oil slick rgb double arrays
  colorMode(RGB, 2);
  z1 = new float[width][height];
  v1 = new float[width][height];
  z2 = new float[width][height];
  v2 = new float[width][height];

  
  natTree= createGraphics(width,height);
  mechTree= createGraphics(width,height);
  
//Natural Tree Initialize
  paths = new pathfinder[1];
  paths[0] = new pathfinder();
  
  
//Mechanical Tree Initizalize
  cracks = new Crack[numCracks];
  
  for(int i = 0;i<cracks.length; i++){
    cracks[i] = new Crack(width,height,i);
  }
  
    cracks[k].plant();
  k++;
  if (k>=numCracks){
    k=0;
  }
}

void draw() {

//Oil Sick/////////////////////////////////////////////////////
 // loadPixels();

  for (int x = 1; x < width-1; x++) {
    for (int y = 1; y < height-1; y++) {
      v1[x][y] += (z1[x-1][y] + z1[x+1][y] + z1[x][y-1] + z1[x][y+1]) * 0.25 - z1[x][y];
      v2[x][y] += (z2[x-1][y] + z2[x+1][y] + z2[x][y-1] + z2[x][y+1] + z1[x][y]) * 0.25 - z2[x][y];
    }
  }
  
  for (int x = 1; x < width-1; x++) {
    for (int y = 1; y < height-1; y++) {
      z1[x][y] += v1[x][y];
      z2[x][y] += v2[x][y];
      z1[x][y] = constrain(z1[x][y], -1, 1);
      z2[x][y] = constrain(z2[x][y], -1, 1);
      pixels[width*y+x] = color(v1[x][y] + 1, v2[x][y] + 1, 2);
    }
  }
  
 // updatePixels();
  
//Natural Tree//////////////////////////////////////////////////////
  natTree.beginDraw();
  natTree.noStroke();
  natTree.fill(255);

  fill(255);
  noStroke();

  for (int i=0;i<paths.length;i++) {
    PVector loc = paths[i].location;
    float diam = paths[i].diameter;
    natTree.ellipse(loc.x, loc.y, diam, diam);
    paths[i].update();
    
  }
  natTree.endDraw();
  

  
 //Mechanical Tree//////////////////////////////////////////////////////
  mechTree.beginDraw();
  mechTree.fill(0);

  mechTree.stroke(70);
  fill(150);

    for (int j=0; j<numCracks; j++){
    cracks[j].update();
    if (cracks[j].cChoice == 1){
      if(cracks[j].cLife < 750){
         cracks[j].turn();
       }
    }
    if (cracks[j].cChoice == 2||cracks[j].cChoice == 3){
      if(cracks[j].cLife < 750){
         cracks[j].stemSave();
         cracks[k].stem();
         k++;
         if (k>=numCracks){
           k=0;
         }
       }
    }
    if (cracks[j].cChoice == 5){
      if(cracks[j].cLife < 300){
         cracks[j].fruit();
    }
    }
    cracks[j].cChoice = 0;
  }
  mechTree.endDraw();
  
  blendMode(ADD);
  image(natTree,0,0);
  image(mechTree,0,0);
  //natTree.filter(BLUR,2);
  

}




void mouseMoved(){ 

}
void mousePressed() {
  //oilspill

  v1[mouseX][mouseY] = randomGaussian();
  v2[mouseX][mouseY] = randomGaussian();

  //Draws Mechanical Tree
  background(0);
  paths = new pathfinder[1];
  paths[0] = new pathfinder();
  
  cracks[k].plant();
  k++;
  
  if (k>=numCracks){
    k=0;
  }
  
  
}