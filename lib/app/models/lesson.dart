import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';

part 'lesson.g.dart';

@JsonSerializable(nullable: false)
@immutable
class Lesson {
  const Lesson({
    this.number,
    this.section,
    this.documentId,
    this.title,
  });

  final String title;
  final int number;
  final int section;
  final String documentId;

  factory Lesson.fromSnapshot(DocumentSnapshot snapshot) {
    snapshot.data["documentId"] = snapshot.documentID;
    return Lesson.fromJson(snapshot.data);
  }
  factory Lesson.fromJson(Map<String, dynamic> json) => _$LessonFromJson(json);
  Map<String, dynamic> toJson() => _$LessonToJson(this);
}
