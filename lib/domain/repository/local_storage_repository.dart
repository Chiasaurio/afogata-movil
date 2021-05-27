import 'package:afogata/domain/models/user_model.dart';

abstract class LocalRepositoryInterface {
  Future<String?> getToken();
  Future<void> clearAllData();
  Future<String?> getUsernamePreference();
  Future<UserModel> saveUser(UserModel user);
  Future<String> saveToken(String token);
}
