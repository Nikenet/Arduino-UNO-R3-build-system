#include "main.h"
#include "HIDKeyboard.h"

boolean debug = false;

int buttonStateOne = 0;
int buttonStateTwo = 0;

boolean ButtonOne = false;
boolean ButtonTwo = false;

boolean AlreadyPressedOne = false;
boolean AlreadyPressedTwo = false;

State st = WAIT;

HIDKeyboard keyboard;

void setup(){

	keyboard.begin();

	pinMode(PIN_BUTTON_1, INPUT);
	pinMode(PIN_BUTTON_2, INPUT);

	delay(1500);
}

void loop(){

	buttonStateOne = digitalRead(PIN_BUTTON_1);
	buttonStateTwo = digitalRead(PIN_BUTTON_2);

	if ((buttonStateOne > 0) || (buttonStateTwo > 0)) {

		if (buttonStateOne > 0) {
			if (!AlreadyPressedOne) {
				st                = PRESS;
				ButtonOne         = true;
				AlreadyPressedOne = true;
			} else {
				ButtonOne         = false;
			}
		}

		if (buttonStateTwo > 0) {
			if (!AlreadyPressedTwo) {
				st                = PRESS;
				ButtonTwo         = true;
				AlreadyPressedTwo = true;
			}  else {
				ButtonTwo         = false;
			}
		}

	} else if (AlreadyPressedOne || AlreadyPressedTwo) {

		if (AlreadyPressedOne) {
				st                = RELEASE;
				AlreadyPressedOne = false;
		}

		if (AlreadyPressedTwo) {
				st                = RELEASE;
				AlreadyPressedTwo = false;
		}
	} else {

		st                = WAIT;
		ButtonOne         = false;
		ButtonTwo         = false;
	}

	switch(st){

		case WAIT:
			if (debug)
				Serial.println("state WAIT");

			break;

		case PRESS:
			if (debug)
				Serial.println("state PRESS");

			if (ButtonOne)
					keyboard.pressKey('1');

			if (ButtonTwo)
					keyboard.pressKey('2');

			break;

		case RELEASE:
			if (debug)
				Serial.println("state RELEASE");

			keyboard.releaseKey();
			break;
	}
}