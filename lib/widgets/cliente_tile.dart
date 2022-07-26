import 'package:flutter/material.dart';
import 'package:practica_crud/models/cliente.dart';
import 'package:practica_crud/services/cliente_service.dart';
import 'package:provider/provider.dart';

class ClienteTile extends StatelessWidget {
  const ClienteTile({Key? key, required this.cliente}) : super(key: key);

  final Cliente cliente;

  @override
  Widget build(BuildContext context) {
    final ClienteService clienteService = Provider.of<ClienteService>(context);

    return Card(
      child: ListTile(
        onTap: () {
          clienteService.selectCliente = cliente.copy();
          Navigator.pushNamed(context, 'cliente');
        },
        title: Text('${cliente.nombre} ${cliente.apellido}'),
      ),
    );
  }
}
