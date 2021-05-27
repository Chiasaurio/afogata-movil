import 'package:afogata/resources/api_repository_implementation.dart';
import 'package:afogata/resources/local_repository_implementation.dart';
import 'package:afogata/sign_in/bloc/bloc.dart';
import 'package:afogata/bloc/utils/validators.dart';
import 'package:afogata/domain/request/login_request.dart';
import 'package:afogata/domain/response/login_response.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final ApiRepositoryImpl apiRepositoryImpl;
  final LocalRepositoryImpl localRepositoryImpl;

  SignInBloc(
      {required this.apiRepositoryImpl, required this.localRepositoryImpl})
      : super(SignInState.empty());

  @override
  Stream<SignInState> mapEventToState(SignInEvent event) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    }
    if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    }
    if (event is SignInWithGoogle) {
      yield* _mapSignInWithGoogle();
    }
    if (event is SignInWithEmailAndPassword) {
      yield* _mapSignInWithEmailAndPassword(
          email: event.email, password: event.password);
    }
  }

  Stream<SignInState> _mapEmailChangedToState(String email) async* {
    yield state.update(isEmailValid: Validators.isValidEmail(email));
  }

  Stream<SignInState> _mapPasswordChangedToState(String password) async* {
    yield state.update(isPasswordValid: Validators.isValidPassword(password));
  }

  Stream<SignInState> _mapSignInWithGoogle() async* {
    try {
      await apiRepositoryImpl.signInWithGoogle();
      yield SignInState.success();
    } catch (_) {
      yield SignInState.failure();
    }
  }

  Stream<SignInState> _mapSignInWithEmailAndPassword(
      {required String email, required String password}) async* {
    yield SignInState.loading();
    try {
      LoginResponse response = await apiRepositoryImpl
          .signInWithCredentials(new LoginRequest(email, password));
      await localRepositoryImpl.saveToken(response.token);
      await localRepositoryImpl.saveUser(response.user);
      print('login response --> $response');
      yield SignInState.success();
    } catch (_) {
      yield SignInState.failure();
    }
  }
}

// import 'dart:async';
// import 'package:afogata/bloc/signin/sign_in_event.dart';
// import 'package:rxdart/rxdart.dart';

// import '../utils/validators.dart';

// class SignInBloc with Validators {
//   final _emailController = BehaviorSubject<String>();
//   final _passwordController = BehaviorSubject<String>();
//   final _rolController = BehaviorSubject<String>();

//   final _signInController = StreamController<SignInEvent>();
//   Sink<SignInEvent> get signInEventSink => _signInController.sink;

//   SignInBloc() {
//     _signInController.stream.listen(_mapEventToState);
//   }

//   void _mapEventToState(SignInEvent event) {
//     if (event is SignInWithEmailAndPassword) {}
//   }

//   // Recuperar los datos del Stream
//   Stream<String> get emailStream =>
//       _emailController.stream.transform(validarEmail);
//   Stream<String> get passwordStream =>
//       _passwordController.stream.transform(validarPassword);

//   Stream<bool> get formValidStream =>
//       Rx.combineLatest2(emailStream, passwordStream, (e, p) => true);

//   // Insertar valores al Stream
//   Function(String) get changeEmail => _emailController.sink.add;
//   Function(String) get changePassword => _passwordController.sink.add;

//   // Obtener el último valor ingresado a los streams
//   String get email => _emailController.value;
//   String get password => _passwordController.value;
//   String get rol => _rolController.value;

//   dispose() {
//     _emailController?.close();
//     _passwordController?.close();
//     _signInController?.close();
//     _rolController?.close();
//   }
// }
