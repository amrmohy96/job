import 'package:firebase_auth/firebase_auth.dart';
import 'package:workingwithfirebase/models/user.dart';

class Auth {
  final _instance = FirebaseAuth.instance;

  Stream<User> get onAuth =>
      _instance.onAuthStateChanged.map(_userFromFirebase);

  User _userFromFirebase(FirebaseUser user) {
    if (user == null) {
      return null;
    }
    return User(uid: user.uid);
  }

  Future<User> getCurrentUser() async {
    FirebaseUser user = await _instance.currentUser();
    return _userFromFirebase(user);
  }

  Future<User> guestUser() async {
    AuthResult result = await _instance.signInAnonymously();
    return _userFromFirebase(result.user);
  }

  Future<void> signOut() async {
    await _instance.signOut();
  }

  Future<User> signInWithEmailAndPassword(String email,String password) async {
   AuthResult authRes = await  _instance.signInWithEmailAndPassword(email: email, password: password);
   return _userFromFirebase(authRes.user);
  }

    Future<User> createUserWithEmailAndPassword(String email,String password) async {
   AuthResult authRes = await  _instance.createUserWithEmailAndPassword(email: email, password: password);
   return _userFromFirebase(authRes.user);
  }
}
