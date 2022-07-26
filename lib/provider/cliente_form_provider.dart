import 'package:flutter/cupertino.dart';
import 'package:practica_crud/models/cliente.dart';

class ClienteFromProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  Cliente cliente;

  ClienteFromProvider(this.cliente);

  bool isvalidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
