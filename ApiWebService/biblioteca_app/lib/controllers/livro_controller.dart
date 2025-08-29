import 'package:biblioteca_app/models/livro.dart';
import 'package:biblioteca_app/services/api_service.dart';

class LivroController {
  // Buscar todos os livros
  Future<List<Livro>> fetchAll() async {
    final list = await ApiService.getList("livros");
    return list.map((item) => Livro.fromJson(item)).toList();
  }

  // Buscar um livro por ID
  Future<Livro> fetchOne(String id) async {
    final livro = await ApiService.getOne("livros", id);
    return Livro.fromJson(livro);
  }

  // Criar um novo livro
  Future<Livro> create(Livro book) async {
    final created = await ApiService.post("livros", book.toJson());
    return Livro.fromJson(created);
  }

  // Atualizar um livro existente
  Future<Livro> update(Livro book) async {
    final updated = await ApiService.put("livros", book.toJson(), book.id);
    return Livro.fromJson(updated);
  }

  // Deletar um livro
  Future<void> delete(String id) async {
    await ApiService.delete("livros", id);
  }
}
