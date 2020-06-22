import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:prolang/app/helpers/add_doc_id.dart';
import 'package:prolang/app/mixins/index_mixin.dart';

part 'lesson.freezed.dart';
part 'lesson.g.dart';

@freezed
abstract class Lesson with _$Lesson, IndexMixin {
  factory Lesson({
    final String title,
    final String description,
    final String documentId,
    @JsonKey(nullable: true, defaultValue: 0)
    final int videoBytes,
    @JsonKey(nullable: true, defaultValue: 0)
    final int grammarBytes,
    @JsonKey(nullable: true, defaultValue: 0)
    final int pdfBytes,
    @JsonKey(nullable: true, defaultValue: 0)
    final int imageBytes,
    @JsonKey(nullable: true, defaultValue: 0)
    final int audioBytes,
    final int index,
  }) = _Lesson;

  factory Lesson.fromSnapshot(DocumentSnapshot snapshot) => Lesson.fromJson(dataWithDocId(snapshot));
  factory Lesson.fromJson(Map<String, dynamic> json) => _$LessonFromJson(json);
}
