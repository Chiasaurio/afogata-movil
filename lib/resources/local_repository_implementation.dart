import 'package:afogata/domain/models/user_model.dart';
import 'package:afogata/domain/repository/local_storage_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _prefs_token = 'TOKEN';
const _prefs_username = 'USERNAME';
const _prefs_rol = 'ROL';
// const _prefs_rol = 'ROL';

class LocalRepositoryImpl extends LocalRepositoryInterface {
  static final _instance = LocalRepositoryImpl._internal();
  factory LocalRepositoryImpl() {
    return _instance;
  }
  LocalRepositoryImpl._internal();

  @override
  Future<void> clearAllData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }

  @override
  Future<String?> getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(_prefs_token);
  }

  Future<UserModel> saveUser(UserModel user) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(_prefs_username, user.email);
    sharedPreferences.setString(_prefs_rol, user.role);
    // sharedPreferences.setInt(_prefs_id, user.id);
    // sharedPreferences.setString(_prefs_city, user.city);
    return user;
  }

  @override
  Future<String?> getUsernamePreference() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? name = sharedPreferences.getString(_prefs_username);
    return name;
  }

  @override
  Future<String> saveToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(_prefs_token, token);
    return token;
  }
}
