#include <CapacitiveSensor.h>
#include <Arduino.h>
#include "SPI.h"    //Ethernet shield uses SPI for communication
#include "EthernetServer.h"   //Need to include arduino ethernet server library
#include "aJSON.h"   //aJSON library used for message formatting
#include "Lemma.h"  //Lemma library

/*
 * CapitiveSense Library Demo Sketch
 * Paul Badger 2008
 * Uses a high value resistor e.g. 10M between send pin and receive pin
 * Resistor effects sensitivity, experiment with values, 50K - 50M. Larger resistor values yield larger sensor values.
 * Receive pin is the sensor pin - try different amounts of foil/metal on this pin
 */


CapacitiveSensor   cs_one = CapacitiveSensor(4,5);        // 10M resistor between pins 4 & 2, pin 2 is sensor pin, add a wire and or foil if desired
CapacitiveSensor   cs_two = CapacitiveSensor(4,6);
CapacitiveSensor   cs_three = CapacitiveSensor(4,7);


static byte MAC[] = { 
  0x90, 0xA2, 0xDA, 0x0F, 0x98, 0xF8 };
const char * guestName = "bigVoice";
const char * roomName = "julia";

Lemma guest2 ( guestName , roomName );

int sensorThreshold = 1000;




void setup()                    
{
  cs_one.set_CS_AutocaL_Millis(0xFFFFFFFF);     // turn off autocalibrate on channel 1 - just as an example
  cs_two.set_CS_AutocaL_Millis(0xFFFFFFFF);
  cs_three.set_CS_AutocaL_Millis(0xFFFFFFFF);
  Serial.begin(9600);
 // guest2.hear( "donePlaying", printOut );
  guest2.begin( MAC );
}

void loop()                    
{
  
  long start = millis();
  int total1 =  cs_one.capacitiveSensor(30);
  int total2 =  cs_two.capacitiveSensor(30);
  int total3 =  cs_three.capacitiveSensor(30);
  
  int sensorValues[] = {total1, total2, total3};
  int arrayLength = 3;


  //Serial.print(millis() - start);        // check on performance in milliseconds

if(total1>sensorThreshold){
  guest2.speak("shoutLoud0", total1);
}
if(total1<sensorThreshold){
  guest2.speak("shutUp0", total1);
}


if(total2>sensorThreshold){
  guest2.speak("shoutLoud1", total2);
}
if(total2<sensorThreshold){
  guest2.speak("shutUp1", total2);
}

if(total3>sensorThreshold){
  guest2.speak("shoutLoud2", total3);
}
if(total3<sensorThreshold){
  guest2.speak("shutUp2", total3);
}

   guest2.run();

 // delay(100);                             // arbitrary delay to limit data to serial port 

}


void printOut (Message const & message)
{
  Serial.println( message.stringValue);
}

