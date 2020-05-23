import 'package:chewie/chewie.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prolang/app/models/lesson.dart';
import 'package:prolang/app/services/firebase_storage_service.dart';
import 'package:prolang/ui/views/home/lesson/widgets/video_scaffold.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class LessonViewModel extends ChangeNotifier {
  LessonViewModel(this.locator, this.lesson) {
    loadLessonList();
  }

  final Locator locator;
  final Lesson lesson;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  String videoUrl;

  loadLessonList() async {
    _setLoading();

    videoUrl = await FirebaseStorageService.loadFromStorage("test.mp4");
    
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
