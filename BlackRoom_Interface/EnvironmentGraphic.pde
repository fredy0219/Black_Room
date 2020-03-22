void drawEnvironmentGraphic(){
  
  environmentPG.beginDraw();
  environmentPG.camera(240,100,185/tan(PI*30.0 / 180.0),240, 185,0,0,1,0);
  environmentPG.background(100);
  
  environmentPG.translate(200,185,-20);
  
  //draw realsense
  environmentPG.pushMatrix();
  environmentPG.translate(-100,0,0);
  
  //draw realsense
  environmentPG.pushStyle();
  environmentPG.stroke(0);
  environmentPG.fill(200,200,200,50);
  environmentPG.box(10,10,50);
  environmentPG.popStyle();
  
  environmentPG.pushStyle();
  environmentPG.stroke(200,200,0);
  
  environmentPG.text(nf(face_depth,0,2) + "m", face_depth*100 /2, 50);
  for(int i =0 ; i< face_depth*100 ; i+=20){
    environmentPG.pushMatrix();
    environmentPG.translate(i,0,0);
    environmentPG.line(0,0,0,10,0,0);
    environmentPG.popMatrix();
  }
  environmentPG.popStyle();
  
  //draw head
  if(face_detected){
    environmentPG.translate(face_depth*100,0,0);
    //environmentPG.rotateY(millis()/10000.0 * TWO_PI);
    
    environmentPG.rotateY(radians(map(face_direction_yaw,0.2,0.8,-60,60)));
    environmentPG.pushStyle();
    
    environmentPG.fill(255,255,255,50);
    environmentPG.stroke(255,255,255,50);
    environmentPG.scale(1,2,1);
    environmentPG.sphere(10);
    
    environmentPG.scale(1,0.5,1);
    //X
    environmentPG.stroke(255,0,0);
    environmentPG.line(0,-20,0,0,-20,20);
    //Y
    environmentPG.stroke(0,255,0);
    environmentPG.line(0,-20,0,0,-40,0);
    //Z
    environmentPG.stroke(0,0,255);
    environmentPG.line(0,-20,0,-20,-20,0);
    environmentPG.popStyle();
  }
  
  
  environmentPG.popMatrix();
  
  environmentPG.endDraw();
  
  image(environmentPG,300,100);
  
}
