import 'package:flutter/foundation.dart';
import 'package:prolang/app/models/lang.dart';
import 'package:prolang/app/services/firestore_service.dart';
import 'package:provider/provider.dart';

class LangListViewModel extends ChangeNotifier {
  LangListViewModel(this.locator) {
    loadLangList();
  }

  final Locator locator;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List<Lang> langList;

  Future<void> loadLangList() async {
    _setLoading();
    langList = await locator<FirestoreService>().loadLangList();
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