import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> login(String email, String senha) async {
    final cred = await _auth.signInWithEmailAndPassword(
      email: email,
      password: senha,
    );
    return cred.user;
  }

  Future<User?> registrar(String email, String senha) async {
    final cred = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: senha,
    );
    return cred.user;
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  User? get usuarioAtual => _auth.currentUser;
}
