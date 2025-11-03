#include <Arduino.h>
int sensorPin = A0;    
int sensorValue = 0;  
void setup() {
    Serial.begin(115200);
    while(!Serial);
}

void loop() {
    sensorValue = analogRead(sensorPin);
    //Serial.print(">");
    //Serial.print("A0:");
    Serial.println(sensorValue);
    delay(50);
}
