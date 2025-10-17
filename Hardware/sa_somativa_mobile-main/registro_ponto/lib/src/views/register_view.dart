import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';
import 'login_view.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _email = TextEditingController();
  final _senha = TextEditingController();
  final _authController = AuthController();
  String _mensagem = "";

  Future<void> _registrar() async {
    try {
      await _authController.registrar(_email.text.trim(), _senha.text.trim());
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginView()),
        );
      }
    } catch (e) {
      setState(() => _mensagem = "Erro: ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cadastro")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _email,
              decoration: const InputDecoration(labelText: "E-mail"),
            ),
            TextField(
              controller: _senha,
              decoration: const InputDecoration(labelText: "Senha"),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _registrar, child: const Text("Cadastrar")),
            Text(_mensagem),
          ],
        ),
      ),
    );
  }
}
