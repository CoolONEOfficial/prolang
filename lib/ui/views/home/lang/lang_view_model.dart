import 'package:flutter/foundation.dart';
import 'package:prolang/app/models/lang.dart';
import 'package:prolang/app/models/lesson.dart';
import 'package:prolang/app/services/firestore_service.dart';
import 'package:provider/provider.dart';

class LangViewModel extends ChangeNotifier {
  LangViewModel(this.locator, this.lang) {
    loadLessonList();
  }

  final Locator locator;
  final Lang lang;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List<Lesson> lessonList;

  Future<void> loadLessonList() async {
    _setLoading();
    lessonList = await locator<FirestoreService>().loadLessonList(lang);
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
