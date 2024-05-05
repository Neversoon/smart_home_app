import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_home_app/addingview.dart';
import 'package:smart_home_app/electroniccomponentinformation.dart';
import 'package:smart_home_app/ledinformation.dart';

class LedAddingView extends AddingView {
  TextEditingController pin = TextEditingController();

  @override
  Widget getView(StateSetter stateSetter) {
    return Column(
      children: [
        const Text('Name'),
        TextFormField(
          controller: name,
          inputFormatters: <TextInputFormatter>[
            LengthLimitingTextInputFormatter(50),
            FilteringTextInputFormatter.deny(RegExp(r'[.,|]')), // Запрещаем ввод . , |
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
      ],
    );
  }

  @override
  ElectronicComponentInformation getData() {
    LedInformation relayInfo =
        LedInformation(name.value.text, int.parse(pin.value.text), true);
    // Create Relay instance using RelayInformation
    return relayInfo;
  }
}
