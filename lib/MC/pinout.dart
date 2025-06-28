class Pinout {
  String pin = "";
  int functionPin = 0;
  String functionDescription = "";
  String type = "";
  String description = "";

  Pinout(this.pin, this.functionPin, this.functionDescription, this.type, this.description);

  factory Pinout.fromJson(Map<String, dynamic> json) {
    return Pinout(
      json['pin'] ?? '',
      json['functionPin'] ?? 0,
      json['functionDescription'] ?? '',
      json['type'] ?? '',
      json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pin': pin,
      'functionPin': functionPin,
      'functionDescription': functionDescription,
      'type': type,
      'description': description,
    };
  }
}
