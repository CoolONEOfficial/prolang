import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:prolang/app/helpers/add_doc_id.dart';

part 'lesson.freezed.dart';
part 'lesson.g.dart';

@freezed
abstract class Lesson with _$Lesson {
  factory Lesson({
    final String title,
    final int number,
    final int section,
    final String documentId,
  }) = _Lesson;

  factory Lesson.fromSnapshot(DocumentSnapshot snapshot) => Lesson.fromJson(dataWithDocId(snapshot));
  factory Lesson.fromJson(Map<String, dynamic> json) => _$LessonFromJson(json);
}
