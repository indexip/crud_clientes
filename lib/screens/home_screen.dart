import 'package:flutter/material.dart';
import 'package:practica_crud/models/cliente.dart';
import 'package:practica_crud/screens/loading_screen.dart';
import 'package:practica_crud/services/cliente_service.dart';
import 'package:practica_crud/widgets/cliente_tile.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ClienteService clienteService = Provider.of<ClienteService>(context);

    if (clienteService.isLoading) return LoadingScreen();

    return Scaffold(
      body: Center(
        child: ListView.builder(
            itemCount: clienteService.clientes.length,
            itemBuilder: (context, index) =>
                ClienteTile(cliente: clienteService.clientes[index])),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            clienteService.selectCliente =
                new Cliente(nombre: '', apellido: '', email: '');

            Navigator.pushNamed(context, 'cliente');
          }),
    );
  }
}
