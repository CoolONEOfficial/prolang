import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';

part 'lesson.g.dart';

@JsonSerializable(nullable: false)
@immutable
class Lesson {
  const Lesson({
    this.title,
  });

  final String title;

  factory Lesson.fromSnapshot(DocumentSnapshot snapshot) {
    snapshot.data["documentId"] = snapshot.documentID;
    return Lesson.fromJson(snapshot.data);
  }
  factory Lesson.fromJson(Map<String, dynamic> json) => _$LessonFromJson(json);
  Map<String, dynamic> toJson() => _$LessonToJson(this);
}
