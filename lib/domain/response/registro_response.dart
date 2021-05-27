import 'package:afogata/domain/models/user_model.dart';

class RegistroResponse {
  RegistroResponse(this.token, this.user);

  final String token;
  final UserModel user;
}
