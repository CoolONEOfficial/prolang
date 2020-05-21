// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_section.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LessonSection _$LessonSectionFromJson(Map<String, dynamic> json) {
  return LessonSection(
    json['title'] as String,
    json['description'] as String,
  );
}

Map<String, dynamic> _$LessonSectionToJson(LessonSection instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
    };
