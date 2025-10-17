import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _nifCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthController>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _nifCtrl, decoration: const InputDecoration(labelText: 'NIF')),
            TextField(controller: _passCtrl, decoration: const InputDecoration(labelText: 'Senha'), obscureText: true),
            const SizedBox(height: 12),
            if (auth.errorMessage != null) Text(auth.errorMessage!, style: const TextStyle(color: Colors.red)),
            ElevatedButton(
              onPressed: auth.isLoading ? null : () async {
                await auth.signIn(_nifCtrl.text.trim(), _passCtrl.text.trim());
                if (auth.currentUser != null) {
                  Navigator.pushReplacementNamed(context, '/home');
                }
              },
              child: auth.isLoading ? const CircularProgressIndicator() : const Text('Entrar'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: auth.isLoading ? null : () async {
                await auth.signInWithBiometrics();
                if (auth.currentUser != null) {
                  Navigator.pushReplacementNamed(context, '/home');
                }
              },
              child: const Text('Entrar com Biometria'),
            ),
          ],
        ),
      ),
    );
  }
}
