import 'dart:convert';

import 'package:afogata/domain/exception/auth_exception.dart';
import 'package:afogata/domain/models/user_model.dart';
import 'package:afogata/domain/repository/api_repository.dart';
import 'package:afogata/domain/request/login_request.dart';
import 'package:afogata/domain/request/registro_request.dart';
import 'package:afogata/domain/response/login_response.dart';
import 'package:afogata/domain/response/registro_response.dart';
import 'package:dartz/dartz.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

import 'local_repository_implementation.dart';

class ApiRepositoryImpl extends ApiRepositoryInterface {
  static final _instance = ApiRepositoryImpl._internal();
  factory ApiRepositoryImpl() {
    return _instance;
  }
  ApiRepositoryImpl._internal();

  final _url = 'http://192.168.42.234:5000/api/v3';
  GoogleSignIn _googleSignIn = new GoogleSignIn();
  final LocalRepositoryImpl localRepositoryImpl = LocalRepositoryImpl();

  @override
  Future<UserModel> getUserFromToken(String token) async {
    await Future.delayed(const Duration(seconds: 2));
    final resp = await http.get(
      Uri.parse(_url + '/users/Me'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    Map<String, dynamic> decodedResp = json.decode(resp.body);
    print(decodedResp);

    if (decodedResp['status'] == 'success') {
      final user = UserModel.fromJson(decodedResp['data']);
      return user;
    }

    throw AuthException(message: 'error', ok: false);
  }

  @override
  Future<LoginResponse> signInWithCredentials(LoginRequest login) async {
    final authData = {
      'email': login.username,
      'password': login.password,
    };
    print(authData);
    final resp = await http.post(Uri.parse(_url + '/users/login'),
        headers: {
          "content-type": "application/json",
        },
        body: jsonEncode(authData));

    Map<String, dynamic> decodedResp = json.decode(resp.body);
    print(resp);
    if (decodedResp["status"] == 'success') {
      print(decodedResp['data']['user'].runtimeType);
      return LoginResponse(decodedResp['token'],
          UserModel.fromJson(decodedResp['data']['user']));
    }

    throw AuthException(message: 'error', ok: false);
  }

  // @override
  // Future<LoginResponse> signInWithCredentials(LoginRequest login) async {
  //   print(login);
  //   final authData = {
  //     'email': login.username,
  //     'password': login.password,
  //   };
  //   print(authData);
  //   // await Future.delayed(const Duration(seconds: 2));
  //   final resp = await http.post(Uri.parse(_url + '/users/login'),
  //       headers: {
  //         "content-type": "application/json",
  //       },
  //       body: jsonEncode(authData));

  //   Map<String, dynamic> decodedResp = json.decode(resp.body);

  //   print(decodedResp['data']);
  //   print(decodedResp['data']['user']);

  //   if (decodedResp['status'] == 'success') {
  //     // _prefs.token = decodedResp['token'];
  //     var x = decodedResp['data']['user'];
  //     print(x);
  //     var y = UserModel.fromJson(x);
  //     print(y);
  //     print(x['token']);

  //     return LoginResponse(decodedResp['token'],
  //         UserModel.fromJson(decodedResp['data']['user']));
  //   }

  //   throw AuthException(message: 'error', ok: false);
  // }

  @override
  Future<void> logout(String token) async {
    print('Removing user data : $token');
    final resp = await http.get(Uri.parse(_url + '/users/logout'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print(resp);
    return;
  }

  @override
  Future<void> updateUser(String token, String opcion, String campo) async {
    final authData = {
      opcion: campo,
    };
    print(authData);
    final resp = await http.patch(Uri.parse(_url + '/users/updateMe'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(authData));

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    print('decodedResp');
    print(decodedResp);
  }

  @override
  Future<RegistroResponse> registro(RegistroRequest registroRequest) async {
    final authData = {
      "name": registroRequest.username,
      "password": registroRequest.password,
      "email": registroRequest.email,
      "city": registroRequest.city,
      "address": registroRequest.address,
      "zipCode": registroRequest.zipCode,
      "phone": registroRequest.phone
    };
    print('authData ---> $authData');

    final resp = await http.post(Uri.parse(_url + '/users/signup'),
        headers: {
          "content-type": "application/json",
        },
        body: jsonEncode(authData));

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    print('resp ---> $decodedResp');
    if (decodedResp["status"] == 'success') {
      return RegistroResponse(decodedResp['token'],
          UserModel.fromJson(decodedResp['data']['user']));
    }

    throw AuthException(message: 'error', ok: false);
  }

  @override
  Future<Either<AuthException, GoogleSignInAuthentication>>
      signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      return left(AuthException(message: 'Sign in Failed', ok: false));
    }
    final googleAuthentication = await googleUser.authentication;
    return right(googleAuthentication);
  }
}
