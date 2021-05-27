import 'package:afogata/registro/models/email.dart';
import 'package:afogata/registro/models/name.dart';
import 'package:afogata/registro/models/password.dart';

import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class RegisterState extends Equatable {
  const RegisterState({
    this.name = const Name.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
  });

  final Name name;
  final Email email;
  final Password password;
  final FormzStatus status;

  @override
  List<Object> get props => [name, email, password, status];

  RegisterState copyWith({
    Name? name,
    Email? email,
    Password? password,
    FormzStatus? status,
  }) {
    return RegisterState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }
}
