import 'package:flutter/foundation.dart';
import 'package:prolang/app/models/lang.dart';
import 'package:prolang/app/services/firebase_auth_service.dart';
import 'package:prolang/app/services/firestore_service.dart';
import 'package:provider/provider.dart';

class LangListViewModel extends ChangeNotifier {
  LangListViewModel(this.locator, this.fs, this.auth) {
    loadLangList();
  }

  final Locator locator;
  final FirestoreService fs;
  final FirebaseAuthService auth;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List<Lang> langList;

  Future<void> loadLangList() async {
    _setLoading();
    debugPrint("pre");
    langList = await fs.loadLangList();
    debugPrint("post");
    _setNotLoading();
  }

  Future<void> signout() {
    return auth.signOut();
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
