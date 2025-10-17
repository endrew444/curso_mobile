class UsuarioModel {
  final String id;
  final String email;

  UsuarioModel({required this.id, required this.email});

  Map<String, dynamic> toMap() => {'id': id, 'email': email};
}
