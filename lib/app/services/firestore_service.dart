import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:prolang/app/models/lang.dart';
import 'package:prolang/app/models/lesson.dart';

class FirestoreService {
  final Firestore _firestore;

  FirestoreService({Firestore firestore})
      : _firestore = firestore ?? Firestore.instance;

  Future<List<Lang>> loadLangList() async {
    var langListSnapshot = await _firestore.collection('langs').getDocuments();
    return langListSnapshot.documents
        .map((langSnapshot) => Lang.fromSnapshot(langSnapshot))
        .toList();
  }

  Future<List<Lesson>> loadLessonList(Lang lang) async {
    var langListSnapshot = await _firestore
        .collection('langs')
        .document(lang.documentId)
        .collection('lessons')
        .orderBy('number')
        .getDocuments();

    debugPrint("lang id: ${lang.documentId}");
    
    return langListSnapshot.documents
        .map((langSnapshot) {
          debugPrint("data: ${langSnapshot.data}");
          return Lesson.fromSnapshot(langSnapshot);
        })
        .toList();
  }
}
