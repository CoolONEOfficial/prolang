import 'package:cloud_firestore/cloud_firestore.dart';

Map<String, dynamic> dataWithDocId(DocumentSnapshot snapshot) {
  final data = snapshot.data;
  data["documentId"] = snapshot.documentID;
  return data;
}
