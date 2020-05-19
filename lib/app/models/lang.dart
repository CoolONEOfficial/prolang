import 'package:cloud_firestore/cloud_firestore.dart';
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
  });

  @JsonKey(fromJson: parseJsonMap)
  final Map<String, String> title;
  final String flag;
  final String color;
  final String documentId;

  factory Lang.fromSnapshot(DocumentSnapshot snapshot) {
    snapshot.data["documentId"] = snapshot.documentID;
    return Lang.fromJson(snapshot.data);
  }
  factory Lang.fromJson(Map<String, dynamic> json) => _$LangFromJson(json);
  Map<String, dynamic> toJson() => _$LangToJson(this);
}