// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'phrase.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Phrase _$PhraseFromJson(Map<String, dynamic> json) {
  return _Phrase.fromJson(json);
}

class _$PhraseTearOff {
  const _$PhraseTearOff();

  _Phrase call(
      {String original, String translated, String documentId, int index}) {
    return _Phrase(
      original: original,
      translated: translated,
      documentId: documentId,
      index: index,
    );
  }
}

// ignore: unused_element
const $Phrase = _$PhraseTearOff();

mixin _$Phrase {
  String get original;
  String get translated;
  String get documentId;
  int get index;

  Map<String, dynamic> toJson();
  $PhraseCopyWith<Phrase> get copyWith;
}

abstract class $PhraseCopyWith<$Res> {
  factory $PhraseCopyWith(Phrase value, $Res Function(Phrase) then) =
      _$PhraseCopyWithImpl<$Res>;
  $Res call({String original, String translated, String documentId, int index});
}

class _$PhraseCopyWithImpl<$Res> implements $PhraseCopyWith<$Res> {
  _$PhraseCopyWithImpl(this._value, this._then);

  final Phrase _value;
  // ignore: unused_field
  final $Res Function(Phrase) _then;

  @override
  $Res call({
    Object original = freezed,
    Object translated = freezed,
    Object documentId = freezed,
    Object index = freezed,
  }) {
    return _then(_value.copyWith(
      original: original == freezed ? _value.original : original as String,
      translated:
          translated == freezed ? _value.translated : translated as String,
      documentId:
          documentId == freezed ? _value.documentId : documentId as String,
      index: index == freezed ? _value.index : index as int,
    ));
  }
}

abstract class _$PhraseCopyWith<$Res> implements $PhraseCopyWith<$Res> {
  factory _$PhraseCopyWith(_Phrase value, $Res Function(_Phrase) then) =
      __$PhraseCopyWithImpl<$Res>;
  @override
  $Res call({String original, String translated, String documentId, int index});
}

class __$PhraseCopyWithImpl<$Res> extends _$PhraseCopyWithImpl<$Res>
    implements _$PhraseCopyWith<$Res> {
  __$PhraseCopyWithImpl(_Phrase _value, $Res Function(_Phrase) _then)
      : super(_value, (v) => _then(v as _Phrase));

  @override
  _Phrase get _value => super._value as _Phrase;

  @override
  $Res call({
    Object original = freezed,
    Object translated = freezed,
    Object documentId = freezed,
    Object index = freezed,
  }) {
    return _then(_Phrase(
      original: original == freezed ? _value.original : original as String,
      translated:
          translated == freezed ? _value.translated : translated as String,
      documentId:
          documentId == freezed ? _value.documentId : documentId as String,
      index: index == freezed ? _value.index : index as int,
    ));
  }
}

@JsonSerializable()
class _$_Phrase with DiagnosticableTreeMixin implements _Phrase {
  _$_Phrase({this.original, this.translated, this.documentId, this.index});

  factory _$_Phrase.fromJson(Map<String, dynamic> json) =>
      _$_$_PhraseFromJson(json);

  @override
  final String original;
  @override
  final String translated;
  @override
  final String documentId;
  @override
  final int index;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Phrase(original: $original, translated: $translated, documentId: $documentId, index: $index)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Phrase'))
      ..add(DiagnosticsProperty('original', original))
      ..add(DiagnosticsProperty('translated', translated))
      ..add(DiagnosticsProperty('documentId', documentId))
      ..add(DiagnosticsProperty('index', index));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Phrase &&
            (identical(other.original, original) ||
                const DeepCollectionEquality()
                    .equals(other.original, original)) &&
            (identical(other.translated, translated) ||
                const DeepCollectionEquality()
                    .equals(other.translated, translated)) &&
            (identical(other.documentId, documentId) ||
                const DeepCollectionEquality()
                    .equals(other.documentId, documentId)) &&
            (identical(other.index, index) ||
                const DeepCollectionEquality().equals(other.index, index)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(original) ^
      const DeepCollectionEquality().hash(translated) ^
      const DeepCollectionEquality().hash(documentId) ^
      const DeepCollectionEquality().hash(index);

  @override
  _$PhraseCopyWith<_Phrase> get copyWith =>
      __$PhraseCopyWithImpl<_Phrase>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_PhraseToJson(this);
  }
}

abstract class _Phrase implements Phrase {
  factory _Phrase(
      {String original,
      String translated,
      String documentId,
      int index}) = _$_Phrase;

  factory _Phrase.fromJson(Map<String, dynamic> json) = _$_Phrase.fromJson;

  @override
  String get original;
  @override
  String get translated;
  @override
  String get documentId;
  @override
  int get index;
  @override
  _$PhraseCopyWith<_Phrase> get copyWith;
}
