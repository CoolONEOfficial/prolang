// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Lesson _$_$_LessonFromJson(Map<String, dynamic> json) {
  return _$_Lesson(
    title: json['title'] as String,
    description: json['description'] as String,
    documentId: json['documentId'] as String,
    index: json['index'] as int,
  );
}

Map<String, dynamic> _$_$_LessonToJson(_$_Lesson instance) => <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'documentId': instance.documentId,
      'index': instance.index,
    };
