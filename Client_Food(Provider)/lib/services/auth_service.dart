import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<UserCredential> signInWithCredential(AuthCredential credential) =>
      _auth.signInWithCredential(credential);

  Future<void> signOut() => _auth.signOut();

  Stream<User?> get currentUser => _auth.authStateChanges();

  Future<User?> signInWithEmail(String email, password) async {
    var user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);

    return user.user;
  }

  Future<UserCredential> signInAnonymously() async {
    var user = await _auth.signInAnonymously();

    return user;
  }

  Future<UserCredential> signUpWithEmail(String email, password) =>
      _auth.createUserWithEmailAndPassword(email: email, password: password);

  Future<dynamic> forgetPasswordWithEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }
}
