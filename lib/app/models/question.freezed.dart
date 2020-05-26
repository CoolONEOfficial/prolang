// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'question.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Question _$QuestionFromJson(Map<String, dynamic> json) {
  return _Question.fromJson(json);
}

class _$QuestionTearOff {
  const _$QuestionTearOff();

  _Question call(
      {String title,
      List<String> answers,
      List<int> correctAnswers,
      String documentId,
      int index}) {
    return _Question(
      title: title,
      answers: answers,
      correctAnswers: correctAnswers,
      documentId: documentId,
      index: index,
    );
  }
}

// ignore: unused_element
const $Question = _$QuestionTearOff();

mixin _$Question {
  String get title;
  List<String> get answers;
  List<int> get correctAnswers;
  String get documentId;
  int get index;

  Map<String, dynamic> toJson();
  $QuestionCopyWith<Question> get copyWith;
}

abstract class $QuestionCopyWith<$Res> {
  factory $QuestionCopyWith(Question value, $Res Function(Question) then) =
      _$QuestionCopyWithImpl<$Res>;
  $Res call(
      {String title,
      List<String> answers,
      List<int> correctAnswers,
      String documentId,
      int index});
}

class _$QuestionCopyWithImpl<$Res> implements $QuestionCopyWith<$Res> {
  _$QuestionCopyWithImpl(this._value, this._then);

  final Question _value;
  // ignore: unused_field
  final $Res Function(Question) _then;

  @override
  $Res call({
    Object title = freezed,
    Object answers = freezed,
    Object correctAnswers = freezed,
    Object documentId = freezed,
    Object index = freezed,
  }) {
    return _then(_value.copyWith(
      title: title == freezed ? _value.title : title as String,
      answers: answers == freezed ? _value.answers : answers as List<String>,
      correctAnswers: correctAnswers == freezed
          ? _value.correctAnswers
          : correctAnswers as List<int>,
      documentId:
          documentId == freezed ? _value.documentId : documentId as String,
      index: index == freezed ? _value.index : index as int,
    ));
  }
}

abstract class _$QuestionCopyWith<$Res> implements $QuestionCopyWith<$Res> {
  factory _$QuestionCopyWith(_Question value, $Res Function(_Question) then) =
      __$QuestionCopyWithImpl<$Res>;
  @override
  $Res call(
      {String title,
      List<String> answers,
      List<int> correctAnswers,
      String documentId,
      int index});
}

class __$QuestionCopyWithImpl<$Res> extends _$QuestionCopyWithImpl<$Res>
    implements _$QuestionCopyWith<$Res> {
  __$QuestionCopyWithImpl(_Question _value, $Res Function(_Question) _then)
      : super(_value, (v) => _then(v as _Question));

  @override
  _Question get _value => super._value as _Question;

  @override
  $Res call({
    Object title = freezed,
    Object answers = freezed,
    Object correctAnswers = freezed,
    Object documentId = freezed,
    Object index = freezed,
  }) {
    return _then(_Question(
      title: title == freezed ? _value.title : title as String,
      answers: answers == freezed ? _value.answers : answers as List<String>,
      correctAnswers: correctAnswers == freezed
          ? _value.correctAnswers
          : correctAnswers as List<int>,
      documentId:
          documentId == freezed ? _value.documentId : documentId as String,
      index: index == freezed ? _value.index : index as int,
    ));
  }
}

@JsonSerializable()
class _$_Question with DiagnosticableTreeMixin implements _Question {
  _$_Question(
      {this.title,
      this.answers,
      this.correctAnswers,
      this.documentId,
      this.index});

  factory _$_Question.fromJson(Map<String, dynamic> json) =>
      _$_$_QuestionFromJson(json);

  @override
  final String title;
  @override
  final List<String> answers;
  @override
  final List<int> correctAnswers;
  @override
  final String documentId;
  @override
  final int index;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Question(title: $title, answers: $answers, correctAnswers: $correctAnswers, documentId: $documentId, index: $index)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Question'))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('answers', answers))
      ..add(DiagnosticsProperty('correctAnswers', correctAnswers))
      ..add(DiagnosticsProperty('documentId', documentId))
      ..add(DiagnosticsProperty('index', index));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Question &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.answers, answers) ||
                const DeepCollectionEquality()
                    .equals(other.answers, answers)) &&
            (identical(other.correctAnswers, correctAnswers) ||
                const DeepCollectionEquality()
                    .equals(other.correctAnswers, correctAnswers)) &&
            (identical(other.documentId, documentId) ||
                const DeepCollectionEquality()
                    .equals(other.documentId, documentId)) &&
            (identical(other.index, index) ||
                const DeepCollectionEquality().equals(other.index, index)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(answers) ^
      const DeepCollectionEquality().hash(correctAnswers) ^
      const DeepCollectionEquality().hash(documentId) ^
      const DeepCollectionEquality().hash(index);

  @override
  _$QuestionCopyWith<_Question> get copyWith =>
      __$QuestionCopyWithImpl<_Question>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_QuestionToJson(this);
  }
}

abstract class _Question implements Question {
  factory _Question(
      {String title,
      List<String> answers,
      List<int> correctAnswers,
      String documentId,
      int index}) = _$_Question;

  factory _Question.fromJson(Map<String, dynamic> json) = _$_Question.fromJson;

  @override
  String get title;
  @override
  List<String> get answers;
  @override
  List<int> get correctAnswers;
  @override
  String get documentId;
  @override
  int get index;
  @override
  _$QuestionCopyWith<_Question> get copyWith;
}
