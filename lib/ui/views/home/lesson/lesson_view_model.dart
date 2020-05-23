import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prolang/app/models/lang.dart';
import 'package:prolang/app/models/lesson.dart';
import 'package:prolang/app/models/lesson_section.dart';
import 'package:prolang/app/services/firebase_storage_service.dart';
import 'package:provider/provider.dart';

class LessonViewModel extends ChangeNotifier {
  LessonViewModel(this.locator, this.lesson, this.section, this.lang) {
    loadLessonList();
  }

  final Locator locator;
  final Lesson lesson;
  final LessonSection section;
  final Lang lang;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  String videoUrl;

  loadLessonList() async {
    _setLoading();

    videoUrl = await FirebaseStorageService.loadFromStorage(
      "langs/${lang.documentId}/sections/${section.documentId}/lessons/${lesson.documentId}/video.mp4",
    );

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
