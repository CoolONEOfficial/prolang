import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:prolang/app/mixins/index_mixin.dart';
import 'package:prolang/app/models/lang.dart';
import 'package:prolang/app/models/lesson.dart';
import 'package:prolang/app/models/lesson_section.dart';

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
    var snapshot = await langRef(lang)
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
    var snapshot = await lessonSectionRef(lang, section)
        .collection('lessons')
        .orderBy('index')
        .getDocuments();

    return snapshot.documents
        .map((langSnapshot) => Lesson.fromSnapshot(langSnapshot))
        .toList();
  }

  // Delete

  deleteLessonSection([
    Lang lang,
    LessonSection section,
  ]) async {
    await _deleteDocWithIndex(
      langRef(
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
      lessonSectionRef(
        lang,
        section,
      ).collection('lessons'),
      lesson,
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
      langRef(
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
      lessonSectionRef(
        lang,
        section,
      ).collection('lessons'),
      lesson,
    );
  }

  // Helpers

  Future<String> _insertDocWithIndex(CollectionReference collRef, IndexMixin doc) async {
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

  // Update

  updateLesson(Lang lang, LessonSection section, Lesson lesson) {
    lessonRef(lang, section, lesson).updateData(lesson.toJson());
  }

  updateLessonSection(Lang lang, LessonSection section) {
    lessonSectionRef(lang, section).updateData(section.toJson());
  }

  // Ref

  DocumentReference langRef(Lang lang) =>
      _firestore.collection('langs').document(lang.documentId);

  DocumentReference lessonSectionRef(Lang lang, LessonSection section) =>
      langRef(lang).collection('sections').document(section.documentId);

  DocumentReference lessonRef(
          Lang lang, LessonSection section, Lesson lesson) =>
      lessonSectionRef(lang, section)
          .collection('lessons')
          .document(lesson.documentId);
}
