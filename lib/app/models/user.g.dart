// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$_$_UserFromJson(Map<String, dynamic> json) {
  return _$_User(
    isAdmin: json['isAdmin'] as bool ?? false,
    progress: (json['progress'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(
          k,
          (e as Map<String, dynamic>)?.map(
            (k, e) => MapEntry(
                k,
                (e as Map<String, dynamic>)?.map(
                  (k, e) => MapEntry(k, (e as num)?.toDouble()),
                )),
          )),
    ),
    purchases: (json['purchases'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, (e as List)?.map((e) => e as String)?.toList()),
    ),
  );
}

Map<String, dynamic> _$_$_UserToJson(_$_User instance) => <String, dynamic>{
      'isAdmin': instance.isAdmin,
      'progress': instance.progress,
      'purchases': instance.purchases,
    };
