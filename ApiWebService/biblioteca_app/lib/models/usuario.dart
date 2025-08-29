class Usuario {
  //atributos
  final String? id; //pode ser nulo inicialmente -> id será atribuido pelo BD
  final String nome;
  final String email;

  //construtor
  Usuario({this.id, required this.nome, required this.email});

  //métodos
  //toJson obj => map (json)
  Map<String, dynamic> toJson() => {"id": id, "nome": nome, "email": email};

  //FromJson json(map) => obj
  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
    id: json["id"].toString(),
    nome: json["nome"].toString(),
    email: json["email"].toString(),
  );
}
