import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String _nifToEmail(String nif) {
    return '\${nif}@example.com';
  }

  Future<User?> signInWithNifAndPassword(String nif, String password) async {
    final email = _nifToEmail(nif);
    final cred = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return cred.user;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
