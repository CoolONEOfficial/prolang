import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prolang/app/models/lesson.dart';
import 'package:prolang/app/models/lesson_section.dart';
import 'package:prolang/app/extensions/map_get.dart';

import 'lang.dart';

part 'user.freezed.dart';
part 'user.g.dart';

enum UserState { Loading, Done }

@freezed
abstract class User implements _$User {
  const User._();
  factory User({
    @JsonKey(ignore: true) final String uid,
    @JsonKey(ignore: true) final String email,
    @JsonKey(ignore: true) final String photoUrl,
    @JsonKey(ignore: true) final String displayName,
    @JsonKey(nullable: true, defaultValue: false) final bool isAdmin,
    @JsonKey(nullable: true)
        final Map<String, Map<String, Map<String, double>>> progress,
    @JsonKey(nullable: true) final Map<String, List<String>> purchases,
  }) = _User;

  bool sectionPurchased(Lang lang, LessonSection section) =>
      purchases?.get(lang.documentId)?.contains(section.documentId) ?? false;

  bool lessonCompleted(Lang lang, LessonSection section, Lesson lesson) =>
      lessonResult(lang, section, lesson) > 2 / 3;

  double lessonResult(Lang lang, LessonSection section, Lesson lesson) =>
      progress
          ?.get(lang.documentId)
          ?.get(section.documentId)
          ?.get(lesson.documentId) ??
      0;

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
