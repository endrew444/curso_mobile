//classe para modelagem de dados da api

class Clima {
  //atributos
  final String nome;
  final double temperatura;
  final String descricao;

  //construtor
  Clima({
    required this.nome,
    required this.temperatura,
    required this.descricao,
  });
  //fromJson - metodo para converter json em objeto
  //factory(construtor direcionado para a modelagem)
   factory Clima.fromJson(Map<String,dynamic> json){
    return Clima(
      nome: json["name"], 
      temperatura: json["main"]["temp"], 
      descricao: json["weather"][0]["description"]);
  }
}