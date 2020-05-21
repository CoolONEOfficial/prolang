import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:prolang/app/helpers/add_doc_id.dart';

part 'lesson_section.freezed.dart';
part 'lesson_section.g.dart';

@freezed
abstract class LessonSection with _$LessonSection {
  factory LessonSection({
    final String title,
    final String description,
  }) = _LessonSection;

  factory LessonSection.fromSnapshot(DocumentSnapshot snapshot) => LessonSection.fromJson(dataWithDocId(snapshot));
  factory LessonSection.fromJson(Map<String, dynamic> json) => _$LessonSectionFromJson(json);
}
