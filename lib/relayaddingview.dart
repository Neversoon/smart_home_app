import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_home_app/addingview.dart';
import 'package:smart_home_app/electroniccomponentinformation.dart';
import 'package:smart_home_app/relayinformation.dart';

class RelayAddingView extends AddingView {
  TextEditingController type = TextEditingController();
  TextEditingController pin = TextEditingController();
  bool relayType = true;

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
        const Text('Relay type'),
        Switch(
          value: relayType,
          onChanged: (bool value) {
            // Update the relayType and rebuild the UI
            stateSetter(() {
              relayType = value;
            });
          },
        ),
      ],
    );
  }

  @override
  ElectronicComponentInformation getData() {
    RelayInformation relayInfo = RelayInformation(
        name.value.text, int.parse(pin.value.text), relayType, true);
    return relayInfo;
  }
}
