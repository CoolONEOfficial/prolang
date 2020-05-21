// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lang.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lang _$LangFromJson(Map<String, dynamic> json) {
  return Lang(
    parseJsonMap(json['title']),
    json['flag'] as String,
    json['color'] as String,
    json['documentId'] as String,
    (json['sections'] as List)
            ?.map((e) => e == null
                ? null
                : LessonSection.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [],
    json['teacher'] as String,
  );
}

Map<String, dynamic> _$LangToJson(Lang instance) => <String, dynamic>{
      'title': instance.title,
      'sections': instance.sections,
      'flag': instance.flag,
      'color': instance.color,
      'documentId': instance.documentId,
      'teacher': instance.teacher,
    };
