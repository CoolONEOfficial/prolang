import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:prolang/app/helpers/add_doc_id.dart';
import 'package:prolang/app/helpers/parse_json_map.dart';

import 'lesson_section.dart';

part 'lang.freezed.dart';
part 'lang.g.dart';

@freezed
abstract class Lang with _$Lang {
  factory Lang({
  @JsonKey(fromJson: parseJsonMap)
  Map<String, String> title,
  @JsonKey(nullable: true, defaultValue: [])
  List<LessonSection> sections,
  String flag,
  String color,
  String documentId,
  String teacher,
  }) = _Lang;

  factory Lang.fromSnapshot(DocumentSnapshot snapshot) => Lang.fromJson(dataWithDocId(snapshot));
  factory Lang.fromJson(Map<String, dynamic> json) => _$LangFromJson(json);
}
