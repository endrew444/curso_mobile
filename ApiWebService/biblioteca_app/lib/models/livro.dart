class Livro {
  final String id;
  final String titulo;
  final String autor;

  Livro({
    required this.id,
    required this.titulo,
    required this.autor,
  });

  factory Livro.fromJson(Map<String, dynamic> json) {
    return Livro(
      id: json['id'],
      titulo: json['titulo'],
      autor: json['autor'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'autor': autor,
    };
  }
}
