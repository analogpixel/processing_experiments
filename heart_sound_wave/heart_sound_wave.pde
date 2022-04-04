// https://github.com/WorldFamousElectronics/PulseSensor_Amped_Processing_Visualizer


import processing.sound.*;
import processing.serial.*;  
SinOsc sine1;
SinOsc sine2;
int time;
SoundFile file;

int targetBPM = 60;

int x= 0;
int xinc=1;
Serial myPort;  

void setup() {
  size(800, 800);
  background(255);

  // Create the sine oscillator.
  sine1 = new SinOsc(this);
  sine1.freq(180);
  sine1.play();

  sine2 = new SinOsc(this);
  sine2.freq(190);
  sine2.play();

  printArray(Serial.list());
  myPort = new Serial(this, Serial.list()[4], 115200);

  time = millis() + 1000;

  file = new SoundFile(this, "tick.wav");
}

void draw() {


  if ( millis() > time ) {
    time = millis() + 1000; // Flash every second 60BPM
    file.play(1, 0.5);


    while (myPort.available() > 0) {
      String inBuffer = myPort.readString().replace("\n", ""); 
      if (inBuffer != null) {
        int BPM = int(inBuffer.split(",")[0]);
        sine2.freq( 180 + (BPM - targetBPM) ); // curent - target then add that to the base
        println(BPM);

        pushMatrix();
        translate(width/2, height/2);

        background(255);

        fill(0);
        ellipse(0, 0, 5, 5);

        noFill();
        strokeWeight(5);
        stroke(0, 255, 0);
        ellipse(0, 0, (BPM - targetBPM) * 20, (BPM - targetBPM) * 20);
        popMatrix();
      }
    }
  }
}
