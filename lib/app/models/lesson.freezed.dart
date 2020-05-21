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

  _Lesson call({String title, int number, int section, String documentId}) {
    return _Lesson(
      title: title,
      number: number,
      section: section,
      documentId: documentId,
    );
  }
}

// ignore: unused_element
const $Lesson = _$LessonTearOff();

mixin _$Lesson {
  String get title;
  int get number;
  int get section;
  String get documentId;

  Map<String, dynamic> toJson();
  $LessonCopyWith<Lesson> get copyWith;
}

abstract class $LessonCopyWith<$Res> {
  factory $LessonCopyWith(Lesson value, $Res Function(Lesson) then) =
      _$LessonCopyWithImpl<$Res>;
  $Res call({String title, int number, int section, String documentId});
}

class _$LessonCopyWithImpl<$Res> implements $LessonCopyWith<$Res> {
  _$LessonCopyWithImpl(this._value, this._then);

  final Lesson _value;
  // ignore: unused_field
  final $Res Function(Lesson) _then;

  @override
  $Res call({
    Object title = freezed,
    Object number = freezed,
    Object section = freezed,
    Object documentId = freezed,
  }) {
    return _then(_value.copyWith(
      title: title == freezed ? _value.title : title as String,
      number: number == freezed ? _value.number : number as int,
      section: section == freezed ? _value.section : section as int,
      documentId:
          documentId == freezed ? _value.documentId : documentId as String,
    ));
  }
}

abstract class _$LessonCopyWith<$Res> implements $LessonCopyWith<$Res> {
  factory _$LessonCopyWith(_Lesson value, $Res Function(_Lesson) then) =
      __$LessonCopyWithImpl<$Res>;
  @override
  $Res call({String title, int number, int section, String documentId});
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
    Object number = freezed,
    Object section = freezed,
    Object documentId = freezed,
  }) {
    return _then(_Lesson(
      title: title == freezed ? _value.title : title as String,
      number: number == freezed ? _value.number : number as int,
      section: section == freezed ? _value.section : section as int,
      documentId:
          documentId == freezed ? _value.documentId : documentId as String,
    ));
  }
}

@JsonSerializable()
class _$_Lesson with DiagnosticableTreeMixin implements _Lesson {
  _$_Lesson({this.title, this.number, this.section, this.documentId});

  factory _$_Lesson.fromJson(Map<String, dynamic> json) =>
      _$_$_LessonFromJson(json);

  @override
  final String title;
  @override
  final int number;
  @override
  final int section;
  @override
  final String documentId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Lesson(title: $title, number: $number, section: $section, documentId: $documentId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Lesson'))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('number', number))
      ..add(DiagnosticsProperty('section', section))
      ..add(DiagnosticsProperty('documentId', documentId));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Lesson &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.number, number) ||
                const DeepCollectionEquality().equals(other.number, number)) &&
            (identical(other.section, section) ||
                const DeepCollectionEquality()
                    .equals(other.section, section)) &&
            (identical(other.documentId, documentId) ||
                const DeepCollectionEquality()
                    .equals(other.documentId, documentId)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(number) ^
      const DeepCollectionEquality().hash(section) ^
      const DeepCollectionEquality().hash(documentId);

  @override
  _$LessonCopyWith<_Lesson> get copyWith =>
      __$LessonCopyWithImpl<_Lesson>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_LessonToJson(this);
  }
}

abstract class _Lesson implements Lesson {
  factory _Lesson({String title, int number, int section, String documentId}) =
      _$_Lesson;

  factory _Lesson.fromJson(Map<String, dynamic> json) = _$_Lesson.fromJson;

  @override
  String get title;
  @override
  int get number;
  @override
  int get section;
  @override
  String get documentId;
  @override
  _$LessonCopyWith<_Lesson> get copyWith;
}
