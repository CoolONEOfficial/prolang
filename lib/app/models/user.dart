import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
abstract class User with _$User {
  factory User({
    @JsonKey(ignore: true) final String uid,
    @JsonKey(ignore: true) final String email,
    @JsonKey(ignore: true) final String photoUrl,
    @JsonKey(ignore: true) final String displayName,
    @JsonKey(nullable: true)
        final Map<String, Map<String, Map<String, double>>> progress,
  }) = _User;

  factory User.fromSnapshotAndUser(
      DocumentSnapshot snapshot, FirebaseUser user) {
    return User.fromJson(snapshot.data ?? Map()).copyWith(
      uid: user.uid,
      email: user.email,
      photoUrl: user.photoUrl,
      displayName: user.displayName,
    );
  }
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
