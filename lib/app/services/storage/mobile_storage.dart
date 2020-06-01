import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FirebaseStorageService extends ChangeNotifier {
  FirebaseStorageService();

  static Future<String> loadFromStorage(String path) async {
    return await FirebaseStorage.instance.ref().child(path).getDownloadURL();
  }

  static uploadToStorage(Uint8List data, String path) async {
    StorageReference storageRef = FirebaseStorage.instance.ref().child(path);
    await storageRef.putData(data).onComplete;
  }
}
