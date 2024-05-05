import 'package:flutter/material.dart';
import 'package:smart_home_app/electroniccomponent.dart';
import 'package:smart_home_app/electroniccomponentinformation.dart';
import 'package:smart_home_app/space.dart';

class ElectronicComponentConrol {
  List<Space> spaces;
  late StateSetter stateSetter;
  ElectronicComponentConrol(this.spaces);

void removeElectronicComponent(
    ElectronicComponentInformation electronicComponentInformation) {
  for (var element in spaces) {
    try {
      ElectronicComponent electronicComponent = element.electronicComponents
          .singleWhere((element) =>
              element.electronicComponentInformation.name ==
              electronicComponentInformation.name);
      stateSetter(
          () => element.electronicComponents.remove(electronicComponent));
    } catch (e) {
      print("No matching electronic component found.");
    }
  }
}

  void ChangeStateSetter(StateSetter stateSetter) {
    this.stateSetter = stateSetter;
  }
}
