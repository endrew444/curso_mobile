import 'dart:convert';

void main(){
  //String no fomato Json ->
  String jsonString = '{"usuario":"João","login":"joao_user","senha":1234, "ativo":"true"}';
  //converti a String em MAP -> usando Json. Convert (decode)

Map<String, dynamic> usuario = json.decode(jsonString);
  //acesso aos elementos(atributos) do Json
  print(usuario["ativo"]);

  //Manipular Json usando o MAP
  usuario["ativo"] = false;

  // fazer o encode Map => Json(texto)
  jsonString = json.encode(usuario);

  // mostrar o texto no formato JSON
  print(jsonString);
}