// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lesson _$LessonFromJson(Map<String, dynamic> json) {
  return Lesson(
    number: json['number'] as int,
    section: json['section'] as int,
    documentId: json['documentId'] as String,
    title: json['title'] as String,
  );
}

Map<String, dynamic> _$LessonToJson(Lesson instance) => <String, dynamic>{
      'title': instance.title,
      'number': instance.number,
      'section': instance.section,
      'documentId': instance.documentId,
    };
