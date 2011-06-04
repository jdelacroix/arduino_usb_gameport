# Arduino USB Gameport Adapter
A USB to Gameport joystick adapter implemented on an Arduino Nano.

Originally from "Built to Spec" [[link](http://www.built-to-spec.com/blog/2009/09/10/using-a-pc-joystick-with-the-arduino/)]

## Hardware
The analog joystick (some CH Products joystick from circa 2003) has two buttons and two axes. The two axes are wired through ADC0 and ADC1 on the Arduino in parallel with two 100kOhm pull-down resistors. The two buttons are wired through D2 and D3 on the Arduino in parallel with two 10kOhm pull-up resistors.

The following table shows the Gameport pinout:
<table>
  <tr><td>PIN1</td><td>+5VDC</td></tr>
  <tr><td>PIN2</td><td>BTN0</td></tr>
  <tr><td>PIN3</td><td>AXS0</td></tr>
  <tr><td>PIN4</td><td>GND</td></tr>
  <tr><td>PIN5</td><td>GND</td></tr>
  <tr><td>PIN6</td><td>AXS1</td></tr>
  <tr><td>PIN7</td><td>BTN1</td></tr>
  <tr><td>PIN8</td><td>BTN1</td></tr>
  <tr><td>PIN9</td><td>+5VDC</td></tr>
  <tr><td>PIN10</td><td>BTN3</td></tr>
  <tr><td>PIN11</td><td>AXS2</td></tr>
  <tr><td>PIN12</td><td>GND</td></tr>
  <tr><td>PIN13</td><td>AXS3</td></tr>
  <tr><td>PIN14</td><td>BTN2</td></tr>
  <tr><td>PIN15</td><td>BTN1</td></tr>
</table>

## Interface
The Arduino writes to the serial port (e.g., /dev/ttyUSB0) at 9600 baud using the following protocal (format):

$ARDJOY,TIME,BTNC,AXSC,BTN0,BTN1,...,AXS0,AXS1,...

BTNC and AXSC define the number of buttons and axes (up to 4 each).

In the future, the Arduino should advertise itself as a USB HID device, so that it becomes accessible through a joystick driver (as /dev/input/jsX).
