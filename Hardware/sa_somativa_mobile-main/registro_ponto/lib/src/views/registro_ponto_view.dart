import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../controllers/registro_ponto_controller.dart';
import '../controllers/auth_controller.dart';
import 'login_view.dart';
import 'mapa_view.dart';

class RegistroPontoView extends StatefulWidget {
  const RegistroPontoView({super.key});

  @override
  State<RegistroPontoView> createState() => _RegistroPontoViewState();
}

class _RegistroPontoViewState extends State<RegistroPontoView> {
  final _controller = RegistroPontoController();
  final _authController = AuthController();
  String _mensagem = "";

  // Novo método: abre o mapa antes de registrar o ponto
  Future<void> _abrirMapaAntesDoRegistro() async {
    setState(() => _mensagem = "Obtendo localização...");

    try {
      // Obtém a localização atual
      Position posicao = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() => _mensagem = "Abrindo mapa...");

      // Abre o mapa mostrando a localização atual
      if (mounted) {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MapaView(
              latitude: posicao.latitude,
              longitude: posicao.longitude,
            ),
          ),
        );
      }

      // Após o usuário fechar o mapa, registra o ponto
      setState(() => _mensagem = "Registrando ponto...");
      await _controller.registrarPonto();
      setState(() => _mensagem = "Ponto registrado com sucesso!");
    } catch (e) {
      setState(() => _mensagem = " ${e.toString()}");
    }
  }

  Future<void> _logout() async {
    await _authController.logout();
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginView()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registro de Ponto"),
        actions: [
          IconButton(onPressed: _logout, icon: const Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _abrirMapaAntesDoRegistro,
              child: const Text("Ver Mapa e Registrar Ponto"),
            ),
            const SizedBox(height: 20),
            Text(
              _mensagem,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
