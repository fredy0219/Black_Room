void drawFaceGraphic(){
  
  facePG.beginDraw();
  facePG.background(100);
  
  facePG.translate(125,120,-20);
  
  facePG.pushMatrix();
  facePG.rotateY(millis()/10000.0 * TWO_PI);
  facePG.pushStyle();
  //facePG.scale(1,2,1);
  facePG.box(5);
  facePG.fill(255,255,255,50);
  facePG.noStroke();
  facePG.box(30);
  facePG.popStyle();
  
  //float data = map(0.3,0,1,-60,60);
  //facePG.rotateY(radians(data));
  //X
  facePG.stroke(255,0,0);
  facePG.line(0, 0, 0, 0, 0, 70);
  //Y
  facePG.stroke(0,255,0);
  facePG.line(0, 0, 0, 0, -70, 0);
  //Z
  facePG.stroke(0,0,255);
  facePG.line(0, 0, 0, 70, 0, 0);

  facePG.popMatrix();
  facePG.endDraw();
  
  image(facePG,20,270);
  
}