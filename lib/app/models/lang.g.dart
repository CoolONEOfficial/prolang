// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lang.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lang _$LangFromJson(Map<String, dynamic> json) {
  return Lang(
    title: parseJsonMap(json['title']),
    flag: json['flag'] as String,
    color: json['color'] as String,
    documentId: json['documentId'] as String,
  );
}

Map<String, dynamic> _$LangToJson(Lang instance) => <String, dynamic>{
      'title': instance.title,
      'flag': instance.flag,
      'color': instance.color,
      'documentId': instance.documentId,
    };
