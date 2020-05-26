// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Question _$_$_QuestionFromJson(Map<String, dynamic> json) {
  return _$_Question(
    title: json['title'] as String,
    answers: (json['answers'] as List)?.map((e) => e as String)?.toList(),
    correctAnswers:
        (json['correctAnswers'] as List)?.map((e) => e as int)?.toList(),
    documentId: json['documentId'] as String,
    index: json['index'] as int,
  );
}

Map<String, dynamic> _$_$_QuestionToJson(_$_Question instance) =>
    <String, dynamic>{
      'title': instance.title,
      'answers': instance.answers,
      'correctAnswers': instance.correctAnswers,
      'documentId': instance.documentId,
      'index': instance.index,
    };
