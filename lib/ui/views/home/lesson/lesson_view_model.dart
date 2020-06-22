import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prolang/app/constants/firebase_paths.dart';
import 'package:prolang/app/models/lang.dart';
import 'package:prolang/app/models/lesson.dart';
import 'package:prolang/app/models/lesson_section.dart';
import 'package:prolang/app/services/firebase_storage_service.dart';
import 'package:provider/provider.dart';

class LessonViewModel extends ChangeNotifier {
  LessonViewModel(
    this.locator,
    this.lesson,
    this.section,
    this.lang,
  ) {
    loadLessonList();
  }

  final Locator locator;
  final Lesson lesson;
  final LessonSection section;
  final Lang lang;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  String videoUrl;
  String audioUrl;
  String imageUrl;

  loadLessonList() async {
    _setLoading();

    final basePath = FirebasePaths.lessonPath(lang, section, lesson);
    if (lesson.videoBytes > 0) {
      videoUrl = await FirebaseStorageService.loadFromStorage(
        "$basePath/video.mp4",
      );
    }
    if (lesson.audioBytes > 0) {
      audioUrl = await FirebaseStorageService.loadFromStorage(
        "$basePath/audio.mp3",
      );
    }
    if (lesson.imageBytes > 0) {
      imageUrl = await FirebaseStorageService.loadFromStorage(
        "$basePath/image.jpg",
      );
    }

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
