// To parse this JSON data, do
//
//     final store = storeFromJson(jsonString);

import 'dart:convert';

Store storeFromJson(String str) => Store.fromJson(json.decode(str));

String storeToJson(Store data) => json.encode(data.toJson());

class Store {
  Store({
    required this.id,
    required this.name,
    required this.password,
    required this.email,
    required this.city,
    required this.street,
    required this.zipCode,
    required this.phone,
  });

  int id;
  String name;
  String password;
  String email;
  String city;
  String street;
  String zipCode;
  String phone;

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: json["id"],
        name: json["name"],
        password: json["password"],
        email: json["email"],
        city: json["city"],
        street: json["street"],
        zipCode: json["zipCode"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "password": password,
        "email": email,
        "city": city,
        "street": street,
        "zipCode": zipCode,
        "phone": phone,
      };
}
