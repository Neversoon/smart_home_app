import 'package:flutter/material.dart';
import 'package:smart_home_app/electroniccomponentinformation.dart';
import 'package:smart_home_app/informationview.dart';
import 'package:smart_home_app/ledinformation.dart';
import 'package:smart_home_app/ledinformationview.dart';
import 'package:smart_home_app/relayinformation.dart';
import 'package:smart_home_app/relayinformationview.dart';
import 'package:smart_home_app/sensorinformation.dart';
import 'package:smart_home_app/sensorinformationview.dart';

abstract class ElectronicView {
  Widget getView(StateSetter stateSetter);
  static InformationView getInformationViewByType(
      ElectronicComponentInformation componentInformation) {
    switch (componentInformation.type) {
      case "Relay":
        return RelayInformationView(componentInformation as RelayInformation);
      case "Led":
        return LedInformationView(componentInformation as LedInformation);
      case "Sensor":
        return SensorInformationView(componentInformation as SensorInformation);
      default:
        throw Exception("Error type");
    }
  }
}
