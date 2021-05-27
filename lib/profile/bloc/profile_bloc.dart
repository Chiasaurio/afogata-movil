import 'dart:async';

import 'package:afogata/resources/api_repository_implementation.dart';
import 'package:afogata/resources/local_repository_implementation.dart';
import 'package:bloc/bloc.dart';

import 'bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ApiRepositoryImpl apiRepositoryImpl;
  final LocalRepositoryImpl localRepositoryImpl;

  ProfileBloc(
      {required this.apiRepositoryImpl,
      required this.localRepositoryImpl,
      required user})
      : super(ProfileState(user: user));

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {}

  // Stream<ProfileState> _mapLogOutToState() async* {
  //   yield IsLogginOut();
  //   final token = await localRepositoryImpl.getToken();
  //   if (token != null) {
  //     await apiRepositoryImpl.logout(token);
  //   }
  //   await localRepositoryImpl.clearAllData();
  //   yield IsLoggedOut();
  // }
}
