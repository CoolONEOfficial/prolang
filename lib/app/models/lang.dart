import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:prolang/app/helpers/parse_json_map.dart';

part 'lang.g.dart';

@JsonSerializable(nullable: false)
@immutable
class Lang {
  const Lang({
    this.title,
    this.flag,
    this.color,
    this.documentId,
    this.sections,
    this.teacher,
  });

  @JsonKey(fromJson: parseJsonMap)
  final Map<String, String> title;
  @JsonKey(nullable: true, defaultValue: [])
  final List<String> sections;
  final String flag;
  final String color;
  final String documentId;
  final String teacher;

  factory Lang.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data;
    data["documentId"] = snapshot.documentID;
    return Lang.fromJson(data);
  }
  factory Lang.fromJson(Map<String, dynamic> json) => _$LangFromJson(json);
  Map<String, dynamic> toJson() => _$LangToJson(this);
}
