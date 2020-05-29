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

  _LessonSection call(
      {String title,
      String description,
      String documentId,
      int price,
      int index}) {
    return _LessonSection(
      title: title,
      description: description,
      documentId: documentId,
      price: price,
      index: index,
    );
  }
}

// ignore: unused_element
const $LessonSection = _$LessonSectionTearOff();

mixin _$LessonSection {
  String get title;
  String get description;
  String get documentId;
  int get price;
  int get index;

  Map<String, dynamic> toJson();
  $LessonSectionCopyWith<LessonSection> get copyWith;
}

abstract class $LessonSectionCopyWith<$Res> {
  factory $LessonSectionCopyWith(
          LessonSection value, $Res Function(LessonSection) then) =
      _$LessonSectionCopyWithImpl<$Res>;
  $Res call(
      {String title,
      String description,
      String documentId,
      int price,
      int index});
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
    Object documentId = freezed,
    Object price = freezed,
    Object index = freezed,
  }) {
    return _then(_value.copyWith(
      title: title == freezed ? _value.title : title as String,
      description:
          description == freezed ? _value.description : description as String,
      documentId:
          documentId == freezed ? _value.documentId : documentId as String,
      price: price == freezed ? _value.price : price as int,
      index: index == freezed ? _value.index : index as int,
    ));
  }
}

abstract class _$LessonSectionCopyWith<$Res>
    implements $LessonSectionCopyWith<$Res> {
  factory _$LessonSectionCopyWith(
          _LessonSection value, $Res Function(_LessonSection) then) =
      __$LessonSectionCopyWithImpl<$Res>;
  @override
  $Res call(
      {String title,
      String description,
      String documentId,
      int price,
      int index});
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
    Object documentId = freezed,
    Object price = freezed,
    Object index = freezed,
  }) {
    return _then(_LessonSection(
      title: title == freezed ? _value.title : title as String,
      description:
          description == freezed ? _value.description : description as String,
      documentId:
          documentId == freezed ? _value.documentId : documentId as String,
      price: price == freezed ? _value.price : price as int,
      index: index == freezed ? _value.index : index as int,
    ));
  }
}

@JsonSerializable()
class _$_LessonSection with DiagnosticableTreeMixin implements _LessonSection {
  _$_LessonSection(
      {this.title, this.description, this.documentId, this.price, this.index});

  factory _$_LessonSection.fromJson(Map<String, dynamic> json) =>
      _$_$_LessonSectionFromJson(json);

  @override
  final String title;
  @override
  final String description;
  @override
  final String documentId;
  @override
  final int price;
  @override
  final int index;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'LessonSection(title: $title, description: $description, documentId: $documentId, price: $price, index: $index)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'LessonSection'))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('documentId', documentId))
      ..add(DiagnosticsProperty('price', price))
      ..add(DiagnosticsProperty('index', index));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _LessonSection &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.documentId, documentId) ||
                const DeepCollectionEquality()
                    .equals(other.documentId, documentId)) &&
            (identical(other.price, price) ||
                const DeepCollectionEquality().equals(other.price, price)) &&
            (identical(other.index, index) ||
                const DeepCollectionEquality().equals(other.index, index)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(documentId) ^
      const DeepCollectionEquality().hash(price) ^
      const DeepCollectionEquality().hash(index);

  @override
  _$LessonSectionCopyWith<_LessonSection> get copyWith =>
      __$LessonSectionCopyWithImpl<_LessonSection>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_LessonSectionToJson(this);
  }
}

abstract class _LessonSection implements LessonSection {
  factory _LessonSection(
      {String title,
      String description,
      String documentId,
      int price,
      int index}) = _$_LessonSection;

  factory _LessonSection.fromJson(Map<String, dynamic> json) =
      _$_LessonSection.fromJson;

  @override
  String get title;
  @override
  String get description;
  @override
  String get documentId;
  @override
  int get price;
  @override
  int get index;
  @override
  _$LessonSectionCopyWith<_LessonSection> get copyWith;
}
