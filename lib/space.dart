import 'package:smart_home_app/ElectronicView.dart';
import 'package:smart_home_app/MC/mcboard.dart';
import 'package:smart_home_app/MC/pinout.dart';
import 'package:smart_home_app/electroniccomponent.dart';
import 'package:smart_home_app/electroniccomponentinformation.dart';
import 'package:smart_home_app/ledinformation.dart';
import 'package:smart_home_app/relayinformation.dart';
import 'package:smart_home_app/sensorinformation.dart';

class Space {
  String name = "";
  McBoard board;
  List<Pinout> usedPins = [];

  List<ElectronicComponent> electronicComponents = [];

  Space({required this.name, required this.board});

  void removeElectronicComponentByName(String name) {
    electronicComponents.removeWhere(
        (component) => component.electronicComponentInformation.name == name);
  }

  Space.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        board = McBoard.fromJson(json['board']),
        usedPins = (json['usedPins'] as List<dynamic>)
            .map((e) => Pinout.fromJson(e))
            .toList(),
        electronicComponents =
            (json['electronicComponents'] as List<dynamic>).map((e) {
          ElectronicComponentInformation electronicComponentInformation;
          switch (e['type'] as String) {
            case 'Relay':
              electronicComponentInformation = RelayInformation.fromJson(e);
              break;
            case 'Led':
              electronicComponentInformation = LedInformation.fromJson(e);
              break;
            case 'Sensor':
              electronicComponentInformation = SensorInformation.fromJson(e);
              break;
            default:
              throw ArgumentError('Invalid electronic component type');
          }
          return ElectronicComponent(
            electronicComponentInformation,
            ElectronicView.getInformationViewByType(
                electronicComponentInformation),
          );
        }).toList();

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'board': board.toJson(),
      'usedPins': usedPins.map((p) => p.toJson()).toList(),
      'electronicComponents': electronicComponents
          .map((component) => component.electronicComponentInformation.toJson())
          .toList(),
    };
  }
}
