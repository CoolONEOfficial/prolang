// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lang.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Lang _$_$_LangFromJson(Map<String, dynamic> json) {
  return _$_Lang(
    title: json['title'] as String,
    flag: json['flag'] as String,
    color: json['color'] as String,
    documentId: json['documentId'] as String,
    initials: json['initials'] as String,
    teacherId: json['teacherId'] as String,
    avatarBytes: json['avatarBytes'] as int,
    headerBytes: json['headerBytes'] as int,
    index: json['index'] as int,
  );
}

Map<String, dynamic> _$_$_LangToJson(_$_Lang instance) => <String, dynamic>{
      'title': instance.title,
      'flag': instance.flag,
      'color': instance.color,
      'documentId': instance.documentId,
      'initials': instance.initials,
      'teacherId': instance.teacherId,
      'avatarBytes': instance.avatarBytes,
      'headerBytes': instance.headerBytes,
      'index': instance.index,
    };
