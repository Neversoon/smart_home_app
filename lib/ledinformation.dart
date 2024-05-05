import 'package:smart_home_app/electroniccomponentinformation.dart';

class LedInformation extends ElectronicComponentInformation {
  @override
  String get type => "Led";

  int pin = 0;

  LedInformation(String name, this.pin, bool status) : super(name, status);

  @override
  String get parsedName => "$name.$type.$pin.$status";

  @override
  LedInformation.fromJson(Map<String, dynamic> json)
      : pin = json['pin'] as int,
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json['pin'] = pin;
    return json;
  }
}
