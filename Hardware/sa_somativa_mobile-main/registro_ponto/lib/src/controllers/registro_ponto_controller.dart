import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';

class RegistroPontoController {
  // Coordenadas do SENAI Limeira
  static const double _latSenai = -22.5796;
  static const double _lngSenai = -47.4014;
  static const double _raioPermitido = 100; // metros

  Future<void> registrarPonto() async {
    bool dentroDoLocal = await _verificarDistanciaDoLocal();

    if (!dentroDoLocal) {
      throw Exception("Você está fora do SENAI Limeira (100m).");
    }

    User? usuario = FirebaseAuth.instance.currentUser;
    if (usuario == null) {
      throw Exception("Usuário não autenticado.");
    }

    Position posicaoAtual = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    await FirebaseFirestore.instance.collection('registros').add({
      'usuarioId': usuario.uid,
      'dataHora': DateTime.now().toIso8601String(),
      'latitude': posicaoAtual.latitude,
      'longitude': posicaoAtual.longitude,
    });
  }

  Future<bool> _verificarDistanciaDoLocal() async {
    LocationPermission permissao = await Geolocator.requestPermission();
    if (permissao == LocationPermission.denied ||
        permissao == LocationPermission.deniedForever) {
      throw Exception("Permissão de localização negada.");
    }

    Position posicaoAtual = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    double distancia = Geolocator.distanceBetween(
      _latSenai,
      _lngSenai,
      posicaoAtual.latitude,
      posicaoAtual.longitude,
    );

    return distancia <= _raioPermitido;
  }
}
