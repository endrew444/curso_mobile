import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main(){
  runApp(MaterialApp(
    home: LocationScreen(),
  ));
}

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  //atributos
  String mensagem = "";

  //método pra pegar a localização
  Future<String> _getLocation() async{
    bool serviceEnable;
    LocationPermission permission;

    //teste se o servidor esta ativo
    serviceEnable = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnable){
      return "Serviço de Localização está Desativada";
    }
    permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied){
        return "Permissão de Localização Negada";
      }
    }
    //se a localização foi liberada
    Position position = await Geolocator.getCurrentPosition();
    return "Latitude: ${position.latitude} - Longitude: ${position.longitude}";
  }
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //chama o metodo antes de buildar a tela
    setState(() {
      mensagem = _getLocation().toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("GPS - Localização"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(mensagem),
            ElevatedButton(
              onPressed: () async{
                setState(() {
                  mensagem = _getLocation().toString();
                });
              }, 
                child: Text("Pegar a Localização"))
          ],
        ),
      ),
    );
  }
}