//import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:smart_home_app/commands.dart';
import 'package:smart_home_app/main.dart';
import 'package:smart_home_app/sensorinformation.dart';
import 'package:smart_home_app/space.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class CommandHandler {
  late stt.SpeechToText _speech;
  bool isListening = false;

  List<Space> spaces;
  Icon microIcon = const Icon(Icons.mic_external_on);

  late BuildContext buildContext;
  late StateSetter setter;

  CommandHandler(this.spaces) {
    _speech = stt.SpeechToText();
  }

  Future<void> initialize() async {
    if (await _speech.initialize()) {
    } else {
      print('Speech recognition not available');
    }
  }

  void startListening() {
    if (!isListening && _speech.isAvailable) {
      microIcon = const Icon(Icons.mic_external_off);
      _speech.listen(onResult: (result) {
        String command = result.recognizedWords.toLowerCase();
        executeCommand(command);
      });
      isListening = true;
    }
  }

  void stopListening() {
    if (isListening) {
      microIcon = const Icon(Icons.mic_external_on);
      _speech.stop();
      isListening = false;
    }
  }

  void executeCommand(String command) {
    List<String> words = command.split(' ');
    if (words.length >= 2) {
      String? value =
          commandsDictionary[words[0].replaceAll(' ', '').toLowerCase()];
      if (value != null) {
        switch (value) {
          case "enable":
            for (var space in spaces) {
              for (var component in space.electronicComponents) {
                if (component.electronicComponentInformation.name == words[1]) {
                  final snackBar = SnackBar(
                      content: Text(
                          '${component.electronicComponentInformation.name} enabled\nIn space: ${space.name}'),
                      duration: const Duration(seconds: 3));
                  component.electronicComponentInformation.status = true;
                  print(component.electronicComponentInformation.toJson());
                  databaseConnector.PushData();
                  setter(() {
                    stopListening();
                  });
                  ScaffoldMessenger.of(buildContext).showSnackBar(snackBar);
                }
              }
            }
            break;
          case "disable":
            for (var space in spaces) {
              for (var component in space.electronicComponents) {
                if (component.electronicComponentInformation.name
                        .toLowerCase() ==
                    words[1].replaceAll(' ', '')) {
                  final snackBar = SnackBar(
                      content: Text(
                          '${component.electronicComponentInformation.name} disabled\nIn space: ${space.name}'),
                      duration: const Duration(seconds: 3));
                  component.electronicComponentInformation.status = false;
                  print(component.electronicComponentInformation.toJson());
                  databaseConnector.PushData();
                  setter(() {
                    stopListening();
                  });
                  ScaffoldMessenger.of(buildContext).showSnackBar(snackBar);
                }
              }
            }
            break;
          case "value":
            for (var space in spaces) {
              for (var component in space.electronicComponents) {
                if (component.electronicComponentInformation.name
                        .toLowerCase() ==
                    words[1].replaceAll(' ', '').toLowerCase()) {
                  if (component.electronicComponentInformation.type ==
                      "Sensor") {
                    SensorInformation sensorInformation = component
                        .electronicComponentInformation as SensorInformation;
                    final snackBar = SnackBar(
                        content: Text(
                            '${sensorInformation.name} value: ${sensorInformation.value}\nIn space: ${space.name}'),
                        duration: const Duration(seconds: 3));
                    _speech.cancel();
                    setter(() {
                      stopListening();
                    });
                    ScaffoldMessenger.of(buildContext).showSnackBar(snackBar);
                  }
                }
              }
            }
            break;
          default:
            print('Error command: $command');
        }
      }
    }
  }

  Widget getView(StateSetter setter, BuildContext buildContext) {
    this.setter = setter;
    this.buildContext = buildContext;
    return FloatingActionButton(
        heroTag: 'listening_button', // Уникальный тег для кнопки
        onPressed: () {
          if (!commandHandler.isListening) {
            setter(() {
              commandHandler.startListening();
            });
          } else {
            setter(() {
              commandHandler.stopListening();
            });
          }
        },
        child: microIcon);
  }
}
