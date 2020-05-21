import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'lesson_section.g.dart';

@JsonSerializable(nullable: false)
@immutable
class LessonSection {
  const LessonSection(
    this.title,
    this.description,
  );

  final String title;
  final String description;

  factory LessonSection.fromJson(Map<String, dynamic> json) =>
      _$LessonSectionFromJson(json);
  Map<String, dynamic> toJson() => _$LessonSectionToJson(this);
}
