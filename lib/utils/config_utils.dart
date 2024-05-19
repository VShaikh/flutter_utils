import 'dart:convert';
import 'dart:io';

import 'package:flutter_utils/main.dart';

class LocalConfigStorage {
  static LocalConfigStorage? instance;
  late String _dataFilePath;

  final Map<String, dynamic> _dataMap = {};

  static LocalConfigStorage getInstance() {
    instance ??= LocalConfigStorage();
    return instance!;
  }

  Future<void> init(Map<String, dynamic> data) async {
    if (isAndroid()) {
      if (uLocalFolder == null) await initGLocalFolder();
      _dataFilePath = _getPropertiesFilePath();
      !_existsDataFile() ? _persistData(data) : {};
    } else {
      _dataMap.clear();
      _dataMap.addAll(data);
    }
  }

  bool _existsDataFile() => existsFile(_dataFilePath);

  String _getPropertiesFilePath() => "$uLocalFolder/properties.json";

  Future<void> resetConfig(Map<String, dynamic> data) async {
    if (isAndroid()) {
      _deleteDataFile();
    }
    await init(data);
  }

  void _deleteDataFile() =>
      isAndroid() && existsFile(_dataFilePath)
          ? File(_dataFilePath).deleteSync()
          : {};

  Map<String, dynamic> _dataFromFile() {
    if (existsFile(_dataFilePath) && fileContent(_dataFilePath).isNotEmpty) {
      var content = fileContent(_dataFilePath);
      return jsonDecode(content) as Map<String, dynamic>;
    } else {
      throw Exception("Config file not found: $_dataFilePath");
    }
  }

  bool _existsInDataFile(String key) {
    Map<String, dynamic> map = _dataFromFile();
    return map.isNotEmpty && map.containsKey(key);
  }

  bool _existsIn(Map<String, dynamic> data, String key) =>
      data.entries
          .where((e) => e.key == key)
          .isNotEmpty;

  dynamic _get(String key) {
    var dataMap = _dataMap;
    if (isAndroid()) {
      dataMap = _dataFromFile();
    }
    if (_existsIn(dataMap, key)) {
      return dataMap.entries
          .firstWhere((e) => e.key == key)
          .value;
    } else {
      throw Exception("No value found for $key");
    }
  }

  void set(String key, dynamic value) {
    if (isAndroid()) {
      Map<String, dynamic> map = _dataFromFile();
      if (_existsInDataFile(key)) {
        map.update(key, (v) => value);
      } else {
        map[key] = value;
      }
      _saveDataValues(map);
    } else {
      _dataMap.update(key, (curValue) => value, ifAbsent: () => value);
    }
  }

  void _saveDataValues(Map<String, dynamic> data) {
    saveContent(_dataFilePath, jsonEncode(data));
  }

  void _persistData(Map<String, dynamic> data) {
    saveContent(_dataFilePath,
        jsonEncode(data.map((key, value) => MapEntry(key, value))));
  }

  dynamic get(String key) => _get(key);

  bool getBool(String key) => _get(key);

  String getString(String key) => _get(key);

  int getInt(String key) => _get(key);
}
