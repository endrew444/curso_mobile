import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/auth_controller.dart';
import '../controllers/ponto_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthController>(context);
    final ponto = Provider.of<PontoController>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await auth.signOut();
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Bem-vindo, ${auth.currentUser?.email ?? 'Usuário'}'),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: ponto.isRegistering
                  ? null
                  : () async {
                      await ponto.registerPonto();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Ponto registrado (simulado)'),
                        ),
                      );
                    },
              child: ponto.isRegistering
                  ? const CircularProgressIndicator()
                  : const Text('Registrar Ponto'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/historico');
              },
              child: const Text('Ver Histórico'),
            ),
          ],
        ),
      ),
    );
  }
}
