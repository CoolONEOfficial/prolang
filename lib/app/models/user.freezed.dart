// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

class _$UserTearOff {
  const _$UserTearOff();

  _User call(
      {@JsonKey(ignore: true)
          String uid,
      @JsonKey(ignore: true)
          String email,
      @JsonKey(ignore: true)
          String photoUrl,
      @JsonKey(ignore: true)
          String displayName,
      @JsonKey(ignore: true)
          Lang currentLang,
      @JsonKey(ignore: true)
          bool isMailConfirmed,
      @JsonKey(nullable: true, defaultValue: false)
          bool isAdmin,
      @JsonKey(nullable: true)
          Map<String, Map<String, Map<String, double>>> progress,
      @JsonKey(nullable: true)
          Map<String, List<String>> purchases,
      @JsonKey(nullable: true)
          String currentLangId}) {
    return _User(
      uid: uid,
      email: email,
      photoUrl: photoUrl,
      displayName: displayName,
      currentLang: currentLang,
      isMailConfirmed: isMailConfirmed,
      isAdmin: isAdmin,
      progress: progress,
      purchases: purchases,
      currentLangId: currentLangId,
    );
  }
}

// ignore: unused_element
const $User = _$UserTearOff();

mixin _$User {
  @JsonKey(ignore: true)
  String get uid;
  @JsonKey(ignore: true)
  String get email;
  @JsonKey(ignore: true)
  String get photoUrl;
  @JsonKey(ignore: true)
  String get displayName;
  @JsonKey(ignore: true)
  Lang get currentLang;
  @JsonKey(ignore: true)
  bool get isMailConfirmed;
  @JsonKey(nullable: true, defaultValue: false)
  bool get isAdmin;
  @JsonKey(nullable: true)
  Map<String, Map<String, Map<String, double>>> get progress;
  @JsonKey(nullable: true)
  Map<String, List<String>> get purchases;
  @JsonKey(nullable: true)
  String get currentLangId;

  Map<String, dynamic> toJson();
  $UserCopyWith<User> get copyWith;
}

abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(ignore: true)
          String uid,
      @JsonKey(ignore: true)
          String email,
      @JsonKey(ignore: true)
          String photoUrl,
      @JsonKey(ignore: true)
          String displayName,
      @JsonKey(ignore: true)
          Lang currentLang,
      @JsonKey(ignore: true)
          bool isMailConfirmed,
      @JsonKey(nullable: true, defaultValue: false)
          bool isAdmin,
      @JsonKey(nullable: true)
          Map<String, Map<String, Map<String, double>>> progress,
      @JsonKey(nullable: true)
          Map<String, List<String>> purchases,
      @JsonKey(nullable: true)
          String currentLangId});

  $LangCopyWith<$Res> get currentLang;
}

class _$UserCopyWithImpl<$Res> implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  final User _value;
  // ignore: unused_field
  final $Res Function(User) _then;

  @override
  $Res call({
    Object uid = freezed,
    Object email = freezed,
    Object photoUrl = freezed,
    Object displayName = freezed,
    Object currentLang = freezed,
    Object isMailConfirmed = freezed,
    Object isAdmin = freezed,
    Object progress = freezed,
    Object purchases = freezed,
    Object currentLangId = freezed,
  }) {
    return _then(_value.copyWith(
      uid: uid == freezed ? _value.uid : uid as String,
      email: email == freezed ? _value.email : email as String,
      photoUrl: photoUrl == freezed ? _value.photoUrl : photoUrl as String,
      displayName:
          displayName == freezed ? _value.displayName : displayName as String,
      currentLang:
          currentLang == freezed ? _value.currentLang : currentLang as Lang,
      isMailConfirmed: isMailConfirmed == freezed
          ? _value.isMailConfirmed
          : isMailConfirmed as bool,
      isAdmin: isAdmin == freezed ? _value.isAdmin : isAdmin as bool,
      progress: progress == freezed
          ? _value.progress
          : progress as Map<String, Map<String, Map<String, double>>>,
      purchases: purchases == freezed
          ? _value.purchases
          : purchases as Map<String, List<String>>,
      currentLangId: currentLangId == freezed
          ? _value.currentLangId
          : currentLangId as String,
    ));
  }

  @override
  $LangCopyWith<$Res> get currentLang {
    if (_value.currentLang == null) {
      return null;
    }
    return $LangCopyWith<$Res>(_value.currentLang, (value) {
      return _then(_value.copyWith(currentLang: value));
    });
  }
}

