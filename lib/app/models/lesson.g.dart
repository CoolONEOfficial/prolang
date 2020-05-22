// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Lesson _$_$_LessonFromJson(Map<String, dynamic> json) {
  return _$_Lesson(
    title: json['title'] as String,
    section: json['section'] as int,
    documentId: json['documentId'] as String,
    index: json['index'] as int,
  );
}

Map<String, dynamic> _$_$_LessonToJson(_$_Lesson instance) => <String, dynamic>{
      'title': instance.title,
      'section': instance.section,
      'documentId': instance.documentId,
      'index': instance.index,
    };
