import 'package:flutter/material.dart';
import 'package:smart_home_app/electroniccomponentinformation.dart';
import 'package:smart_home_app/informationview.dart';
import 'package:smart_home_app/main.dart';
import 'package:smart_home_app/relayinformation.dart';

class RelayInformationView extends InformationView {
  RelayInformationView(ElectronicComponentInformation relayInformation)
      : super(relayInformation);

  @override
  Widget getView(StateSetter stateSetter) {
    this.stateSetter = stateSetter;
    RelayInformation relayInformation =
        electronicComponentInformation as RelayInformation;
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
                  "Relay",
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
                        onTap: () {
                          electronicComponentConrol
                              .removeElectronicComponent(relayInformation);
                          databaseConnector.PushData();
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
              relayInformation.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'Pin: ${relayInformation.pin}',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                Switch(
                  value: relayInformation.status,
                  onChanged: (bool value) {
                    stateSetter(() {
                      print("Value changed to ${value.toString()}");
                      relayInformation.status = value;
                      electronicComponentInformation.status = value;
                      print(electronicComponentInformation.hashCode);
                      print(
                          "Value Relay changed to ${relayInformation.status}");
                      print(
                          "Value Electronic component changed to ${electronicComponentInformation.status}");
                      databaseConnector.PushData();
                    });
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
