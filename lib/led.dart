import 'package:smart_home_app/electroniccomponent.dart';
import 'package:smart_home_app/electroniccomponentinformation.dart';
import 'package:smart_home_app/ledinformation.dart';
import 'package:smart_home_app/ledinformationview.dart';

class Led extends ElectronicComponent{
  Led({required ElectronicComponentInformation electronicComponentInformation}) : super(electronicComponentInformation, LedInformationView(electronicComponentInformation as LedInformation));
}