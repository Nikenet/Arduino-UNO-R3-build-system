#include "main.h"

void setup(){
	pinMode(D5, OUTPUT);
	digitalWrite(D5, HIGH);
}

void loop(){
	digitalWrite(D5, HIGH);
	delay(500);
	digitalWrite(D5, LOW);
	delay(500);
}