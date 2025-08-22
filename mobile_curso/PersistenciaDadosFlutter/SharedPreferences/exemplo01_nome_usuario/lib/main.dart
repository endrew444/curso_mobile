import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(home: UserNamePage()));
}

//classe da pagina

class UserNamePage extends StatefulWidget {
  @override
  _UserNamePageState createState() => _UserNamePageState();
}

class _UserNamePageState extends State<UserNamePage> {
  TextEditingController _controller = TextEditingController();
  String _nomeSalvo = "";

  @override
  void initState() {
    super.initState();
    _carregarNomeSalvo();
  }

  void _carregarNomeSalvo() async {
    // usar o SharedPreferences para  carregar as informações salvas
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _nomeSalvo = prefs.getString('nome') ?? "";
    });
  }

  void _salvarNome() async {
    //usar o sharedpreferences para salvar informações
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("nome", _controller.text);
    _carregarNomeSalvo(); //SetState para atualizar a tela
    _controller.clear(); //limpar o campo de texto
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bem vindo ${_nomeSalvo == "" ? "Visitante" : _nomeSalvo}"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: "Digite seu Nome"),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _salvarNome, child: Text("Salvar")),
          ],
        ),
      ),
    );
  }
}