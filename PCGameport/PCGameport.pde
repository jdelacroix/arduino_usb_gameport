// PCJoystick
// a PC joystick gameport interface for the Arduino

const int PUSH_BUTTON_1 = 2;
const int PUSH_BUTTON_2 = 3;

const int ledPin = 13;

int state = LOW;
int y_prev = 0, x_prev = 0;
float alpha = 0.9;

void setup() {
  pinMode(ledPin, OUTPUT);
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
    x = alpha*x + (1-alpha)*x_prev;
  } else {
    x = -1; //this should only happen if the joystick isn't connected
  }
  
  if (y_in) {
    y = 184140/y_in - 180;
    y = alpha*y + (1-alpha)*y_prev;
  } else {
    y = -1; //this should only happen if the joystick isn't connected
  }
  
  int button_state_1 = digitalRead(PUSH_BUTTON_1);
  int button_state_2 = digitalRead(PUSH_BUTTON_2);
  
  if(button_state_1 == LOW || button_state_2 == LOW) {
   digitalWrite(ledPin, HIGH);
  } else {
   digitalWrite(ledPin, LOW);
  }
  
  x_prev = x;
  y_prev = y;
  
  //Serial.print("<");
  Serial.print(x, DEC);
  Serial.print(",");
  Serial.print(y, DEC);
  Serial.print(",");
  Serial.print(button_state_1, DEC);
  Serial.print(",");
  Serial.print(button_state_2, DEC);
  //Serial.println(">");
  Serial.println("");
  
  delay(100);
}