abstract class _$UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$UserCopyWith(_User value, $Res Function(_User) then) =
      __$UserCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(ignore: true)
          String uid,
      @JsonKey(ignore: true)
          String email,
      @JsonKey(ignore: true)
          String photoUrl,
      @JsonKey(ignore: true)
          String displayName,
      @JsonKey(ignore: true)
          Lang currentLang,
      @JsonKey(ignore: true)
          bool isMailConfirmed,
      @JsonKey(nullable: true, defaultValue: false)
          bool isAdmin,
      @JsonKey(nullable: true)
          Map<String, Map<String, Map<String, double>>> progress,
      @JsonKey(nullable: true)
          Map<String, List<String>> purchases,
      @JsonKey(nullable: true)
          String currentLangId});

  @override
  $LangCopyWith<$Res> get currentLang;
}

class __$UserCopyWithImpl<$Res> extends _$UserCopyWithImpl<$Res>
    implements _$UserCopyWith<$Res> {
  __$UserCopyWithImpl(_User _value, $Res Function(_User) _then)
      : super(_value, (v) => _then(v as _User));

  @override
  _User get _value => super._value as _User;

  @override
  $Res call({
    Object uid = freezed,
    Object email = freezed,
    Object photoUrl = freezed,
    Object displayName = freezed,
    Object currentLang = freezed,
    Object isMailConfirmed = freezed,
    Object isAdmin = freezed,
    Object progress = freezed,
    Object purchases = freezed,
    Object currentLangId = freezed,
  }) {
    return _then(_User(
      uid: uid == freezed ? _value.uid : uid as String,
      email: email == freezed ? _value.email : email as String,
      photoUrl: photoUrl == freezed ? _value.photoUrl : photoUrl as String,
      displayName:
          displayName == freezed ? _value.displayName : displayName as String,
      currentLang:
          currentLang == freezed ? _value.currentLang : currentLang as Lang,
      isMailConfirmed: isMailConfirmed == freezed
          ? _value.isMailConfirmed
          : isMailConfirmed as bool,
      isAdmin: isAdmin == freezed ? _value.isAdmin : isAdmin as bool,
      progress: progress == freezed
          ? _value.progress
          : progress as Map<String, Map<String, Map<String, double>>>,
      purchases: purchases == freezed
          ? _value.purchases
          : purchases as Map<String, List<String>>,
      currentLangId: currentLangId == freezed
          ? _value.currentLangId
          : currentLangId as String,
    ));
  }
}

@JsonSerializable()
class _$_User extends _User {
  _$_User(
      {@JsonKey(ignore: true) this.uid,
      @JsonKey(ignore: true) this.email,
      @JsonKey(ignore: true) this.photoUrl,
      @JsonKey(ignore: true) this.displayName,
      @JsonKey(ignore: true) this.currentLang,
      @JsonKey(ignore: true) this.isMailConfirmed,
      @JsonKey(nullable: true, defaultValue: false) this.isAdmin,
      @JsonKey(nullable: true) this.progress,
      @JsonKey(nullable: true) this.purchases,
      @JsonKey(nullable: true) this.currentLangId})
      : super._();

  factory _$_User.fromJson(Map<String, dynamic> json) =>
      _$_$_UserFromJson(json);

  @override
  @JsonKey(ignore: true)
  final String uid;
  @override
  @JsonKey(ignore: true)
  final String email;
  @override
  @JsonKey(ignore: true)
  final String photoUrl;
  @override
  @JsonKey(ignore: true)
  final String displayName;
  @override
  @JsonKey(ignore: true)
  final Lang currentLang;
  @override
  @JsonKey(ignore: true)
  final bool isMailConfirmed;
  @override
  @JsonKey(nullable: true, defaultValue: false)
  final bool isAdmin;
  @override
  @JsonKey(nullable: true)
  final Map<String, Map<String, Map<String, double>>> progress;
  @override
  @JsonKey(nullable: true)
  final Map<String, List<String>> purchases;
  @override
  @JsonKey(nullable: true)
  final String currentLangId;

