import 'package:smart_home_app/electroniccomponentinformation.dart';

class SensorInformation extends ElectronicComponentInformation {
  @override
  String get type => "Sensor";
  
  int pin;
  String value;
  String subType;
  SensorInformation(String name, this.pin, this.value, this.subType, bool status) 
    : super(name, status);

  @override
  String get parsedName => "$name.$type.$pin.$value,$subType";
  
  @override
  SensorInformation.fromJson(Map<String, dynamic> json)
      : pin = json['pin'] as int,
        value = json['value'] as String,
        subType = json['subtype'] as String,
        super.fromJson(json);
  
  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json['pin'] = pin;
    json['value'] = value;
    json['subtype'] = subType;
    return json;
  }
}
