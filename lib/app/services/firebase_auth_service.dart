import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:prolang/app/constants/firebase_paths.dart';
import 'package:prolang/app/models/user.dart';
import 'package:prolang/app/services/firestore_service.dart';
import 'package:prolang/main.dart';
import 'package:tuple/tuple.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  static User cachedCurrentUser;

  FirebaseAuthService({FirebaseAuth firebaseAuth, GoogleSignIn googleSignin})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignin ?? GoogleSignIn();

  Future<Tuple2<UserState, User>> _userFromFirebase(FirebaseUser user) async {
    final userModel = Tuple2(
      UserState.Done,
      user == null
          ? null
          : User.fromSnapshotAndUser(
              await FirebasePaths.userRefFromId(user.uid).get(),
              user,
            ),
    );
    cachedCurrentUser = userModel.item2;
    return userModel;
  }

  Stream<Tuple2<UserState, User>> get onAuthStateChanged {
    return _firebaseAuth.onAuthStateChanged.asyncMap(_userFromFirebase);
  }

  Future<User> signInAnonymously() async {
    final authResult = await _firebaseAuth.signInAnonymously();
    return (await _userFromFirebase(authResult.user)).item2;
  }

  Future<User> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final authResult = await _firebaseAuth.signInWithCredential(credential);
    return (await _userFromFirebase(authResult.user)).item2;
  }

  Future<void> signOut() async {
    cachedCurrentUser = null;
    return _firebaseAuth.signOut();
  }

  Future<User> currentUser() async {
    final user = await _firebaseAuth.currentUser();
    return (await _userFromFirebase(user)).item2;
  }
}
