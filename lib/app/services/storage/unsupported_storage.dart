import 'dart:typed_data';

import 'package:flutter/material.dart';

class FirebaseStorageService extends ChangeNotifier {
  FirebaseStorageService._();
  FirebaseStorageService();

  static Future<String> loadFromStorage(String path) {
    throw ("Platform not found");
  }

  static uploadToStorage(Uint8List data, String path) async {
    throw ("Platform not found");
  }
}
