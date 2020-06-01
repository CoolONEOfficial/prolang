import 'dart:typed_data';

import 'package:firebase/firebase.dart';
import 'package:flutter/widgets.dart';

class FirebaseStorageService extends ChangeNotifier {
  FirebaseStorageService();

  static Future<String> loadFromStorage(String path) async {
    var url = await storage().ref(path).getDownloadURL();
    return url.toString();
  }

  static uploadToStorage(Uint8List data, String path) async {
    StorageReference storageRef = storage().ref(path);
    UploadTaskSnapshot uploadTaskSnapshot = await storageRef.put(data).future;

    Uri imageUri = await uploadTaskSnapshot.ref.getDownloadURL();
    return imageUri;
  }
}
