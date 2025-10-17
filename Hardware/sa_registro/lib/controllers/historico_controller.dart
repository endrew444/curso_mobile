import 'package:flutter/foundation.dart';

class HistoricoController extends ChangeNotifier {
  // Simple placeholder for history logic
  List<String> _items = [];

  List<String> get items => List.unmodifiable(_items);

  void add(String s) {
    _items.add(s);
    notifyListeners();
  }
}
