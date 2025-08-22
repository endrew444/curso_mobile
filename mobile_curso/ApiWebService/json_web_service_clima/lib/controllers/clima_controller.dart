import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:json_web_service_clima/models/clima_model.dart';

class ClimaController {
  final String _apikey = "90290436d34bb91b4d852afe49197129";

  //metodos
  Future<Clima?> getClima(String cidade) async {
    final url = Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=$cidade&appid=$_apikey&units=metric&lang=pt_br"
    );
    final res = await http.get(url);

    //verficar se a requisicao deu certo
    if (res.statusCode == 200) {
      final dados = json.decode(res.body);
      return Clima.fromJson(dados);
    }else{
      return null;
    }
  }
}