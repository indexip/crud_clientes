import 'package:flutter/material.dart';
import 'package:practica_crud/provider/cliente_form_provider.dart';
import 'package:practica_crud/services/cliente_service.dart';
import 'package:provider/provider.dart';

class ClienteFormScreen extends StatelessWidget {
  const ClienteFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final clienteService = Provider.of<ClienteService>(context);
    return ChangeNotifierProvider(
      create: (context) => ClienteFromProvider(clienteService.selectCliente),
      child: _ClienteScreenBody(
        clienteService: clienteService,
      ),
    );
  }
}

//Cuerpo de la pantalla

class _ClienteScreenBody extends StatelessWidget {
  final ClienteService clienteService;

  const _ClienteScreenBody({super.key, required this.clienteService});

  Widget build(BuildContext context) {
    final clienteForm = Provider.of<ClienteFromProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Crear nuevo cliente'),
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [_ClienteForm()],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.save_outlined),
          onPressed: () {
            if (!clienteForm.isvalidForm()) return;
            clienteService.saveOrCreateCliente(clienteForm.cliente);
          }),
    );
  }
}

//componentes del formulario

class _ClienteForm extends StatelessWidget {
  const _ClienteForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final clienteForm = Provider.of<ClienteFromProvider>(context);
    final cliente = clienteForm.cliente;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      height: 500,
      child: Form(
        key: clienteForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              initialValue: cliente.nombre,
              onChanged: (value) => cliente.nombre = value,
              validator: (value) {
                if (value == null || value.length < 1)
                  return 'El nombre es obligatorio';
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              initialValue: cliente.apellido,
              onChanged: (value) => cliente.apellido = value,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              initialValue: cliente.email,
              onChanged: (value) => cliente.email = value,
            ),
          ],
        ),
      ),
    );
  }
}
