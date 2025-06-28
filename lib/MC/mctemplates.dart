import 'package:smart_home_app/MC/mcboard.dart';
import 'package:smart_home_app/MC/pinout.dart';

final boards = <McBoard>[
  McBoard(
      0,
      "WEMOS D1 R2 WIFI ESP8266 Shield Arduino Compatible",
      """
WeMos-D1R2 is an ESP8266-12 based WiFi enabled microprocessor unit on a
Arduino-UNO footprint. That means the board looks and works (in most cases) like an UNO.
Apparently several shields, sensors and output devices that are manufactured for the Arduino
platform will work on the WeMos-D1R2 with the added advantage of built-in WiFi.
The D1 R2 is a WiFi capable ESP8266EX based development board in the form of
the common Arduino UNO board format. This board is compatible with the Arduino IDE and
with NodeMCU. The D1 R2 also features an on-board switching power supply which allows
you to power the board from a power supply up to 12V.
  """,
      [
        Pinout("TX", 1, "TXD", "Digital", "TXD"),
        Pinout("RX", 3, "RXD", "Digital", "TXD"),
        Pinout("D1", 5, "SCL", "Digital", "SCL/IO pin"),
        Pinout("D2", 4, "SDA", "Digital", "SDA/IO pin"),
        Pinout("D3", 0, "FLASH", "Digital", "FLASH/IO pin"),
        Pinout("D4", 2, "IO", "Digital", "IO pin"),
        Pinout("G", -1, "GRD", "GRD", "Ground"),
        Pinout("5V", -1, "VDD", "VDD", "VDD 5V"),
        Pinout("RST", -1, "RST", "Digital", "Reset pin"),
        Pinout("A0", 0, "ADC0", "Analog", "Analog input, max 3.3V input"),
        Pinout("D0", 16, "WAKE", "Digital", "WAKE pin"),
        Pinout("D5", 14, "SCLK", "Digital", "SCLK pin"),
        Pinout("D6", 12, "MISO", "Digital", "MISO pin"),
        Pinout("D7", 13, "MOSI", "Digital", "MOSI pin"),
        Pinout("D8", 15, "CS", "Digital", "CS pin"),
        Pinout("3.3V", -1, "VDD", "VDD", "VDD 3.3V"),
      ],
      iconPath: 'assets/images/wemosd1r1.png'),
  McBoard(
      1,
      "WEMOS D1 R2 WIFI ESP8266 Shield Arduino Compatible",
      """
WeMos-D1R2 is an ESP8266-12 based WiFi enabled microprocessor unit on a
Arduino-UNO footprint. That means the board looks and works (in most cases) like an UNO.
Apparently several shields, sensors and output devices that are manufactured for the Arduino
platform will work on the WeMos-D1R2 with the added advantage of built-in WiFi.
The D1 R2 is a WiFi capable ESP8266EX based development board in the form of
the common Arduino UNO board format. This board is compatible with the Arduino IDE and
with NodeMCU. The D1 R2 also features an on-board switching power supply which allows
you to power the board from a power supply up to 12V.
  """,
      [
        Pinout("TX", 1, "TXD", "Digital", "TXD"),
        Pinout("RX", 3, "RXD", "Digital", "TXD"),
        Pinout("D1", 5, "SCL", "Digital", "SCL/IO pin"),
        Pinout("D2", 4, "SDA", "Digital", "SDA/IO pin"),
        Pinout("D3", 0, "FLASH", "Digital", "FLASH/IO pin"),
        Pinout("D4", 2, "IO", "Digital", "IO pin"),
        Pinout("G", -1, "GRD", "GRD", "Ground"),
        Pinout("5V", -1, "VDD", "VDD", "VDD 5V"),
        Pinout("RST", -1, "RST", "Digital", "Reset pin"),
        Pinout("A0", 0, "ADC0", "Analog", "Analog input, max 3.3V input"),
        Pinout("D0", 16, "WAKE", "Digital", "WAKE pin"),
        Pinout("D5", 14, "SCLK", "Digital", "SCLK pin"),
        Pinout("D6", 12, "MISO", "Digital", "MISO pin"),
        Pinout("D7", 13, "MOSI", "Digital", "MOSI pin"),
        Pinout("D8", 15, "CS", "Digital", "CS pin"),
        Pinout("3.3V", -1, "VDD", "VDD", "VDD 3.3V"),
      ],
      iconPath: 'assets/images/wemosd1r1.png')
];
