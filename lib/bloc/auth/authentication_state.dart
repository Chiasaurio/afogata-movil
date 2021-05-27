import 'package:afogata/domain/models/user_model.dart';
import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
  @override
  List<Object> get props => [];
}

class Uninitialized extends AuthenticationState {
  @override
  String toString() => 'No inicializado';
}

class Authenticated extends AuthenticationState {
  final String token;
  final UserModel user;
  Authenticated(this.token, this.user);

  @override
  List<Object> get props => [token];

  @override
  String toString() => 'Autenticado - token :$token';
}

class Unauthenticated extends AuthenticationState {
  @override
  String toString() => 'No autenticado';
}

class LogginOut extends AuthenticationState {
  @override
  String toString() => 'Loggin out...';
}
