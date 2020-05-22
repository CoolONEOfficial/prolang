// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lang.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Lang _$_$_LangFromJson(Map<String, dynamic> json) {
  return _$_Lang(
    title: parseJsonMap(json['title']),
    flag: json['flag'] as String,
    color: json['color'] as String,
    documentId: json['documentId'] as String,
    teacher: json['teacher'] as String,
  );
}

Map<String, dynamic> _$_$_LangToJson(_$_Lang instance) => <String, dynamic>{
      'title': instance.title,
      'flag': instance.flag,
      'color': instance.color,
      'documentId': instance.documentId,
      'teacher': instance.teacher,
    };
