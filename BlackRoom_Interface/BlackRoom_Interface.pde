import controlP5.*;
import processing.net.*;


int port = 11200;
Server myServer;

ControlP5 cp5;
Chart eye_EAR_chart;

PGraphics facePG;
PGraphics environmentPG;

boolean face_detected = true;
int face_position_x = 0;
int face_position_y = 0;
float face_depth = 0;
float face_direction_yaw = 0;
float face_direction_pitch = 0;
float face_direction_roll = 0;
float eye_EAR_left = 0;
float eye_EAR_right = 0;

boolean face_distance_corrected = false;
boolean face_direction_corrected = false;
boolean eye_opened = false;



void setup(){
 size(800,600,P3D);
 hint(ENABLE_DEPTH_TEST);
 facePG = createGraphics(250,200,P3D);
 environmentPG = createGraphics(480,370,P3D);

 
 myServer = new Server(this, port);
 
 cp5 = new ControlP5(this);
 eye_EAR_chart = cp5.addChart("eye_EAR_data")
               .setPosition(20, 100)
               .setSize(250, 100)
               .setRange(0, 0.5)
               .setView(Chart.LINE) // use Chart.LINE, Chart.PIE, Chart.AREA, Chart.BAR_CENTERED
               .setStrokeWeight(1.5)
               .setColorCaptionLabel(color(40))
               .setColorLabel(255)
               ;
               
 eye_EAR_chart.addDataSet("left_data");
 eye_EAR_chart.setData("left_data", new float[100]);
 eye_EAR_chart.setColors("left_data",color(255,0,0));
 
 eye_EAR_chart.addDataSet("right_data");
 eye_EAR_chart.setData("right_data", new float[100]);
 eye_EAR_chart.setColors("right_data",color(0,255,0));
 
 eye_EAR_chart.addDataSet("threshold");
 eye_EAR_chart.setData("threshold",new float[3]);
 eye_EAR_chart.setColors("threshold",color(100,100,100));
 
 eye_EAR_chart.push("threshold", 0.2);
 eye_EAR_chart.push("threshold", 0.2);
 eye_EAR_chart.push("threshold", 0.2);
}

void draw(){
  
  background(0);
  
  Client thisClient = myServer.available();
  if(thisClient != null){
    if(thisClient.available()>0){
        String s = thisClient.readString();
        JSONObject json = parseJSONObject(s);
        if (json == null) {
          println("JSONObject could not be parsed");
      } else {
        
        // decompress data from realsense face landmark
        face_detected = json.getBoolean("face_detected");
        
        face_depth = json.getFloat("face_depth");
        
        JSONObject face_position = json.getJSONObject("face_position");
        face_position_x = face_position.getInt("x");
        face_position_y = face_position.getInt("y");
        
        JSONObject face_direction = json.getJSONObject("face_direction");
        face_direction_yaw = face_direction.getFloat("yaw");
        //face_direction_pitch = face_direction.getFloat("pitch");
        //face_direction_roll = face_direction.getFloat("roll");
        
        JSONObject eye_EAR = json.getJSONObject("eye_EAR");
        eye_EAR_left = eye_EAR.getFloat("left");
        eye_EAR_right = eye_EAR.getFloat("right");
        
        eye_EAR_chart.push("left_data", eye_EAR_left);
        eye_EAR_chart.push("right_data", eye_EAR_right);
     }
   }
   
 }
 
 drawFaceGraphic();
 drawEnvironmentGraphic();
 
 drawGUI();
 
}

void drawGUI(){
 
 fill(255);
 textSize(10);
 text("Face detected : " +face_detected, 20,20);
 text("Face position : ( " +face_position_x+ " , " + face_position_y + " )", 20,40);
 text("Face depth : " +face_depth, 20,60);
 text("Eye EAR : ( " + eye_EAR_left + " , " + eye_EAR_left + " )", 20, 80);
 text("Face direction : ( " + face_direction_yaw + " )", 20,250);
 
 text("Face Detected ", 320,20);
 text("Face Distance Corrected ",320,40);
 text("Face Direction Corrected ", 320,60);
 text("Eye Opened ",320,80);
 
 color check_color = color(50,50,50);
 
 check_color = face_detected ? color(0,255,0):color(50,50,50);
 fill(check_color);
 ellipse(305, 15, 10, 10);
 
 check_color = face_distance_corrected ? color(0,255,0):color(50,50,50);
 fill(check_color);
 ellipse(305, 35, 10, 10);
 
 check_color = face_direction_corrected ? color(0,255,0):color(50,50,50);
 fill(check_color);
 ellipse(305, 55, 10, 10);
 
 check_color = eye_opened ? color(0,255,0):color(50,50,50);
 fill(check_color);
 ellipse(305, 75, 10, 10);
  
}
