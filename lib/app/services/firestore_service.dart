import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prolang/app/constants/firebase_paths.dart';
import 'package:prolang/app/mixins/index_mixin.dart';
import 'package:prolang/app/models/lang.dart';
import 'package:prolang/app/models/lesson.dart';
import 'package:prolang/app/models/lesson_section.dart';
import 'package:prolang/app/models/phrase.dart';
import 'package:prolang/app/models/question.dart';

class FirestoreService {
  final Firestore _firestore;

  FirestoreService({Firestore firestore})
      : _firestore = firestore ?? Firestore.instance;

  // Load

  Future<List<Lang>> loadLangList() async {
    var langListSnapshot = await _firestore.collection('langs').getDocuments();
    return langListSnapshot.documents
        .map((langSnapshot) => Lang.fromSnapshot(langSnapshot))
        .toList();
  }

  Future<List<LessonSection>> loadSectionList(
    Lang lang,
  ) async {
    var snapshot = await FirebasePaths.langRef(lang)
        .collection('sections')
        .orderBy('index')
        .getDocuments();

    return snapshot.documents
        .map((langSnapshot) => LessonSection.fromSnapshot(langSnapshot))
        .toList();
  }

  Future<List<Lesson>> loadLessonList(
    Lang lang,
    LessonSection section,
  ) async {
    var snapshot = await FirebasePaths.lessonSectionRef(lang, section)
        .collection('lessons')
        .orderBy('index')
        .getDocuments();

    return snapshot.documents
        .map((langSnapshot) => Lesson.fromSnapshot(langSnapshot))
        .toList();
  }

  Future<List<Question>> loadQuestionList(
      Lang lang, LessonSection section, Lesson lesson) async {
    var snapshot = await FirebasePaths.lessonRef(lang, section, lesson)
        .collection('questions')
        .orderBy('index')
        .getDocuments();

    return snapshot.documents
        .map((langSnapshot) => Question.fromSnapshot(langSnapshot))
        .toList();
  }

  // Delete

  deleteLessonSection([
    Lang lang,
    LessonSection section,
  ]) async {
    await _deleteDocWithIndex(
      FirebasePaths.langRef(
        lang,
      ).collection('sections'),
      section,
    );
  }

  deleteLesson([
    Lang lang,
    LessonSection section,
    Lesson lesson,
  ]) async {
    await _deleteDocWithIndex(
      FirebasePaths.lessonSectionRef(
        lang,
        section,
      ).collection('lessons'),
      lesson,
    );
  }

  deleteLessonPhrase([
    Lang lang,
    LessonSection section,
    Lesson lesson,
    Phrase phrase,
  ]) async {
    await _deleteDocWithIndex(
      FirebasePaths.lessonRef(
        lang,
        section,
        lesson,
      ).collection('phrases'),
      phrase,
    );
  }

  deleteLessonQuestion([
    Lang lang,
    LessonSection section,
    Lesson lesson,
    Question question,
  ]) async {
    await _deleteDocWithIndex(
      FirebasePaths.lessonRef(
        lang,
        section,
        lesson,
      ).collection('questions'),
      question,
    );
  }

  // Insert

  insertLessonSection([
    Lang lang,
    LessonSection section,
    int index,
  ]) async {
    section = section.copyWith(
      index: index,
    );
    await _insertDocWithIndex(
      FirebasePaths.langRef(
        lang,
      ).collection('sections'),
      section,
    );
  }

  Future<String> insertLesson([
    Lang lang,
    LessonSection section,
    Lesson lesson,
    int index,
  ]) async {
    lesson = lesson.copyWith(
      index: index,
    );
    return _insertDocWithIndex(
      FirebasePaths.lessonSectionRef(
        lang,
        section,
      ).collection('lessons'),
      lesson,
    );
  }

  Future<String> insertLessonPhrase([
    Lang lang,
    LessonSection section,
    Lesson lesson,
    Phrase phrase,
    int index,
  ]) async {
    phrase = phrase.copyWith(
      index: index,
    );
    return _insertDocWithIndex(
      FirebasePaths.lessonRef(
        lang,
        section,
        lesson,
      ).collection('phrases'),
      phrase,
    );
  }

  Future<String> insertLessonQuestion([
    Lang lang,
    LessonSection section,
    Lesson lesson,
    Question question,
    int index,
  ]) async {
    question = question.copyWith(
      index: index,
    );
    return _insertDocWithIndex(
      FirebasePaths.lessonRef(
        lang,
        section,
        lesson,
      ).collection('questions'),
      question,
    );
  }

  // Update

  updateLesson(
    Lang lang,
    LessonSection section,
    Lesson lesson,
  ) {
    FirebasePaths.lessonRef(lang, section, lesson).updateData(lesson.toJson());
  }

  updateLessonSection(
    Lang lang,
    LessonSection section,
  ) {
    FirebasePaths.lessonSectionRef(lang, section).updateData(section.toJson());
  }

  updateLessonPhrase(
    Lang lang,
    LessonSection section,
    Lesson lesson,
    Phrase phrase,
  ) {
    FirebasePaths.phraseRef(lang, section, lesson, phrase)
        .updateData(phrase.toJson());
  }

  updateLessonQuestion(
    Lang lang,
    LessonSection section,
    Lesson lesson,
    Question question,
  ) {
    FirebasePaths.questionRef(lang, section, lesson, question)
        .updateData(question.toJson());
  }

  // Helpers

  Future<String> _insertDocWithIndex(
      CollectionReference collRef, IndexMixin doc) async {
    final docs = await collRef
        .where('index', isGreaterThanOrEqualTo: doc.index)
        .getDocuments();

    for (var mDoc in docs.documents) {
      await mDoc.reference.updateData({
        'index': FieldValue.increment(1),
      });
    }

    return (await collRef.add(doc.toJson())).documentID;
  }

  _deleteDocWithIndex(CollectionReference collRef, IndexMixin doc) async {
    final deleteDocs =
        await collRef.where('index', isEqualTo: doc.index).getDocuments();

    for (var mDoc in deleteDocs.documents) {
      await mDoc.reference.delete();
    }

    final moveDocs = await collRef
        .where('index', isGreaterThanOrEqualTo: doc.index)
        .getDocuments();

    for (var mDoc in moveDocs.documents) {
      await mDoc.reference.updateData({
        'index': FieldValue.increment(-1),
      });
    }
  }
}
