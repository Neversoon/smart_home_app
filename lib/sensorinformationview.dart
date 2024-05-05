import 'package:flutter/material.dart';
import 'package:smart_home_app/electroniccomponentinformation.dart';
import 'package:smart_home_app/informationview.dart';
import 'package:smart_home_app/main.dart';
import 'package:smart_home_app/sensorinformation.dart';

class SensorInformationView extends InformationView {
  SensorInformationView(ElectronicComponentInformation sensorInformation)
      : super(sensorInformation);

  @override
  Widget getView(StateSetter stateSetter) {
    SensorInformation sensorInformation =
        electronicComponentInformation as SensorInformation;
    this.stateSetter = stateSetter;
    return Card(
      elevation: 4, // Добавляем небольшую тень для карточки
      margin: const EdgeInsets.all(8), // Добавляем небольшой внешний отступ
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Sensor",
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
                          electronicComponentConrol.removeElectronicComponent(sensorInformation);
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
              sensorInformation.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.pin_drop, size: 20),
                const SizedBox(width: 8),
                Text(
                  "Pin: ${sensorInformation.pin.toString()}",
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.timeline, size: 20),
                const SizedBox(width: 8),
                Text(
                  "Current value: ${sensorInformation.value}",
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
