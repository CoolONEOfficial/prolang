import 'package:flutter/material.dart';

class FirebaseStorageService extends ChangeNotifier {
  FirebaseStorageService._();
  FirebaseStorageService();

  static Future<String> loadFromStorage(String image) {
    throw ("Platform not found");
  }
}