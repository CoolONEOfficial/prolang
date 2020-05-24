import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prolang/app/models/lang.dart';
import 'package:prolang/app/models/lesson.dart';
import 'package:prolang/app/models/lesson_section.dart';
import 'package:provider/provider.dart';

class LessonPhrasesViewModel extends ChangeNotifier {
  LessonPhrasesViewModel(this.locator, this.lesson, this.section, this.lang) {
    // loadLessonList();
  }

  final Locator locator;
  final Lesson lesson;
  final LessonSection section;
  final Lang lang;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // loadLessonList() async {
  //   _setLoading();
  //   _setNotLoading();
  // }

  reload() {
    _setLoading();
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
