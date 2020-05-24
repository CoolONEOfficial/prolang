// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'lesson.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Lesson _$LessonFromJson(Map<String, dynamic> json) {
  return _Lesson.fromJson(json);
}

class _$LessonTearOff {
  const _$LessonTearOff();

  _Lesson call(
      {String title,
      String description,
      String documentId,
      int videoBytes,
      int grammarBytes,
      int index}) {
    return _Lesson(
      title: title,
      description: description,
      documentId: documentId,
      videoBytes: videoBytes,
      grammarBytes: grammarBytes,
      index: index,
    );
  }
}

// ignore: unused_element
const $Lesson = _$LessonTearOff();

mixin _$Lesson {
  String get title;
  String get description;
  String get documentId;
  int get videoBytes;
  int get grammarBytes;
  int get index;

  Map<String, dynamic> toJson();
  $LessonCopyWith<Lesson> get copyWith;
}

abstract class $LessonCopyWith<$Res> {
  factory $LessonCopyWith(Lesson value, $Res Function(Lesson) then) =
      _$LessonCopyWithImpl<$Res>;
  $Res call(
      {String title,
      String description,
      String documentId,
      int videoBytes,
      int grammarBytes,
      int index});
}

class _$LessonCopyWithImpl<$Res> implements $LessonCopyWith<$Res> {
  _$LessonCopyWithImpl(this._value, this._then);

  final Lesson _value;
  // ignore: unused_field
  final $Res Function(Lesson) _then;

  @override
  $Res call({
    Object title = freezed,
    Object description = freezed,
    Object documentId = freezed,
    Object videoBytes = freezed,
    Object grammarBytes = freezed,
    Object index = freezed,
  }) {
    return _then(_value.copyWith(
      title: title == freezed ? _value.title : title as String,
      description:
          description == freezed ? _value.description : description as String,
      documentId:
          documentId == freezed ? _value.documentId : documentId as String,
      videoBytes: videoBytes == freezed ? _value.videoBytes : videoBytes as int,
      grammarBytes:
          grammarBytes == freezed ? _value.grammarBytes : grammarBytes as int,
      index: index == freezed ? _value.index : index as int,
    ));
  }
}

abstract class _$LessonCopyWith<$Res> implements $LessonCopyWith<$Res> {
  factory _$LessonCopyWith(_Lesson value, $Res Function(_Lesson) then) =
      __$LessonCopyWithImpl<$Res>;
  @override
  $Res call(
      {String title,
      String description,
      String documentId,
      int videoBytes,
      int grammarBytes,
      int index});
}

class __$LessonCopyWithImpl<$Res> extends _$LessonCopyWithImpl<$Res>
    implements _$LessonCopyWith<$Res> {
  __$LessonCopyWithImpl(_Lesson _value, $Res Function(_Lesson) _then)
      : super(_value, (v) => _then(v as _Lesson));

  @override
  _Lesson get _value => super._value as _Lesson;

  @override
  $Res call({
    Object title = freezed,
    Object description = freezed,
    Object documentId = freezed,
    Object videoBytes = freezed,
    Object grammarBytes = freezed,
    Object index = freezed,
  }) {
    return _then(_Lesson(
      title: title == freezed ? _value.title : title as String,
      description:
          description == freezed ? _value.description : description as String,
      documentId:
          documentId == freezed ? _value.documentId : documentId as String,
      videoBytes: videoBytes == freezed ? _value.videoBytes : videoBytes as int,
      grammarBytes:
          grammarBytes == freezed ? _value.grammarBytes : grammarBytes as int,
      index: index == freezed ? _value.index : index as int,
    ));
  }
}

@JsonSerializable()
class _$_Lesson with DiagnosticableTreeMixin implements _Lesson {
  _$_Lesson(
      {this.title,
      this.description,
      this.documentId,
      this.videoBytes,
      this.grammarBytes,
      this.index});

  factory _$_Lesson.fromJson(Map<String, dynamic> json) =>
      _$_$_LessonFromJson(json);

  @override
  final String title;
  @override
  final String description;
  @override
  final String documentId;
  @override
  final int videoBytes;
  @override
  final int grammarBytes;
  @override
  final int index;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Lesson(title: $title, description: $description, documentId: $documentId, videoBytes: $videoBytes, grammarBytes: $grammarBytes, index: $index)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Lesson'))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('documentId', documentId))
      ..add(DiagnosticsProperty('videoBytes', videoBytes))
      ..add(DiagnosticsProperty('grammarBytes', grammarBytes))
      ..add(DiagnosticsProperty('index', index));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Lesson &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.documentId, documentId) ||
                const DeepCollectionEquality()
                    .equals(other.documentId, documentId)) &&
            (identical(other.videoBytes, videoBytes) ||
                const DeepCollectionEquality()
                    .equals(other.videoBytes, videoBytes)) &&
            (identical(other.grammarBytes, grammarBytes) ||
                const DeepCollectionEquality()
                    .equals(other.grammarBytes, grammarBytes)) &&
            (identical(other.index, index) ||
                const DeepCollectionEquality().equals(other.index, index)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(documentId) ^
      const DeepCollectionEquality().hash(videoBytes) ^
      const DeepCollectionEquality().hash(grammarBytes) ^
      const DeepCollectionEquality().hash(index);

  @override
  _$LessonCopyWith<_Lesson> get copyWith =>
      __$LessonCopyWithImpl<_Lesson>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_LessonToJson(this);
  }
}

abstract class _Lesson implements Lesson {
  factory _Lesson(
      {String title,
      String description,
      String documentId,
      int videoBytes,
      int grammarBytes,
      int index}) = _$_Lesson;

  factory _Lesson.fromJson(Map<String, dynamic> json) = _$_Lesson.fromJson;

  @override
  String get title;
  @override
  String get description;
  @override
  String get documentId;
  @override
  int get videoBytes;
  @override
  int get grammarBytes;
  @override
  int get index;
  @override
  _$LessonCopyWith<_Lesson> get copyWith;
}
