import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/historico_controller.dart';

class HistoricoScreen extends StatelessWidget {
  const HistoricoScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final hist = Provider.of<HistoricoController>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Histórico')),
      body: ListView.builder(
        itemCount: hist.items.length,
        itemBuilder: (context, index) {
          return ListTile(title: Text(hist.items[index]));
        },
      ),
    );
  }
}
