// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phrase.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Phrase _$_$_PhraseFromJson(Map<String, dynamic> json) {
  return _$_Phrase(
    original: json['original'] as String,
    translated: json['translated'] as String,
    documentId: json['documentId'] as String,
    index: json['index'] as int,
  );
}

Map<String, dynamic> _$_$_PhraseToJson(_$_Phrase instance) => <String, dynamic>{
      'original': instance.original,
      'translated': instance.translated,
      'documentId': instance.documentId,
      'index': instance.index,
    };
