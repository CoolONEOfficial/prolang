import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:prolang/app/models/lang.dart';
import 'package:prolang/app/models/lesson.dart';
import 'package:prolang/app/models/lesson_section.dart';
import 'package:prolang/app/services/firestore_service.dart';
import 'package:provider/provider.dart';

class LangViewModel extends ChangeNotifier {
  LangViewModel(
    this.locator,
    this.lang,
    this.fs,
  ) {
    loadLessonList();
  }

  final Locator locator;
  final Lang lang;
  final FirestoreService fs;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List<MapEntry<LessonSection, List<Lesson>>> sectionList;

  loadLessonList() async {
    _setLoading();

    sectionList = [];
    for (var section in await fs.loadSectionList(lang)) {
      sectionList.add(
        MapEntry(
          section,
          await fs.loadLessonList(lang, section),
        ),
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
