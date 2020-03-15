import controlP5.*;
import processing.net.*;


int port = 11200;
Server myServer;

ControlP5 cp5;
Chart eye_EAR_chart;

boolean face_detected = false;
int face_position_x = 0;
int face_position_y = 0;
float face_depth = 0;
float face_direction_yaw = 0;
float face_direction_pitch = 0;
float face_direction_roll = 0;
float eye_EAR_left = 0;
float eye_EAR_right = 0;


void setup(){
 size(800,600);
 myServer = new Server(this, port);
 
 cp5 = new ControlP5(this);
 
 
 eye_EAR_chart = cp5.addChart("eye_EAR_left_data")
               .setPosition(20, 100)
               .setSize(250, 100)
               .setRange(0, 0.5)
               .setView(Chart.LINE) // use Chart.LINE, Chart.PIE, Chart.AREA, Chart.BAR_CENTERED
               .setStrokeWeight(1.5)
               .setColorCaptionLabel(color(40))
               ;
               
 eye_EAR_chart.addDataSet("left_data");
 eye_EAR_chart.setData("left_data", new float[100]);
 
 eye_EAR_chart.addDataSet("right_data");
 eye_EAR_chart.setData("right_data", new float[100]);
               
 //eye_EAR_right_chart = cp5.addChart("eye_EAR_right_data")
 //              .setPosition(20, 220)
 //              .setSize(250, 100)
 //              .setRange(0, 0.5)
 //              .setView(Chart.LINE) // use Chart.LINE, Chart.PIE, Chart.AREA, Chart.BAR_CENTERED
 //              .setStrokeWeight(1.5)
 //              .setColorCaptionLabel(color(40))
 //              ;
               
 //eye_EAR_left_chart.addDataSet("right_data");
 //eye_EAR_left_chart.setData("right_data", new float[100]);
 
 
 
 
}

void draw(){
  
  background(0);
  
  Client thisClient = myServer.available();
  if(thisClient != null){
    if(thisClient.available()>0){
        String s = thisClient.readString();
        println(s);
        JSONObject json = parseJSONObject(s);
        if (json == null) {
          println("JSONObject could not be parsed");
      } else {
        
        face_detected = json.getBoolean("face_detected");
        JSONObject face_position = json.getJSONObject("face_position");
        face_position_x = face_position.getInt("x");
        face_position_y = face_position.getInt("y");
        face_depth = json.getFloat("face_depth");
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
 
 textSize(10);
 text("Face detected : " +face_detected, 20,20);
 text("Face position : ( " +face_position_x+ " , " + face_position_y + " )", 20,40);
 text("Face depth : " +face_depth, 20,60);
 text("Eye EAR : ( " + eye_EAR_left + " , " + eye_EAR_left + " )", 20, 80);
 text("Face direction : ( " + face_direction_yaw + " )", 20,250);
 
 
 
}
