import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prolang/app/models/lang.dart';

class FirestoreService {
  final Firestore _firestore;

  FirestoreService({Firestore firestore})
      : _firestore = firestore ?? Firestore.instance;

  Future<List<Lang>> loadLangList() async {
    var langListSnapshot = await _firestore.collection('langs').getDocuments();
    return langListSnapshot.documents.map((langSnapshot) => Lang.fromJson(langSnapshot.data)).toList();
  }
}
