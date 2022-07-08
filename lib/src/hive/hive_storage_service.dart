import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:lead_management_system/src/hive/db.dart';

class HiveDataStorageService {
  static final HiveDataStorageService _instance = HiveDataStorageService._();

  static final HiveDataProvider _hiveDataProvider = HiveDataProvider();

  factory HiveDataStorageService() => _instance;

  HiveDataStorageService._();

  /// Method to set User
  static logUserIn() async {
    await _hiveDataProvider.insertData("user", {"loggedIn": true});
  }

  /// Method to get User
  static Future<bool> getUser() async {
    if (!kIsWeb) {
      String path = Directory.current.path;
      Hive.init(path);
    }
    Map response = await _hiveDataProvider.readData("user");
    return ((response.isNotEmpty ? response["loggedIn"] : false) ?? false);
  }

  static logOutUser() async {
    await _hiveDataProvider.deleteData("user");
  }
}
