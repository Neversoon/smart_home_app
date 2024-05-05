import 'package:smart_home_app/ElectronicView.dart';
import 'package:smart_home_app/electroniccomponent.dart';
import 'package:smart_home_app/electroniccomponentinformation.dart';
import 'package:smart_home_app/ledinformation.dart';
import 'package:smart_home_app/relayinformation.dart';
import 'package:smart_home_app/sensorinformation.dart';

class Space{
  String name = "";
  List<ElectronicComponent> electronicComponents = [];

  Space({required this.name});

  void removeElectronicComponentByName(String name) {
    electronicComponents
        .removeWhere((component) => component.electronicComponentInformation.name == name);
  }

  // Constructor from JSON
  Space.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
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
            // Handle other types if needed
            default:
              throw ArgumentError('Invalid electronic component type');
          }
          return ElectronicComponent(
              electronicComponentInformation,
              ElectronicView.getInformationViewByType(
                  electronicComponentInformation));
        }).toList();

  // Convert Space object to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'electronicComponents': electronicComponents
          .map((component) => component.electronicComponentInformation.toJson())
          .toList(),
    };
  }

}
