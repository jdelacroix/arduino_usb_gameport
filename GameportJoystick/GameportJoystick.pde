// GameportJoystick
// a PC gameport joystick interface for the Arduino
// author: Jean-Pierre de la Croix

// original: http://www.built-to-spec.com/blog/2009/09/10/using-a-pc-joystick-with-the-arduino/

const byte PUSH_BUTTON_1 = 2; // D2
const byte PUSH_BUTTON_2 = 3; // D3

const byte JOY_AXES_COUNT = 2;
const byte JOY_BUTTON_COUNT = 2;

const byte LED_PIN = 13;      // D13

int y_prev = 0, x_prev = 0;
float alpha = 0.9;

void setup() {
  pinMode(LED_PIN, OUTPUT);
  pinMode(PUSH_BUTTON_1, INPUT);
  pinMode(PUSH_BUTTON_2, INPUT);
  Serial.begin(9600);
}

void loop () {
  long x, y;
  int x_in, y_in;
  
  x_in = analogRead(0);
  y_in = analogRead(1);
  
  if (x_in) {
    x = 184140/x_in - 180;
    // first order low-pass filter
    x = alpha*x + (1-alpha)*x_prev;
  } else {
    x = -1; //this should only happen if the joystick isn't connected
  }
  
  if (y_in) {
    y = 184140/y_in - 180;
    // first order low-pass filter
    y = alpha*y + (1-alpha)*y_prev;
  } else {
    y = -1; //this should only happen if the joystick isn't connected
  }
  
  byte button_state_1 = digitalRead(PUSH_BUTTON_1);
  byte button_state_2 = digitalRead(PUSH_BUTTON_2);
  
  if(button_state_1 == LOW || button_state_2 == LOW) {
   digitalWrite(LED_PIN, HIGH);
  } else {
   digitalWrite(LED_PIN, LOW);
  }
  
  x_prev = x;
  y_prev = y;
  
  // protocol:
  // $ARDJOY,TIME,BTNC,AC,BTN0,BTN1,AX0,AY0
  
  Serial.print("$ARDJOY,");
  Serial.print(millis());
  Serial.print(",");
  Serial.print(JOY_BUTTON_COUNT, DEC);
  Serial.print(",");
  Serial.print(JOY_AXES_COUNT, DEC);
  Serial.print(",");
  Serial.print(button_state_1, DEC);
  Serial.print(",");
  Serial.print(button_state_2, DEC);
  Serial.print(",");
  Serial.print(x, DEC);
  Serial.print(",");
  Serial.print(y, DEC);
  Serial.println("");
  
  delay(100);
}
