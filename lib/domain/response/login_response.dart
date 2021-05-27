import 'package:afogata/domain/models/user_model.dart';

class LoginResponse {
  LoginResponse(this.token, this.user);

  final String token;
  final UserModel user;
}
