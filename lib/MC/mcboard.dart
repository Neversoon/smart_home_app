import 'package:smart_home_app/MC/pinout.dart';

class McBoard {
  String name = "";
  String description = "";
  String iconPath = "";
  List<Pinout> pinout = List.empty();
  McBoard(this.name, this.description, this.pinout, {this.iconPath = ""});
}
