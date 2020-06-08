import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prolang/app/models/lang.dart';
import 'package:prolang/app/models/lesson.dart';
import 'package:prolang/app/models/lesson_section.dart';
import 'package:prolang/app/models/question.dart';
import 'package:prolang/app/services/firestore_service.dart';
import 'package:provider/provider.dart';

class LessonTestViewModel extends ChangeNotifier {
  LessonTestViewModel(
    this.locator,
    this.lesson,
    this.section,
    this.lang,
    this.fs,
  ) {
    loadQuestionList();
  }

  final Locator locator;
  final Lesson lesson;
  final LessonSection section;
  final Lang lang;
  final FirestoreService fs;

  int step = 0;
  List<Question> questionList;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  deleteQuestion(Question question) async {
    _setLoading();

    questionList = await fs.deleteLessonQuestion(
      lang,
      section,
      lesson,
      question,
    );
    if (step != 0) {
      step--;
    }

    loadQuestionList();

    _setNotLoading();
  }

  loadQuestionList() async {
    _setLoading();

    questionList = await fs.loadQuestionList(lang, section, lesson);

    _setNotLoading();
  }

  void _setLoading() {
    _isLoading = true;
    notifyListeners();
  }

  void _setNotLoading() {
    _isLoading = false;
    notifyListeners();
  }
}
