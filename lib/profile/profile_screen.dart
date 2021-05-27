import 'package:afogata/bloc/auth/bloc.dart';
import 'package:afogata/profile/components/body.dart';
import 'package:afogata/profile/profile_details.dart';
import 'package:afogata/resources/api_repository_implementation.dart';
import 'package:afogata/resources/local_repository_implementation.dart';

import 'package:afogata/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bloc.dart';

class ProfileScreen extends StatelessWidget {
  final ApiRepositoryImpl apiRepositoryImpl = ApiRepositoryImpl();
  final LocalRepositoryImpl localRepositoryImpl = LocalRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          actions: [
            IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamed(context, 'settings');
                // print('hola');
                // LocalRepositoryImpl().clearAllData();
              },
            ),
          ],
        ),
        body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is Authenticated) {
              print('user id ---> ${state.user.id}');
              return Body(
                user: state.user,
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ));
  }
}
