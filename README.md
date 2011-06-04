# Arduino USB Gameport Adapter
A USB to Gameport joystick adapter implemented on an Arduino Nano.

## Hardware
The analog joystick (some CH Products joystick from circa 2003) has two buttons and two axes. The two axes are wired through ADC0 and ADC1 on the Arduino in parallel with two 100kOhm pull-down resistors. The two buttons are wired through D2 and D3 on the Arduino in parallel with two 10kOhm pull-up resistors.

The following table shows the (current) pinout:
<table>
  <tr><td>PIN0</td><td>+5VDC</td></tr>
  <tr><td>PIN1</td><td>BTN0</td></tr>
  <tr><td>PIN2</td><td>AX0</td></tr>
  <tr><td>PIN3</td><td>GND</td></tr>
  <tr><td>PIN4</td><td>GND</td></tr>
  <tr><td>PIN5</td><td>AY0</td></tr>
  <tr><td>PIN6</td><td>BTN1</td></tr>
</table>

Note: The implementation is currently specific to the CH Products joystick and should be revised to be general enough to allow any Gameport joystick.

## Interface
The Arduino writes "AX0,AY0,BTN0,BTN1" to the serial port (e.g., /dev/ttyUSB0) at 9600 baud. In the future, the Arduino should advertise itself as a USB HID device, so that it becomes accessible through a joystick driver (as /dev/input/jsX).
