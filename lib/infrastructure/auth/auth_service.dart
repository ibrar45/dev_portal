import 'package:firebase_auth/firebase_auth.dart';

// ignore: camel_case_types
class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  // ignore: non_constant_identifier_names
  Future<User?> SignUp(
      {required String email, required String password}) async {
    try {
      final result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    }
  }

  // ignore: non_constant_identifier_names
  Future<User?> SignIn(
      {required String email, required String password}) async {
    try {
      final result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    }
  }

  // ignore: non_constant_identifier_names
  Future<void> SignOut() async {
    await _firebaseAuth.signOut();
  }

  User? get currentUser => _firebaseAuth.currentUser;
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
}
