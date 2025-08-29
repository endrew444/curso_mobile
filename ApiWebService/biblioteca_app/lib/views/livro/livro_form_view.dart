import 'package:biblioteca_app/controllers/livro_controller.dart';
import 'package:biblioteca_app/models/livro.dart';
import 'package:biblioteca_app/views/livro/livro_list_view.dart';
import 'package:flutter/material.dart';

class LivroFormView extends StatefulWidget {
  final Livro? livro;

  const LivroFormView({super.key, this.livro});

  @override
  State<LivroFormView> createState() => _LivroFormViewState();
}

class _LivroFormViewState extends State<LivroFormView> {
  final _formKey = GlobalKey<FormState>();
  final _controller = LivroController();
  final _tituloField = TextEditingController();
  final _autorField = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.livro != null) {
      _tituloField.text = widget.livro!.titulo;
      _autorField.text = widget.livro!.autor;
    }
  }

  void _save() async {
    if (_formKey.currentState!.validate()) {
      final livro = Livro(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        titulo: _tituloField.text.trim(),
        autor: _autorField.text.trim(),
      );
      try {
        await _controller.create(livro);
      } catch (e) {
        // tratar erro
      }
      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LivroListView()),
      );
    }
  }

  void _update() async {
    if (_formKey.currentState!.validate()) {
      final livro = Livro(
        id: widget.livro!.id,
        titulo: _tituloField.text.trim(),
        autor: _autorField.text.trim(),
      );
      try {
        await _controller.update(livro);
      } catch (e) {
        // tratar erro
      }
      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LivroListView()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.livro == null ? "Novo Livro" : "Editar Livro"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _tituloField,
                decoration: InputDecoration(labelText: "Título"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Informe o Título" : null,
              ),
              TextFormField(
                controller: _autorField,
                decoration: InputDecoration(labelText: "Autor"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Informe o Autor" : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: widget.livro == null ? _save : _update,
                child: Text(widget.livro == null ? "Salvar" : "Atualizar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
