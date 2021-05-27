class RegistroRequest {
  RegistroRequest(
      {required this.username,
      required this.email,
      required this.password,
      required this.rol,
      required this.city,
      required this.address,
      required this.zipCode,
      required this.phone});

  final String username;
  final String email;
  final String password;
  final String rol;
  final String city;
  final String address;
  final String zipCode;
  final String phone;

  Map<String, dynamic> toMap() {
    return {
      "name": username,
      "password": password,
      "email": email,
      "city": city,
      "address": address,
      "zipCode": zipCode,
      "phone": phone
    };
  }
}
