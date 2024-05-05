import 'package:flutter/material.dart';
import 'package:smart_home_app/ElectronicView.dart';
import 'package:smart_home_app/electroniccomponentinformation.dart';

abstract class InformationView extends ElectronicView {
  late StateSetter stateSetter;
  ElectronicComponentInformation electronicComponentInformation;

  InformationView(this.electronicComponentInformation);

  void updateView(
      ElectronicComponentInformation electronicComponentInformation) {
    stateSetter(() {
      this.electronicComponentInformation = electronicComponentInformation;
      print("changed to $electronicComponentInformation");
    });
  }
}
