// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_section.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_LessonSection _$_$_LessonSectionFromJson(Map<String, dynamic> json) {
  return _$_LessonSection(
    title: json['title'] as String,
    description: json['description'] as String,
    documentId: json['documentId'] as String,
    index: json['index'] as int,
  );
}

Map<String, dynamic> _$_$_LessonSectionToJson(_$_LessonSection instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'documentId': instance.documentId,
      'index': instance.index,
    };
