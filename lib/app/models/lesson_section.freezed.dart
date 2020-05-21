// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'lesson_section.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
LessonSection _$LessonSectionFromJson(Map<String, dynamic> json) {
  return _LessonSection.fromJson(json);
}

class _$LessonSectionTearOff {
  const _$LessonSectionTearOff();

  _LessonSection call({String title, String description}) {
    return _LessonSection(
      title: title,
      description: description,
    );
  }
}

// ignore: unused_element
const $LessonSection = _$LessonSectionTearOff();

mixin _$LessonSection {
  String get title;
  String get description;

  Map<String, dynamic> toJson();
  $LessonSectionCopyWith<LessonSection> get copyWith;
}

abstract class $LessonSectionCopyWith<$Res> {
  factory $LessonSectionCopyWith(
          LessonSection value, $Res Function(LessonSection) then) =
      _$LessonSectionCopyWithImpl<$Res>;
  $Res call({String title, String description});
}

class _$LessonSectionCopyWithImpl<$Res>
    implements $LessonSectionCopyWith<$Res> {
  _$LessonSectionCopyWithImpl(this._value, this._then);

  final LessonSection _value;
  // ignore: unused_field
  final $Res Function(LessonSection) _then;

  @override
  $Res call({
    Object title = freezed,
    Object description = freezed,
  }) {
    return _then(_value.copyWith(
      title: title == freezed ? _value.title : title as String,
      description:
          description == freezed ? _value.description : description as String,
    ));
  }
}

abstract class _$LessonSectionCopyWith<$Res>
    implements $LessonSectionCopyWith<$Res> {
  factory _$LessonSectionCopyWith(
          _LessonSection value, $Res Function(_LessonSection) then) =
      __$LessonSectionCopyWithImpl<$Res>;
  @override
  $Res call({String title, String description});
}

class __$LessonSectionCopyWithImpl<$Res>
    extends _$LessonSectionCopyWithImpl<$Res>
    implements _$LessonSectionCopyWith<$Res> {
  __$LessonSectionCopyWithImpl(
      _LessonSection _value, $Res Function(_LessonSection) _then)
      : super(_value, (v) => _then(v as _LessonSection));

  @override
  _LessonSection get _value => super._value as _LessonSection;

  @override
  $Res call({
    Object title = freezed,
    Object description = freezed,
  }) {
    return _then(_LessonSection(
      title: title == freezed ? _value.title : title as String,
      description:
          description == freezed ? _value.description : description as String,
    ));
  }
}

@JsonSerializable()
class _$_LessonSection with DiagnosticableTreeMixin implements _LessonSection {
  _$_LessonSection({this.title, this.description});

  factory _$_LessonSection.fromJson(Map<String, dynamic> json) =>
      _$_$_LessonSectionFromJson(json);

  @override
  final String title;
  @override
  final String description;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'LessonSection(title: $title, description: $description)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'LessonSection'))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('description', description));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _LessonSection &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(description);

  @override
  _$LessonSectionCopyWith<_LessonSection> get copyWith =>
      __$LessonSectionCopyWithImpl<_LessonSection>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_LessonSectionToJson(this);
  }
}

abstract class _LessonSection implements LessonSection {
  factory _LessonSection({String title, String description}) = _$_LessonSection;

  factory _LessonSection.fromJson(Map<String, dynamic> json) =
      _$_LessonSection.fromJson;

  @override
  String get title;
  @override
  String get description;
  @override
  _$LessonSectionCopyWith<_LessonSection> get copyWith;
}
