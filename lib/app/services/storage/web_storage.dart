import 'package:firebase/firebase.dart';
import 'package:flutter/widgets.dart';

class FirebaseStorageService extends ChangeNotifier {
  FirebaseStorageService();

  static Future<String> loadFromStorage(String image) async {
    var url = await storage().ref(image).getDownloadURL();
    return url.toString();
  }
}