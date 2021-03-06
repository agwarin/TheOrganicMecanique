import themidibus.*; //Import the library
MidiBus myBus; // The MidiBus

void setup() {
  size(50, 50);
  background(0);
  MidiBus.list();
  myBus = new MidiBus(this, -1, 1 );
  myBus.sendNoteOn(0, 1, 1); // Send a Midi noteOn


}

void draw() {
  delay(30);
  if (frameCount%20==0) thread("sendNotes");
}

void sendNotes() {  
  int channel = int(random(0,4));
  int pitch = 64+int(random(0,10));
  int velocity = 127;
  int number = 0;
  //this is the no
  int speakerNumber= int(random(0,127));
  //myBus.sendNoteOn(0,0,1); // Send a Midi noteOn

  myBus.sendControllerChange(channel, number, speakerNumber); // Send a controllerChange
  delay(20);    

  myBus.sendNoteOn(channel, pitch, velocity); // Send a Midi noteOn
  delay(20);
  myBus.sendNoteOff(channel, pitch, velocity); // Send a Midi nodeOff
}

void delay(int time) {
  int current = millis();
  while (millis () < current+time) Thread.yield();
}