import 'package:afogata/domain/exception/auth_exception.dart';
import 'package:afogata/domain/models/user_model.dart';
import 'package:afogata/domain/request/login_request.dart';
import 'package:afogata/domain/request/registro_request.dart';
import 'package:afogata/domain/response/login_response.dart';
import 'package:afogata/domain/response/registro_response.dart';
import 'package:dartz/dartz.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class ApiRepositoryInterface {
  Future<UserModel> getUserFromToken(String token);
  Future<LoginResponse> signInWithCredentials(LoginRequest login);
  Future<Either<AuthException, GoogleSignInAuthentication>> signInWithGoogle();
  Future<RegistroResponse> registro(RegistroRequest registroRequest);
  Future<void> updateUser(String token, String campo, String opcion);
  Future<void> logout(String token);
}
