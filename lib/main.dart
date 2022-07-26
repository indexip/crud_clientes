import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practica_crud/screens/cliente_form_screen.dart';
import 'package:practica_crud/screens/home_screen.dart';
import 'package:practica_crud/services/cliente_service.dart';
import 'package:provider/provider.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ClienteService>(
          create: (context) => ClienteService(),
        )
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: {
        'home': (context) => HomeScreen(),
        'cliente': (context) => ClienteFormScreen()
      },
    );
  }
}
