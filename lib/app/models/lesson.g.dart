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
    videoBytes: json['videoBytes'] as int ?? 0,
    grammarBytes: json['grammarBytes'] as int ?? 0,
    pdfBytes: json['pdfBytes'] as int ?? 0,
    imageBytes: json['imageBytes'] as int ?? 0,
    audioBytes: json['audioBytes'] as int ?? 0,
    index: json['index'] as int,
  );
}

Map<String, dynamic> _$_$_LessonToJson(_$_Lesson instance) => <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'documentId': instance.documentId,
      'videoBytes': instance.videoBytes,
      'grammarBytes': instance.grammarBytes,
      'pdfBytes': instance.pdfBytes,
      'imageBytes': instance.imageBytes,
      'audioBytes': instance.audioBytes,
      'index': instance.index,
    };
