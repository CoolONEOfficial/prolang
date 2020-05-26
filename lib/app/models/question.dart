import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:prolang/app/helpers/add_doc_id.dart';
import 'package:prolang/app/mixins/index_mixin.dart';

part 'question.freezed.dart';
part 'question.g.dart';

@freezed
abstract class Question with _$Question, IndexMixin {
  factory Question({
    final String title,
    final List<String> answers,
    final List<int> correctAnswers,
    final String documentId,
    final int index,
  }) = _Question;

  factory Question.fromSnapshot(DocumentSnapshot snapshot) => Question.fromJson(dataWithDocId(snapshot));
  factory Question.fromJson(Map<String, dynamic> json) => _$QuestionFromJson(json);
}
