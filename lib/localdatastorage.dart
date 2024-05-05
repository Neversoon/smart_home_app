import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smart_home_app/space.dart';

class LocalDataStorage {
  String fileName;

  LocalDataStorage(this.fileName);

  Future<String> get _localPath async {
    if (!kIsWeb) {
      final directory = await getApplicationDocumentsDirectory();
      return directory.path;
    }
    return "C:\\";
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$fileName');
  }

  Future<void> saveData(List<Space> spaces) async {
    if (!kIsWeb) {
      try {
        final file = await _localFile;
        final jsonData = spaces.map((space) => space.toJson()).toList();
        final jsonString = jsonEncode(jsonData);
        await file.writeAsString(jsonString);
      } catch (e) {}
    }
  }

  Future<List<Space>> loadData() async {
    if (!kIsWeb) {
      try {
        final file = await _localFile;
        final jsonString = await file.readAsString();
        final jsonData = jsonDecode(jsonString) as List<dynamic>;
        return jsonData.map((json) => Space.fromJson(json)).toList();
      } catch (e) {
        // If encountering an error, return an empty list
        return [];
      }
    }
    return [];
  }
}
