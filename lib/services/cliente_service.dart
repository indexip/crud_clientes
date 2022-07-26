import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:practica_crud/models/cliente.dart';
import 'package:http/http.dart' as http;
import 'package:practica_crud/services/global.dart';

class ClienteService extends ChangeNotifier {
  final List<Cliente> clientes = [];
  late Cliente selectCliente;
  bool isLoading = true;
  bool isSalving = false;

  ClienteService() {
    this.loadClientes();
  }

  Future<List<Cliente>> loadClientes() async {
    this.isLoading = true;
    notifyListeners();
    final url = Uri.parse(baseURL + '/clientes');
    final resp = await http.get(url, headers: headers);

    print(url);

    final List clienteList = jsonDecode(resp.body);
    print(clienteList);

    for (Map<String, dynamic> responseMap in clienteList) {
      Cliente cliente = Cliente.fromMap(responseMap);
      clientes.add(cliente);
    }

    this.isLoading = false;
    notifyListeners();

    return this.clientes;
  }

  Future saveOrCreateCliente(Cliente cliente) async {
    isSalving = true;
    notifyListeners();
    if (cliente.id == null) {
      this.createCliente(cliente);
    } else {
      await this.updateCliente(cliente);
    }

    isSalving = false;
    notifyListeners();
  }

  Future<int> updateCliente(Cliente cliente) async {
    var url = Uri.parse(baseURL + '/clientes/${cliente.id}');

    http.Response response =
        await http.put(url, headers: headers, body: cliente.toJson());

    print(cliente.toJson());
    final decodeData = response.body;

    final index = clientes.indexWhere((element) => element.id == cliente.id);

    print(index);

    this.clientes[index] = cliente;
    notifyListeners();

    print(response.body);

    return cliente.id!;
  }

  Future<int> createCliente(Cliente cliente) async {
    var url = Uri.parse(baseURL + '/clientes');

    http.Response response =
        await http.post(url, headers: headers, body: cliente.toJson());

    final decodeData = jsonDecode(response.body);

    cliente.id = decodeData['nombre'];
    this.clientes.add(cliente);
    print(decodeData);
    notifyListeners();

    return cliente.id == null ? 1 : cliente.id!;
  }

  /* Future<String> createProduct(Product product) async {
    final url = Uri.https(_baseUrl, 'products.json');
    final resp = await http.post(url, body: product.toJson());
    final decodedData = json.decode(resp.body);

    product.id = decodedData['name'];

    this.products.add(product);

    return product.id!;
  }*/
}
