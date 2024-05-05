import 'package:smart_home_app/electroniccomponent.dart';
import 'package:smart_home_app/electroniccomponentinformation.dart';
import 'package:smart_home_app/relayinformation.dart';
import 'package:smart_home_app/relayinformationview.dart';

class Relay extends ElectronicComponent {
  Relay(
      {required ElectronicComponentInformation electronicComponentInformation})
      : super(
            electronicComponentInformation,
            RelayInformationView(
                electronicComponentInformation as RelayInformation));
}
