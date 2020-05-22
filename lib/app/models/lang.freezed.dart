// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'lang.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Lang _$LangFromJson(Map<String, dynamic> json) {
  return _Lang.fromJson(json);
}

class _$LangTearOff {
  const _$LangTearOff();

  _Lang call(
      {@JsonKey(fromJson: parseJsonMap) Map<String, String> title,
      String flag,
      String color,
      String documentId,
      String teacher}) {
    return _Lang(
      title: title,
      flag: flag,
      color: color,
      documentId: documentId,
      teacher: teacher,
    );
  }
}

// ignore: unused_element
const $Lang = _$LangTearOff();

mixin _$Lang {
  @JsonKey(fromJson: parseJsonMap)
  Map<String, String> get title;
  String get flag;
  String get color;
  String get documentId;
  String get teacher;

  Map<String, dynamic> toJson();
  $LangCopyWith<Lang> get copyWith;
}

abstract class $LangCopyWith<$Res> {
  factory $LangCopyWith(Lang value, $Res Function(Lang) then) =
      _$LangCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(fromJson: parseJsonMap) Map<String, String> title,
      String flag,
      String color,
      String documentId,
      String teacher});
}

class _$LangCopyWithImpl<$Res> implements $LangCopyWith<$Res> {
  _$LangCopyWithImpl(this._value, this._then);

  final Lang _value;
  // ignore: unused_field
  final $Res Function(Lang) _then;

  @override
  $Res call({
    Object title = freezed,
    Object flag = freezed,
    Object color = freezed,
    Object documentId = freezed,
    Object teacher = freezed,
  }) {
    return _then(_value.copyWith(
      title: title == freezed ? _value.title : title as Map<String, String>,
      flag: flag == freezed ? _value.flag : flag as String,
      color: color == freezed ? _value.color : color as String,
      documentId:
          documentId == freezed ? _value.documentId : documentId as String,
      teacher: teacher == freezed ? _value.teacher : teacher as String,
    ));
  }
}

abstract class _$LangCopyWith<$Res> implements $LangCopyWith<$Res> {
  factory _$LangCopyWith(_Lang value, $Res Function(_Lang) then) =
      __$LangCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(fromJson: parseJsonMap) Map<String, String> title,
      String flag,
      String color,
      String documentId,
      String teacher});
}

class __$LangCopyWithImpl<$Res> extends _$LangCopyWithImpl<$Res>
    implements _$LangCopyWith<$Res> {
  __$LangCopyWithImpl(_Lang _value, $Res Function(_Lang) _then)
      : super(_value, (v) => _then(v as _Lang));

  @override
  _Lang get _value => super._value as _Lang;

  @override
  $Res call({
    Object title = freezed,
    Object flag = freezed,
    Object color = freezed,
    Object documentId = freezed,
    Object teacher = freezed,
  }) {
    return _then(_Lang(
      title: title == freezed ? _value.title : title as Map<String, String>,
      flag: flag == freezed ? _value.flag : flag as String,
      color: color == freezed ? _value.color : color as String,
      documentId:
          documentId == freezed ? _value.documentId : documentId as String,
      teacher: teacher == freezed ? _value.teacher : teacher as String,
    ));
  }
}

@JsonSerializable()
class _$_Lang with DiagnosticableTreeMixin implements _Lang {
  _$_Lang(
      {@JsonKey(fromJson: parseJsonMap) this.title,
      this.flag,
      this.color,
      this.documentId,
      this.teacher});

  factory _$_Lang.fromJson(Map<String, dynamic> json) =>
      _$_$_LangFromJson(json);

  @override
  @JsonKey(fromJson: parseJsonMap)
  final Map<String, String> title;
  @override
  final String flag;
  @override
  final String color;
  @override
  final String documentId;
  @override
  final String teacher;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Lang(title: $title, flag: $flag, color: $color, documentId: $documentId, teacher: $teacher)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Lang'))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('flag', flag))
      ..add(DiagnosticsProperty('color', color))
      ..add(DiagnosticsProperty('documentId', documentId))
      ..add(DiagnosticsProperty('teacher', teacher));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Lang &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.flag, flag) ||
                const DeepCollectionEquality().equals(other.flag, flag)) &&
            (identical(other.color, color) ||
                const DeepCollectionEquality().equals(other.color, color)) &&
            (identical(other.documentId, documentId) ||
                const DeepCollectionEquality()
                    .equals(other.documentId, documentId)) &&
            (identical(other.teacher, teacher) ||
                const DeepCollectionEquality().equals(other.teacher, teacher)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(flag) ^
      const DeepCollectionEquality().hash(color) ^
      const DeepCollectionEquality().hash(documentId) ^
      const DeepCollectionEquality().hash(teacher);

  @override
  _$LangCopyWith<_Lang> get copyWith =>
      __$LangCopyWithImpl<_Lang>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_LangToJson(this);
  }
}

abstract class _Lang implements Lang {
  factory _Lang(
      {@JsonKey(fromJson: parseJsonMap) Map<String, String> title,
      String flag,
      String color,
      String documentId,
      String teacher}) = _$_Lang;

  factory _Lang.fromJson(Map<String, dynamic> json) = _$_Lang.fromJson;

  @override
  @JsonKey(fromJson: parseJsonMap)
  Map<String, String> get title;
  @override
  String get flag;
  @override
  String get color;
  @override
  String get documentId;
  @override
  String get teacher;
  @override
  _$LangCopyWith<_Lang> get copyWith;
}
