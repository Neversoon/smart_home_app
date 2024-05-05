import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_home_app/addingview.dart';
import 'package:smart_home_app/electroniccomponentinformation.dart';
import 'package:smart_home_app/sensorinformation.dart';

class SensorAddingView extends AddingView {
  TextEditingController type = TextEditingController();
  TextEditingController pin = TextEditingController();
  String sensorSubType = "analog";
  @override
  Widget getView(StateSetter stateSetter) {
    return Column(
      children: [
        const Text('Name'),
        TextFormField(
          controller: name,
          inputFormatters: <TextInputFormatter>[
            LengthLimitingTextInputFormatter(50),
            FilteringTextInputFormatter.deny(RegExp(r'[.,|]')),
          ],
        ),
        DropdownButton<String>(
            value: sensorSubType,
            onChanged: (String? newValue) {
              stateSetter(() {
                sensorSubType = newValue!;
              });
            },
            items: const [
              DropdownMenuItem(value: "analog", child: Text("Analog")),
              DropdownMenuItem(value: "digital", child: Text("Digital"))
            ]),
        const Text('Pin'),
        TextFormField(
          controller: pin,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            LengthLimitingTextInputFormatter(3),
            FilteringTextInputFormatter.digitsOnly
          ],
        ),
      ],
    );
  }

  @override
  ElectronicComponentInformation getData() {
    SensorInformation sensorInformation = SensorInformation(
        name.value.text, int.parse(pin.value.text), "Value", sensorSubType, true);
    return sensorInformation;
  }
}