  @override
  String toString() {
    return 'User(uid: $uid, email: $email, photoUrl: $photoUrl, displayName: $displayName, currentLang: $currentLang, isMailConfirmed: $isMailConfirmed, isAdmin: $isAdmin, progress: $progress, purchases: $purchases, currentLangId: $currentLangId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _User &&
            (identical(other.uid, uid) ||
                const DeepCollectionEquality().equals(other.uid, uid)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.photoUrl, photoUrl) ||
                const DeepCollectionEquality()
                    .equals(other.photoUrl, photoUrl)) &&
            (identical(other.displayName, displayName) ||
                const DeepCollectionEquality()
                    .equals(other.displayName, displayName)) &&
            (identical(other.currentLang, currentLang) ||
                const DeepCollectionEquality()
                    .equals(other.currentLang, currentLang)) &&
            (identical(other.isMailConfirmed, isMailConfirmed) ||
                const DeepCollectionEquality()
                    .equals(other.isMailConfirmed, isMailConfirmed)) &&
            (identical(other.isAdmin, isAdmin) ||
                const DeepCollectionEquality()
                    .equals(other.isAdmin, isAdmin)) &&
            (identical(other.progress, progress) ||
                const DeepCollectionEquality()
                    .equals(other.progress, progress)) &&
            (identical(other.purchases, purchases) ||
                const DeepCollectionEquality()
                    .equals(other.purchases, purchases)) &&
            (identical(other.currentLangId, currentLangId) ||
                const DeepCollectionEquality()
                    .equals(other.currentLangId, currentLangId)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(uid) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(photoUrl) ^
      const DeepCollectionEquality().hash(displayName) ^
      const DeepCollectionEquality().hash(currentLang) ^
      const DeepCollectionEquality().hash(isMailConfirmed) ^
      const DeepCollectionEquality().hash(isAdmin) ^
      const DeepCollectionEquality().hash(progress) ^
      const DeepCollectionEquality().hash(purchases) ^
      const DeepCollectionEquality().hash(currentLangId);

  @override
  _$UserCopyWith<_User> get copyWith =>
      __$UserCopyWithImpl<_User>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_UserToJson(this);
  }
}

abstract class _User extends User {
  _User._() : super._();
  factory _User(
      {@JsonKey(ignore: true)
          String uid,
      @JsonKey(ignore: true)
          String email,
      @JsonKey(ignore: true)
          String photoUrl,
      @JsonKey(ignore: true)
          String displayName,
      @JsonKey(ignore: true)
          Lang currentLang,
      @JsonKey(ignore: true)
          bool isMailConfirmed,
      @JsonKey(nullable: true, defaultValue: false)
          bool isAdmin,
      @JsonKey(nullable: true)
          Map<String, Map<String, Map<String, double>>> progress,
      @JsonKey(nullable: true)
          Map<String, List<String>> purchases,
      @JsonKey(nullable: true)
          String currentLangId}) = _$_User;

  factory _User.fromJson(Map<String, dynamic> json) = _$_User.fromJson;

  @override
  @JsonKey(ignore: true)
  String get uid;
  @override
  @JsonKey(ignore: true)
  String get email;
  @override
  @JsonKey(ignore: true)
  String get photoUrl;
  @override
  @JsonKey(ignore: true)
  String get displayName;
  @override
  @JsonKey(ignore: true)
  Lang get currentLang;
  @override
  @JsonKey(ignore: true)
  bool get isMailConfirmed;
  @override
  @JsonKey(nullable: true, defaultValue: false)
  bool get isAdmin;
  @override
  @JsonKey(nullable: true)
  Map<String, Map<String, Map<String, double>>> get progress;
  @override
  @JsonKey(nullable: true)
  Map<String, List<String>> get purchases;
  @override
  @JsonKey(nullable: true)
  String get currentLangId;
  @override
  _$UserCopyWith<_User> get copyWith;
}
