// import 'package:flutter/material.dart';

// import 'signin/sign_in_bloc.dart';

// class Provider extends InheritedWidget {
//   final _loginBloc = SignInBloc();
//   final _registroBloc = RegistroBloc();
//   Provider({Key key, Widget child}) : super(key: key, child: child);

//   @override
//   bool updateShouldNotify(InheritedWidget oldWidget) => true;

//   static SignInBloc loginBloc(BuildContext context) {
//     return (context.dependOnInheritedWidgetOfExactType<Provider>())._loginBloc;
//   }

//   static RegistroBloc registroBloc(BuildContext context) {
//     return (context.dependOnInheritedWidgetOfExactType<Provider>())
//         ._registroBloc;
//   }
// }
