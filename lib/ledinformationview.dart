import 'package:flutter/material.dart';
import 'package:smart_home_app/electroniccomponentinformation.dart';
import 'package:smart_home_app/informationview.dart';
import 'package:smart_home_app/ledinformation.dart';
import 'package:smart_home_app/main.dart';

class LedInformationView extends InformationView {
  LedInformationView(ElectronicComponentInformation ledInformation) : super(ledInformation);

  @override
  Widget getView(StateSetter stateSetter) {
    this.stateSetter = stateSetter;
    LedInformation ledInformation =
        electronicComponentInformation as LedInformation;
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Led",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                PopupMenuButton(
                  itemBuilder: (BuildContext context) {
                    return <PopupMenuEntry>[
                      PopupMenuItem(
                        value: 1,
                        onTap: () => {
                          electronicComponentConrol
                              .removeElectronicComponent(ledInformation),
                          databaseConnector.PushData()
                        },
                        child: const Text('Delete'),
                      ),
                    ];
                  },
                  icon: const Icon(Icons.more_vert),
                ),
              ],
            ),
            Text(
              ledInformation.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'Pin: ${ledInformation.pin}',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                Switch(
                  value: electronicComponentInformation.status,
                  onChanged: (bool value) {
                    stateSetter(
                      () {
                        electronicComponentInformation.status = value;
                        for (var element in spaces) {
                          for (var elementElect
                              in element.electronicComponents) {
                            print("Before push data: ${elementElect
                                    .electronicComponentInformation.status}");
                          }
                        }
                      },
                    );
                    databaseConnector.PushData();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
