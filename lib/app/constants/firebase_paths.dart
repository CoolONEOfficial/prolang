import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prolang/app/models/lang.dart';
import 'package:prolang/app/models/lesson.dart';
import 'package:prolang/app/models/lesson_section.dart';
import 'package:prolang/app/models/phrase.dart';
import 'package:prolang/app/models/question.dart';
import 'package:prolang/app/models/user.dart';
import 'package:prolang/app/services/firebase_auth_service.dart';

class FirebasePaths {
  // Paths

  static String langPath(
    Lang lang,
  ) =>
      langRef(
        lang,
      ).path;

  static String lessonSectionPath(
    Lang lang,
    LessonSection section,
  ) =>
      lessonSectionRef(
        lang,
        section,
      ).path;

  static String lessonPath(
    Lang lang,
    LessonSection section,
    Lesson lesson,
  ) =>
      lessonRef(
        lang,
        section,
        lesson,
      ).path;

  static String phrasePath(
          Lang lang, LessonSection section, Lesson lesson, Phrase phrase) =>
      phraseRef(lang, section, lesson, phrase).path;

  // Refs

  static DocumentReference currentUserRef() =>
      userRefFromUser(FirebaseAuthService.cachedCurrentUser);

  static DocumentReference userRefFromUser(
    User user,
  ) =>
      userRefFromId(user.uid);

  static DocumentReference userRefFromId(
    String userId,
  ) =>
      Firestore.instance.collection('users').document(userId);

  static DocumentReference langRef(
    Lang lang,
  ) =>
      langRefById(lang.documentId);

  static DocumentReference langRefById(
    String langId,
  ) =>
      Firestore.instance.collection('langs').document(langId);

  static DocumentReference lessonSectionRef(
    Lang lang,
    LessonSection section,
  ) =>
      langRef(lang).collection('sections').document(section.documentId);

  static DocumentReference lessonRef(
    Lang lang,
    LessonSection section,
    Lesson lesson,
  ) =>
      lessonSectionRef(lang, section)
          .collection('lessons')
          .document(lesson.documentId);

  static DocumentReference phraseRef(
    Lang lang,
    LessonSection section,
    Lesson lesson,
    Phrase phrase,
  ) =>
      lessonRef(lang, section, lesson)
          .collection('phrases')
          .document(phrase.documentId);

  static DocumentReference questionRef(
    Lang lang,
    LessonSection section,
    Lesson lesson,
    Question question,
  ) =>
      lessonRef(lang, section, lesson)
          .collection('questions')
          .document(question.documentId);
}
