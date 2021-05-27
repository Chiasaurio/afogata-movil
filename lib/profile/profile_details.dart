import 'package:afogata/bloc/auth/authentication_bloc.dart';
import 'package:afogata/bloc/auth/authentication_event.dart';
import 'package:afogata/bloc/auth/authentication_state.dart';
import 'package:afogata/domain/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bloc.dart';

class ProfileDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
      if (state is LogginOut) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('Loggin out...'), CircularProgressIndicator()],
            ),
            backgroundColor: Colors.red,
          ));
      }
      if (state is Unauthenticated) {
        Navigator.of(context).pushReplacementNamed('login');
      }
    }, child: BlocBuilder<ProfileBloc, ProfileState>(
            // bloc: BlocProvider.of<AuthenticationBloc>(context),
            builder: (context, state) {
      return ConstrainedBox(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(state.user.name),
          Center(
              child: ElevatedButton(
                  onPressed: () {
                    _logOut(context);
                  },
                  child: Text('Log Out')))
        ]),
      );
    }));
  }

  void _logOut(BuildContext context) {
    final AuthenticationBloc _authBloc =
        BlocProvider.of<AuthenticationBloc>(context);
    _authBloc.add(LoggedOut());
    // Scaffold
  }
}
