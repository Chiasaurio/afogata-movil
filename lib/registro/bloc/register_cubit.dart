import 'dart:async';
import 'package:afogata/domain/request/registro_request.dart';
import 'package:afogata/domain/response/registro_response.dart';
import 'package:afogata/registro/bloc/register_state.dart';
import 'package:afogata/registro/models/email.dart';
import 'package:afogata/registro/models/name.dart';
import 'package:afogata/registro/models/password.dart';
import 'package:afogata/resources/api_repository_implementation.dart';
import 'package:afogata/resources/local_repository_implementation.dart';
import 'package:bloc/bloc.dart';

import 'package:formz/formz.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this._apiRepository, this._localRepository)
      : assert(_apiRepository != null),
        super(const RegisterState());

  final ApiRepositoryImpl _apiRepository;
  final LocalRepositoryImpl _localRepository;

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([state.name, email, state.password]),
    ));
  }

  void nameChanged(String value) {
    final name = Name.dirty(value);
    emit(state.copyWith(
      name: name,
      status: Formz.validate([name, state.email, state.password]),
    ));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([state.name, state.email, password]),
    ));
  }

  Future<void> signUpFormSubmitted(
      String city, String address, String zipCode, String phone) async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      final RegistroResponse registroResponse =
          await _apiRepository.registro(RegistroRequest(
        username: state.name.value,
        email: state.email.value,
        password: state.password.value,
        rol: 'users',
        city: city,
        address: address,
        zipCode: zipCode,
        phone: phone,
      ));

      print('registro response');
      print(registroResponse);
      await _localRepository.saveToken(registroResponse.token);
      await _localRepository.saveUser(registroResponse.user);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
