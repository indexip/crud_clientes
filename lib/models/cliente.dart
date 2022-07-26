// To parse this JSON data, do
//
//     final cliente = clienteFromMap(jsonString);

import 'dart:convert';

class Cliente {
  Cliente(
      {this.id,
      required this.nombre,
      required this.apellido,
      required this.email,
      this.createAt});

  int? id;
  String nombre;
  String apellido;
  String email;
  String? createAt;

  factory Cliente.fromJson(String str) => Cliente.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Cliente.fromMap(Map<String, dynamic> json) => Cliente(
      id: json["id"],
      nombre: json["nombre"],
      apellido: json["apellido"],
      email: json["email"],
      createAt: json["createAt"]);

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombre": nombre,
        "apellido": apellido,
        "email": email,
      };

  Cliente copy() => Cliente(
      id: this.id,
      nombre: this.nombre,
      apellido: this.apellido,
      email: this.email);
}
