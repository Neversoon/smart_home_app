import 'dart:async';
import 'package:smart_home_app/electroniccomponent.dart';
import 'package:smart_home_app/led.dart';
import 'package:smart_home_app/ledinformation.dart';
import 'package:smart_home_app/main.dart';
import 'package:smart_home_app/relay.dart';
import 'package:smart_home_app/relayinformation.dart';
import 'package:smart_home_app/sensor.dart';
import 'package:smart_home_app/sensorinformation.dart';
import 'package:smart_home_app/space.dart';
import 'package:firebase_database/firebase_database.dart';

class DatabaseConnector {
  String treeName;
  late Timer _timer;

  DatabaseConnector(this.treeName);

  void init() {
    DatabaseReference tree = FirebaseDatabase.instance.ref(treeName);
    tree.onValue.listen((DatabaseEvent event) {
      print("Changed value");
      print("Spaces count ${spaces.length.toString()}");
      final data = event.snapshot.value;
      List<ElectronicComponent> electronicComponents =
          recognitionData(data.toString());
      print(
          "Electronic component count ${electronicComponents.length.toString()}");
      for (Space space in spaces) {
        print(
            "Spaces electronic component count ${space.electronicComponents.length.toString()}");
        for (ElectronicComponent componentCurrent
            in space.electronicComponents) {
          for (ElectronicComponent componentOther in electronicComponents) {
            String nameOther = componentOther
                .electronicComponentInformation.name
                .trim()
                .toLowerCase();
            String typeOther = componentOther
                .electronicComponentInformation.type
                .trim()
                .toLowerCase();
            String nameCurrent = componentCurrent
                .electronicComponentInformation.name
                .trim()
                .toLowerCase();
            String typeCurrent = componentCurrent
                .electronicComponentInformation.type
                .trim()
                .toLowerCase();
            print("$nameOther $nameCurrent $typeOther $typeCurrent");
            print("${nameOther == nameCurrent} ${typeOther == typeCurrent}");
            if (typeOther == "sensor") {
              if (nameOther == nameCurrent && typeOther == typeCurrent) {
                print("find object");
                componentCurrent.informationView
                    .updateView(componentOther.electronicComponentInformation);
              }
            }
          }
        }
      }
    });
  }

  void PushData() {
    String data = "";
    bool isFirstElement = true;
    for (Space element in spaces) {
      List<ElectronicComponent> electroniccomponents =
          element.electronicComponents;
      for (ElectronicComponent electonicComponent in electroniccomponents) {

        if (!isFirstElement) {
          data += "|";
        }
        data += electonicComponent.electronicComponentInformation.parsedName;
        isFirstElement =
            false;
      }
    }
    
    DatabaseReference ref = FirebaseDatabase.instance.ref("test");
    ref.set(data);
  }

  List<ElectronicComponent> recognitionData(String data) {
    if (data.isEmpty) {
      return [];
    }
    List<ElectronicComponent> components = [];
    List<String> componentStrings = data.split('|');
    for (String componentString in componentStrings) {
      List<String> componentData = componentString.split('.');
      String name = componentData[0];
      String type = componentData[1];
      int pin = int.parse(componentData[2]);
      List<String> additionalData = componentData[3].split(',');
      switch (type) {
        case 'Relay':
          RelayInformation relayInfo = RelayInformation(
              name,
              pin,
              additionalData[0].toLowerCase() == "true",
              additionalData[1].toLowerCase() == "true");
          Relay relay = Relay(electronicComponentInformation: relayInfo);
          components.add(relay);
          break;
        case 'Led':
          LedInformation ledInfo = LedInformation(
              name, pin, additionalData[0].toLowerCase() == "true");
          Led led = Led(electronicComponentInformation: ledInfo);
          components.add(led);
          break;
        case 'Sensor':
          print("It is sensor");
          SensorInformation sensorInfo = SensorInformation(
              name, pin, additionalData[0], additionalData[1], true);
          Sensor sensor = Sensor(electronicComponentInformation: sensorInfo);
          components.add(sensor);
          break;
        default:
          throw ArgumentError('Unknown component type: $type');
      }
    }
    return components;
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      PushData();
    });
  }

  // Метод для остановки таймера (если необходимо)
  void stopTimer() {
    _timer.cancel();
  }
}
