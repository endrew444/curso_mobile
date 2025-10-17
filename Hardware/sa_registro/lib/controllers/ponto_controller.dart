import 'package:flutter/foundation.dart';

class PontoController extends ChangeNotifier {
  bool _isRegistering = false;
  String? _error;

  bool get isRegistering => _isRegistering;
  String? get error => _error;

  Future<void> registerPonto() async {
    _isRegistering = true;
    _error = null;
    notifyListeners();

    try {
      // Simulate registering a punch. Replace with Firestore/Realtime DB logic.
      await Future.delayed(const Duration(seconds: 1));
    } catch (e) {
      _error = e.toString();
    } finally {
      _isRegistering = false;
      notifyListeners();
    }
  }
}
