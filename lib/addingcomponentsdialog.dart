import 'package:flutter/material.dart';
import 'package:smart_home_app/MC/mcboard.dart';
import 'package:smart_home_app/MC/mctemplates.dart';
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

  ElectronicComponentType selectedTypeElectronicComponent =
      ElectronicComponentType.Relay;

  Map<ElectronicComponentType, AddingView> viewBySelectedType = {
    ElectronicComponentType.Relay: RelayAddingView(),
    ElectronicComponentType.Led: LedAddingView(),
    ElectronicComponentType.Sensor: SensorAddingView(),
  };

  AddingComponentDialogs(this.electronicComponents);

  Widget showElectronicComponentDialog(
      StateSetter setStateMain, BuildContext mainContext) {
    return AlertDialog(
      title: const Text("Add Electronic Component"),
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              DropdownButton<ElectronicComponentType>(
                value: selectedTypeElectronicComponent,
                onChanged: (ElectronicComponentType? newValue) {
                  setState(() {
                    selectedTypeElectronicComponent = newValue!;
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
              viewBySelectedType[selectedTypeElectronicComponent]
                      ?.getView(setState) ??
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
              ElectronicComponentInformation electronicComponentInformation =
                  viewBySelectedType[selectedTypeElectronicComponent]!
                      .getData();
              InformationView informationView =
                  ElectronicView.getInformationViewByType(
                      electronicComponentInformation);
              informationView.stateSetter = setStateMain;
              electronicComponents.add(ElectronicComponent(
                  electronicComponentInformation, informationView));
              databaseConnector.SetData();

              localDataStorage.saveData(spaces);
            });
            Navigator.of(mainContext).pop();
          },
        ),
      ],
    );
  }

  Widget showMCComponentDialog(
      StateSetter setStateMain, BuildContext mainContext) {
    return AlertDialog(
      title: const Text("Add your MC"),
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return SizedBox(
            height: 350,
            width: double.maxFinite,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 12.0,
                childAspectRatio: 0.9,
              ),
              itemCount: boards.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    print("Pressed: ${boards[index].name}");
                    // you can also update state or close the dialog here
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 100.0,
                          width: 100.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: AssetImage(boards[index].iconPath),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          boards[index].name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          boards[index].description,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
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
      ],
    );
  }
}
