class Brush {
  int components[];
  float x, y, angle;
  int compVal = (int)random(1,3);
  int num = 0;

  Brush() {
    int alpha = 20;
    //fillColor[0] = color(random(100,120), random(0,10), random(60,255), 5);
    fillColor[0] = color(random(100,255), random(0,30), random(60,255), 5);
    fillColor[1] = color(0,alpha);
    fillColor[2] = color(random(50, 100), 190, random(100, 200), 4);
    fillColor[3] = color(0,alpha);
    fillColor[4] = color(random(110,170), random(180,250), random(30,90), 5);
    fillColor[5] = color(0,alpha);
    fillColor[6] = color(random(40,80), random(0,30), random(130,200), 5);
    fillColor[7] = color(0,alpha);
    fillColor[8] = color(random(130,240), random(0,30), random(70,140), 5);
    fillColor[9] = color(0,alpha);

    angle = random(PI);
    x = random(width);
    y = random(height);
    //clr = color(random(100,255), random(0,30), random(60,255), 5);
    //clr = color(random(100,120), random(0,10), random(60,255), 5);
    components = new int[compVal];
    for (int i = 0; i < compVal; i++) {
      components[i] = compVal;
    }
    alpha = alpha++;
  }
  
  void paint(int colorVal) {
    float a = 0;
    float r = 0;
    float x1 = x;
    float y1 = y;
    float u = random(0.5, 1);
    //blendMode(ADD);
    fill(fillColor[colorVal]); 
    noStroke();    
    beginShape();
    while (a < TWO_PI) {
      vertex(x1, y1); 
      float v = random(0.85, 3);//was 1 now is 3 and really fing big
      x1 = x + r * cos(angle + a) * u*.3 * v;
      y1 = y + r * sin(angle + a) * u*.3 * v;
      a += PI / 360;
      for (int i = 0; i < compVal; i++) {
        r += sin(a * components[i]);
      }
    }
    endShape(CLOSE);
    
    if (x < 0 || x > width ||y < 0 || y > height) {
      angle += HALF_PI;
    }

    x += 2 * cos(angle);
    y += 2 * sin(angle); 
    angle += random(-.45,.45);
  }   
}