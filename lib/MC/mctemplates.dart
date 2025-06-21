import 'package:smart_home_app/MC/mcboard.dart';
import 'package:smart_home_app/MC/pinout.dart';

final boards = <McBoard>[
McBoard(
  "Arduino UNO", 
  """
  Arduino UNO is a microcontroller board based on the ATmega328P. It has 14 digital input/output pins (of which 6 can be used as PWM outputs), 
  6 analog inputs, a 16 MHz ceramic resonator, a USB connection, a power jack, an ICSP header and a reset button. It contains everything needed to support the microcontroller; 
  simply connect it to a computer with a USB cable or power it with a AC-to-DC adapter or battery to get started. 
  You can tinker with your UNO without worrying too much about doing something wrong, worst case scenario you can replace the chip for a few dollars and start over again.
  """,
  
[
  Pinout(1, 0, "NC", "NC", "Not connected"),
  Pinout(2, 0, "IOREF", "Power", "Reference for digital logic V - connected to 5V"),
  Pinout(3, 0, "Reset", "Reset", "Reset"),
  Pinout(4, 0, "+3V3", "Power", "+3V3 Power Rail"),
  Pinout(5, 0, "+5V", "Power", "+5V Power Rail"),
  Pinout(6, 0, "GND", "Power", "Ground"),
  Pinout(7, 0, "GND", "Power", "Ground"),
  Pinout(8, 0, "VIN", "Power", "Voltage Input"),
  Pinout(9, 0, "A0", "Analog/GPIO", "Analog input 0 /GPIO"),
  Pinout(10, 1, "A1", "Analog/GPIO", "Analog input 1 /GPIO"),
  Pinout(11, 2, "A2", "Analog/GPIO", "Analog input 2 /GPIO"),
  Pinout(12, 3, "A3", "Analog/GPIO", "Analog input 3 /GPIO"),
  Pinout(13, 4, "A4/SDA", "Analog input/I2C", "Analog input 4/I2C Data line"),
  Pinout(14, 5, "A5/SCL", "Analog input/I2C", "Analog input 5/I2C Clock line"),

  Pinout(1, 0, "D0", "Digital/GPIO", "Digital pin 0/GPIO"),
  Pinout(2, 1, "D1", "Digital/GPIO", "Digital pin 1/GPIO"),
  Pinout(3, 2, "D2", "Digital/GPIO", "Digital pin 2/GPIO"),
  Pinout(4, 3, "D3", "Digital/GPIO", "Digital pin 3/GPIO"),
  Pinout(5, 4, "D4", "Digital/GPIO", "Digital pin 4/GPIO"),
  Pinout(6, 5, "D5", "Digital/GPIO", "Digital pin 5/GPIO"),
  Pinout(7, 6, "D6", "Digital/GPIO", "Digital pin 6/GPIO"),
  Pinout(8, 7, "D7", "Digital/GPIO", "Digital pin 7/GPIO"),
  Pinout(9, 8, "D8", "Digital/GPIO", "Digital pin 8/GPIO"),
  Pinout(10, 9, "D9", "Digital/GPIO", "Digital pin 9/GPIO"),
  Pinout(11, 10, "SS", "Digital", "SPI Chip Select"),
  Pinout(12, 11, "MOSI", "Digital", "SPI1 Main Out Secondary In"),
  Pinout(13, 12, "MISO", "Digital", "SPI Main In Secondary Out"),
  Pinout(14, 13, "SCK", "Digital", "SPI serial clock output"),
  Pinout(15, 0, "GND", "Power", "Ground"),
  Pinout(16, 0, "AREF", "Digital", "Analog reference voltage"),
  Pinout(17, 18, "A4/SD4", "Digital", "Analog input 4/I2C Data line (duplicated)"),
  Pinout(18, 19, "A5/SD5", "Digital", "Analog input 5/I2C Clock line (duplicated)"),
],

  iconPath: 'assets/images/arduinouno.png'
),
McBoard(
  "Arduino UNO", 
  """
  Arduino UNO is a microcontroller board based on the ATmega328P. It has 14 digital input/output pins (of which 6 can be used as PWM outputs), 
  6 analog inputs, a 16 MHz ceramic resonator, a USB connection, a power jack, an ICSP header and a reset button. It contains everything needed to support the microcontroller; 
  simply connect it to a computer with a USB cable or power it with a AC-to-DC adapter or battery to get started. 
  You can tinker with your UNO without worrying too much about doing something wrong, worst case scenario you can replace the chip for a few dollars and start over again.
  """,
  
[
  Pinout(1, 0, "NC", "NC", "Not connected"),
  Pinout(2, 0, "IOREF", "Power", "Reference for digital logic V - connected to 5V"),
  Pinout(3, 0, "Reset", "Reset", "Reset"),
  Pinout(4, 0, "+3V3", "Power", "+3V3 Power Rail"),
  Pinout(5, 0, "+5V", "Power", "+5V Power Rail"),
  Pinout(6, 0, "GND", "Power", "Ground"),
  Pinout(7, 0, "GND", "Power", "Ground"),
  Pinout(8, 0, "VIN", "Power", "Voltage Input"),
  Pinout(9, 0, "A0", "Analog/GPIO", "Analog input 0 /GPIO"),
  Pinout(10, 1, "A1", "Analog/GPIO", "Analog input 1 /GPIO"),
  Pinout(11, 2, "A2", "Analog/GPIO", "Analog input 2 /GPIO"),
  Pinout(12, 3, "A3", "Analog/GPIO", "Analog input 3 /GPIO"),
  Pinout(13, 4, "A4/SDA", "Analog input/I2C", "Analog input 4/I2C Data line"),
  Pinout(14, 5, "A5/SCL", "Analog input/I2C", "Analog input 5/I2C Clock line"),

  Pinout(1, 0, "D0", "Digital/GPIO", "Digital pin 0/GPIO"),
  Pinout(2, 1, "D1", "Digital/GPIO", "Digital pin 1/GPIO"),
  Pinout(3, 2, "D2", "Digital/GPIO", "Digital pin 2/GPIO"),
  Pinout(4, 3, "D3", "Digital/GPIO", "Digital pin 3/GPIO"),
  Pinout(5, 4, "D4", "Digital/GPIO", "Digital pin 4/GPIO"),
  Pinout(6, 5, "D5", "Digital/GPIO", "Digital pin 5/GPIO"),
  Pinout(7, 6, "D6", "Digital/GPIO", "Digital pin 6/GPIO"),
  Pinout(8, 7, "D7", "Digital/GPIO", "Digital pin 7/GPIO"),
  Pinout(9, 8, "D8", "Digital/GPIO", "Digital pin 8/GPIO"),
  Pinout(10, 9, "D9", "Digital/GPIO", "Digital pin 9/GPIO"),
  Pinout(11, 10, "SS", "Digital", "SPI Chip Select"),
  Pinout(12, 11, "MOSI", "Digital", "SPI1 Main Out Secondary In"),
  Pinout(13, 12, "MISO", "Digital", "SPI Main In Secondary Out"),
  Pinout(14, 13, "SCK", "Digital", "SPI serial clock output"),
  Pinout(15, 0, "GND", "Power", "Ground"),
  Pinout(16, 0, "AREF", "Digital", "Analog reference voltage"),
  Pinout(17, 18, "A4/SD4", "Digital", "Analog input 4/I2C Data line (duplicated)"),
  Pinout(18, 19, "A5/SD5", "Digital", "Analog input 5/I2C Clock line (duplicated)"),
],

  iconPath: 'assets/images/arduinouno.png'
),
McBoard(
  "Arduino UNO", 
  """
  Arduino UNO is a microcontroller board based on the ATmega328P. It has 14 digital input/output pins (of which 6 can be used as PWM outputs), 
  6 analog inputs, a 16 MHz ceramic resonator, a USB connection, a power jack, an ICSP header and a reset button. It contains everything needed to support the microcontroller; 
  simply connect it to a computer with a USB cable or power it with a AC-to-DC adapter or battery to get started. 
  You can tinker with your UNO without worrying too much about doing something wrong, worst case scenario you can replace the chip for a few dollars and start over again.
  """,
  
[
  Pinout(1, 0, "NC", "NC", "Not connected"),
  Pinout(2, 0, "IOREF", "Power", "Reference for digital logic V - connected to 5V"),
  Pinout(3, 0, "Reset", "Reset", "Reset"),
  Pinout(4, 0, "+3V3", "Power", "+3V3 Power Rail"),
  Pinout(5, 0, "+5V", "Power", "+5V Power Rail"),
  Pinout(6, 0, "GND", "Power", "Ground"),
  Pinout(7, 0, "GND", "Power", "Ground"),
  Pinout(8, 0, "VIN", "Power", "Voltage Input"),
  Pinout(9, 0, "A0", "Analog/GPIO", "Analog input 0 /GPIO"),
  Pinout(10, 1, "A1", "Analog/GPIO", "Analog input 1 /GPIO"),
  Pinout(11, 2, "A2", "Analog/GPIO", "Analog input 2 /GPIO"),
  Pinout(12, 3, "A3", "Analog/GPIO", "Analog input 3 /GPIO"),
  Pinout(13, 4, "A4/SDA", "Analog input/I2C", "Analog input 4/I2C Data line"),
  Pinout(14, 5, "A5/SCL", "Analog input/I2C", "Analog input 5/I2C Clock line"),

  Pinout(1, 0, "D0", "Digital/GPIO", "Digital pin 0/GPIO"),
  Pinout(2, 1, "D1", "Digital/GPIO", "Digital pin 1/GPIO"),
  Pinout(3, 2, "D2", "Digital/GPIO", "Digital pin 2/GPIO"),
  Pinout(4, 3, "D3", "Digital/GPIO", "Digital pin 3/GPIO"),
  Pinout(5, 4, "D4", "Digital/GPIO", "Digital pin 4/GPIO"),
  Pinout(6, 5, "D5", "Digital/GPIO", "Digital pin 5/GPIO"),
  Pinout(7, 6, "D6", "Digital/GPIO", "Digital pin 6/GPIO"),
  Pinout(8, 7, "D7", "Digital/GPIO", "Digital pin 7/GPIO"),
  Pinout(9, 8, "D8", "Digital/GPIO", "Digital pin 8/GPIO"),
  Pinout(10, 9, "D9", "Digital/GPIO", "Digital pin 9/GPIO"),
  Pinout(11, 10, "SS", "Digital", "SPI Chip Select"),
  Pinout(12, 11, "MOSI", "Digital", "SPI1 Main Out Secondary In"),
  Pinout(13, 12, "MISO", "Digital", "SPI Main In Secondary Out"),
  Pinout(14, 13, "SCK", "Digital", "SPI serial clock output"),
  Pinout(15, 0, "GND", "Power", "Ground"),
  Pinout(16, 0, "AREF", "Digital", "Analog reference voltage"),
  Pinout(17, 18, "A4/SD4", "Digital", "Analog input 4/I2C Data line (duplicated)"),
  Pinout(18, 19, "A5/SD5", "Digital", "Analog input 5/I2C Clock line (duplicated)"),
],

  iconPath: 'assets/images/arduinouno.png'
)
];