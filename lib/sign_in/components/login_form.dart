import 'package:afogata/bloc/auth/bloc.dart';
import 'package:afogata/resources/api_repository_implementation.dart';
import 'package:afogata/resources/local_repository_implementation.dart';
import 'package:afogata/sign_in/bloc/bloc.dart';
import 'package:afogata/widgets/afogata_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';

class SignInForm extends StatefulWidget {
  final ApiRepositoryImpl apiRepositoryImpl;
  final LocalRepositoryImpl localRepositoryImpl;

  SignInForm(
      {Key? key,
      required this.apiRepositoryImpl,
      required this.localRepositoryImpl})
      : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late SignInBloc _signInBloc;

  ApiRepositoryImpl get apiRepositoryImpl => widget.apiRepositoryImpl;
  LocalRepositoryImpl get localRepositoryImpl => widget.localRepositoryImpl;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isLoginButtonEnabled(SignInState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _signInBloc = BlocProvider.of<SignInBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('Login Failure'), Icon(Icons.error)],
              ),
              backgroundColor: Colors.red,
            ));
        }
        if (state.isSubmitting) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('Loggin in...'), CircularProgressIndicator()],
              ),
            ));
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
          Navigator.of(context).pushReplacementNamed('home');
        }
      },
      child: _loginForm(context),
    );
  }

  Widget _loginForm(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<SignInBloc, SignInState>(
      builder: (context, state) {
        return Form(
          child: Column(
            children: <Widget>[
              SafeArea(
                child: Container(
                  height: 60.0,
                ),
              ),
              Container(
                width: size.width,
                margin: EdgeInsets.symmetric(vertical: 30.0),
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    _crearEmail(state),
                    SizedBox(height: 30.0),
                    _crearPassword(state),
                    SizedBox(height: 30.0),
                    _loginWithCredentials(state),
                    _loginWithGoogle(state, context)
                  ],
                ),
              ),
              TextButton(
                child: Text('Crear una nueva cuenta'),
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, 'opcionesregistro'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Checkbox(
                          value: false,
                          onChanged: (value) {
                            // controller.recordarme.value = value;
                          }),
                      TextButton(child: Text('Recordarme'), onPressed: () {}
                          // Navigator.pushReplacementNamed(context, 'registro'),
                          ),
                    ],
                  ),
                  TextButton(
                    child: Text('¿Olvidaste la contraseña?'),
                    onPressed: () =>
                        Navigator.pushReplacementNamed(context, 'registro'),
                  ),
                ],
              ),
              SizedBox(height: 100.0)
            ],
          ),
        );
      },
    );
  }

  Widget _crearEmail(SignInState state) {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      autovalidateMode: AutovalidateMode.always,
      autocorrect: false,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        border: InputBorder.none,
        prefixIcon: Icon(Icons.person, color: Colors.black),
        hintText: 'ejemplo@correo.com',
        labelText: 'Correo electrónico',
      ),
      validator: (_) {
        return !state.isEmailValid ? 'Invalid Email' : null;
      },
    );
  }

  Widget _crearPassword(SignInState state) {
    return TextFormField(
      controller: _passwordController,
      obscureText: true,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        border: InputBorder.none,
        prefixIcon: Icon(Icons.lock_outline, color: Colors.black),
        labelText: 'Contraseña',
      ),
      validator: (_) {
        return !state.isPasswordValid ? 'Invalid Password' : null;
      },
    );
  }

  Widget _loginWithCredentials(SignInState state) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Row(
        children: [
          Expanded(
            child: AfogataButton(
              text: 'INICIAR SESIÓN',
              // onTap: () {
              //   localRepositoryImpl.clearAllData();
              // }
              onTap: isLoginButtonEnabled(state) ? _onFormSubmitted : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _loginWithGoogle(SignInState sate, BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SignInButton(Buttons.Google, onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Loggin in...'),
                CircularProgressIndicator(),
              ],
            )));
            BlocProvider.of<SignInBloc>(context).add(SignInWithGoogle());
          })
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onFormSubmitted() {
    _signInBloc.add(SignInWithEmailAndPassword(
        email: _emailController.text, password: _passwordController.text));
  }

  void _onEmailChanged() {
    _signInBloc.add(EmailChanged(email: _emailController.text));
  }

  void _onPasswordChanged() {
    _signInBloc.add(PasswordChanged(password: _passwordController.text));
  }
}

class GoogleAuthButton {}
