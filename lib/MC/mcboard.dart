import 'package:smart_home_app/MC/pinout.dart';

class McBoard {
  int id = -1;
  String name = "";
  String description = "";
  String iconPath = "";
  List<Pinout> pinout = List.empty();

  McBoard(this.id, this.name, this.description, this.pinout, {this.iconPath = ""});

  McBoard clone() {
    return McBoard(
      id,
      name,
      description,
      List<Pinout>.from(pinout.map((p) => Pinout(
        p.pin,
        p.functionPin,
        p.functionDescription,
        p.type,
        p.description,
      ))),
      iconPath: iconPath,
    );
  }

  McBoard.fromJson(Map<String, dynamic> json)
      : name = json['name'] ?? "",
        description = json['description'] ?? "",
        iconPath = json['iconPath'] ?? "",
        pinout = (json['pinout'] as List<dynamic>)
            .map((e) => Pinout.fromJson(e))
            .toList();

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'iconPath': iconPath,
      'pinout': pinout.map((e) => e.toJson()).toList(),
    };
  }
}
