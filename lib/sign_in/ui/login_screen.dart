import 'package:afogata/resources/api_repository_implementation.dart';
import 'package:afogata/resources/local_repository_implementation.dart';
import 'package:afogata/sign_in/bloc/bloc.dart';
import 'package:afogata/sign_in/components/login_form.dart';

import 'package:afogata/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  final ApiRepositoryImpl apiRepositoryImpl;
  final LocalRepositoryImpl localRepositoryImpl;

  LoginScreen(
      {Key? key,
      required this.apiRepositoryImpl,
      required this.localRepositoryImpl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: DeliveryColors.grey,
        body: BlocProvider<SignInBloc>(
          create: (context) => SignInBloc(
              apiRepositoryImpl: apiRepositoryImpl,
              localRepositoryImpl: localRepositoryImpl),
          child: SingleChildScrollView(
            child: SignInForm(
              apiRepositoryImpl: apiRepositoryImpl,
              localRepositoryImpl: localRepositoryImpl,
            ),
          ),
        ));
  }
}
