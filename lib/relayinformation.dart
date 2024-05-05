import 'package:smart_home_app/electroniccomponentinformation.dart';

class RelayInformation extends ElectronicComponentInformation {
  @override
  String get type => "Relay";
  int pin = 0;
  bool relayType = false;

  RelayInformation(String name, this.pin, this.relayType, bool status)
      : super(name, status);

  @override
  String get parsedName =>
      "$name.$type.$pin.$status,$relayType";

  @override
  RelayInformation.fromJson(Map<String, dynamic> json)
      : pin = json['pin'] as int,
        relayType = json['relayType'] as bool,
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json['pin'] = pin;
    json['relayType'] = relayType;
    return json;
  }
}
