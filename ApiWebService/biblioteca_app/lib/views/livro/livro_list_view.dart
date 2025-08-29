import 'package:biblioteca_app/controllers/livro_controller.dart';
import 'package:biblioteca_app/models/livro.dart';
import 'package:biblioteca_app/views/livro/livro_form_view.dart';
import 'package:flutter/material.dart';

class LivroListView extends StatefulWidget {
  const LivroListView({super.key});

  @override
  State<LivroListView> createState() => _LivroListViewState();
}

class _LivroListViewState extends State<LivroListView> {
  final _controller = LivroController();
  List<Livro> _livros = [];
  List<Livro> _filtroLivros = [];
  final _buscaField = TextEditingController();
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() async {
    setState(() => _loading = true);
    try {
      _livros = await _controller.fetchAll();
      _filtroLivros = _livros;
    } catch (e) {
      // tratar erro
    }
    setState(() => _loading = false);
  }

  void _filtrar() {
    final busca = _buscaField.text.toLowerCase();
    setState(() {
      _filtroLivros = _livros.where((livro) {
        return livro.titulo.toLowerCase().contains(busca) ||
               livro.autor.toLowerCase().contains(busca);
      }).toList();
    });
  }

  void _openForm({Livro? livro}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LivroFormView(livro: livro),
      ),
    );
    _load();
  }

  void _delete(Livro livro) async {
    if (livro.id == null) return;
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirma Exclusão"),
        content: Text("Deseja realmente excluir o livro \"${livro.titulo}\"?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text("Cancelar"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text("Excluir"),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        await _controller.delete(livro.id);
        _load();
      } catch (e) {
        // tratar erro
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lista de Livros")),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    controller: _buscaField,
                    decoration: InputDecoration(labelText: "Pesquisar Livro"),
                    onChanged: (value) => _filtrar(),
                  ),
                  Divider(),
                  Expanded(
                    child: _filtroLivros.isEmpty
                        ? Center(child: Text("Nenhum livro encontrado."))
                        : ListView.builder(
                            itemCount: _filtroLivros.length,
                            itemBuilder: (context, index) {
                              final livro = _filtroLivros[index];
                              return Card(
                                child: ListTile(
                                  title: Text(livro.titulo),
                                  subtitle: Text("Autor: ${livro.autor}"),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.edit),
                                        onPressed: () => _openForm(livro: livro),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete, color: Colors.red),
                                        onPressed: () => _delete(livro),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openForm(),
        child: Icon(Icons.add),
      ),
    );
  }
}
