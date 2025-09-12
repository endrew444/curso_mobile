
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/firebase_options.dart';
import 'package:lista_de_tarefas/views/auth_view.dart';

void main() async{ // sincronizza com o firebase enquanto compila a build do aplicativo
  //garantir a inicialização dos binding
  WidgetsFlutterBinding.ensureInitialized();
  //inicializa o Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(MaterialApp(
    title: "Lista de Tarefas",
    home: AuthView(),
  ));
}