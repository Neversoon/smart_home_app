enum ElectronicComponentType { Relay, Led, Sensor }

abstract class ElectronicComponentInformation {
  bool status;
  String name;
  String get type;

  ElectronicComponentInformation(this.name, this.status);

  String get parsedName => "$name.$type.$status";

  ElectronicComponentInformation.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        status = json['status'] as bool;

  Map<String, dynamic> toJson() =>
      {'name': name, 'status': status, 'type': type};
}

