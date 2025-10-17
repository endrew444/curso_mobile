import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'controllers/auth_controller.dart';
import 'controllers/ponto_controller.dart';
import 'controllers/historico_controller.dart';

import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/registro_ponto_screen.dart';
import 'screens/historico_screen.dart';

void main() async {
 
  WidgetsFlutterBinding.ensureInitialized();

  // Ação 2: Inicializa o Firebase. Se a falha for nativa, ela ocorre aqui.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(create: (_) => PontoController()),
        ChangeNotifierProvider(create: (_) => HistoricoController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SA Registro de Ponto',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/registro': (context) => const RegistroPontoScreen(),
        '/historico': (context) => const HistoricoScreen(),
      },
    );
  }
}