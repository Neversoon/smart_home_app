import 'package:smart_home_app/electroniccomponent.dart';
import 'package:smart_home_app/electroniccomponentinformation.dart';
import 'package:smart_home_app/sensorinformation.dart';
import 'package:smart_home_app/sensorinformationview.dart';

class Sensor extends ElectronicComponent {
  Sensor(
      {required ElectronicComponentInformation electronicComponentInformation})
      : super(
            electronicComponentInformation,
            SensorInformationView(
                electronicComponentInformation as SensorInformation));
}
