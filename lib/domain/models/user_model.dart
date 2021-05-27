// To parse this JSON data, do
//
//     final store = storeFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.city,
    required this.address,
    required this.zipCode,
    required this.role,
    required this.phone,
    required this.imageUrl,
  });

  String id;
  String name;
  String email;
  String city;
  String address;
  String zipCode;
  String role;
  String phone;
  String imageUrl;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      city: json["city"],
      address: json["address"],
      zipCode: json["zipCode"],
      role: json["role"],
      phone: json["phone"],
      imageUrl: json["imgUrl"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "city": city,
        "address": address,
        "zipCode": zipCode,
        "phone": phone,
        "imageUrl": imageUrl,
      };
}
