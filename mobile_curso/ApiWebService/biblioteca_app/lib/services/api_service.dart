// classe de ajuda para conexão com API
import 'dart:convert';

import 'package:http/http.dart' as http;
class ApiService {
  //base url pra conexão
  String _baseUrl = "http://10.109.197.8:3011";

  //metodos static(metodfos da classse e n do obj)
  //GET -> listar todos os recursos
  static Future<List<dynamic>> getList(String path) async{
    final res = await http.get(Uri.parse("$_baseUrl/$path"));
    if(res.statusCode ==200) return json.decode(res.body);
}