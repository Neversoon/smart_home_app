import 'package:flutter/material.dart';
import 'package:smart_home_app/addingview.dart';
import 'package:smart_home_app/electroniccomponent.dart';
import 'package:smart_home_app/electroniccomponentinformation.dart';
import 'package:smart_home_app/electronicview.dart';
import 'package:smart_home_app/informationview.dart';
import 'package:smart_home_app/ledaddingview.dart';
import 'package:smart_home_app/main.dart';
import 'package:smart_home_app/relayaddingview.dart';
import 'package:smart_home_app/sensoraddingview.dart';

class AddingComponentDialogs {
  List<ElectronicComponent> electronicComponents = [];

  ElectronicComponentType selectedType = ElectronicComponentType.Relay;

  Map<ElectronicComponentType, AddingView> viewBySelectedType = {
    ElectronicComponentType.Relay: RelayAddingView(),
    ElectronicComponentType.Led: LedAddingView(),
    ElectronicComponentType.Sensor: SensorAddingView(),
  };

  AddingComponentDialogs(this.electronicComponents);

  Widget showDialog(StateSetter setStateMain, BuildContext mainContext) {
    return AlertDialog(
      title: const Text("Add Electronic Component"),
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              DropdownButton<ElectronicComponentType>(
                value: selectedType,
                onChanged: (ElectronicComponentType? newValue) {
                  setState(() {
                    selectedType = newValue!;
                  });
                },
                items: ElectronicComponentType.values
                    .map<DropdownMenuItem<ElectronicComponentType>>(
                        (ElectronicComponentType value) {
                  return DropdownMenuItem<ElectronicComponentType>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
              ),
              viewBySelectedType[selectedType]?.getView(setState) ??
                  Container(),
            ],
          );
        },
      ),
      actions: <Widget>[
        TextButton(
          child: const Text("Cancel"),
          onPressed: () {
            Navigator.of(mainContext).pop();
          },
        ),
        TextButton(
          child: const Text("Add"),
          onPressed: () {
            setStateMain(() {
              ElectronicComponentInformation electronicComponentInformation = viewBySelectedType[selectedType]!.getData();
              InformationView informationView =
                  ElectronicView.getInformationViewByType(
                      electronicComponentInformation);
              informationView.stateSetter = setStateMain;
              electronicComponents.add(ElectronicComponent(
                      electronicComponentInformation, informationView));
              databaseConnector.PushData();

              localDataStorage.saveData(spaces);
            });
            Navigator.of(mainContext).pop();
          },
        ),
      ],
    );
  }
}
