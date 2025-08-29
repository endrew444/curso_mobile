class Livro {
  //atributos
  final String? id;
  final String titulo;
  final String autor;
  final bool disponivel;

  //construtor
  Livro({
    this.id,
    required this.titulo,
    required this.autor,
    required this.disponivel
  });

  //ToMAp
  Map<String,dynamic> toMap() => {
    "id":id,
    "titulo":titulo,
    "autor":autor,
    "disponivel":disponivel
  };

  //FromMap
  factory Livro.fromMap(Map<String,dynamic> map) => Livro(
    id: map["id"].toString(),
    titulo: map["titulo"].toString(),
    autor: map["autor"].toString(),
    disponivel: map["disponivel"]==1 // c for 1 é true
  );
}

