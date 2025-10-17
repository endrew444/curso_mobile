import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import '../services/auth_service.dart';

class AuthController extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final LocalAuthentication _localAuth = LocalAuthentication();

  User? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<bool> canAuthenticate() async {
    try {
      final canCheck = await _localAuth.canCheckBiometrics;
      final isDeviceSupported = await _localAuth.isDeviceSupported();
      return canCheck && isDeviceSupported;
    } catch (e) {
      _errorMessage = 'Erro ao verificar biometria: $e';
      notifyListeners();
      return false;
    }
  }

  Future<void> signIn(String nif, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _currentUser = await _authService.signInWithNifAndPassword(nif, password);
    } on FirebaseAuthException catch (e) {
      _errorMessage = e.message ?? 'Erro ao fazer login.';
    } catch (e) {
      _errorMessage = 'Erro inesperado: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signInWithBiometrics() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final canAuth = await canAuthenticate();
      if (!canAuth) {
        _errorMessage = 'Biometria não disponível neste dispositivo.';
        _isLoading = false;
        notifyListeners();
        return;
      }

      final authenticated = await _localAuth.authenticate(
        localizedReason: 'Confirme sua identidade para registrar o ponto.',
        authMessages: const <AuthMessages>[
          AndroidAuthMessages(
            signInTitle: 'Autenticação necessária',
            cancelButton: 'Cancelar',
          ),
        ],
      );

      if (authenticated) {
        _currentUser = FirebaseAuth.instance.currentUser;
        if (_currentUser == null) {
          _errorMessage =
              'Nenhum usuário logado no Firebase. Faça login com NIF/senha primeiro.';
        }
      } else {
        _errorMessage = 'Falha na autenticação biométrica.';
      }
    } catch (e) {
      _errorMessage = 'Erro durante a autenticação biométrica: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
    _currentUser = null;
    notifyListeners();
  }
}
