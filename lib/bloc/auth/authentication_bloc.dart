import 'package:afogata/domain/models/user_model.dart';
import 'package:afogata/resources/api_repository_implementation.dart';
import 'package:afogata/resources/local_repository_implementation.dart';
import 'package:bloc/bloc.dart';

import 'bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final ApiRepositoryImpl apiRepositoryImpl;
  final LocalRepositoryImpl localRepositoryImpl;

  UserModel get currentUser => (state as Authenticated).user;

  AuthenticationBloc(
      {required this.apiRepositoryImpl, required this.localRepositoryImpl})
      : super(Uninitialized());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    }
    if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    }
    if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    yield LogginOut();
    final token = await localRepositoryImpl.getToken();
    if (token != null) {
      await apiRepositoryImpl.logout(token);
    }
    await localRepositoryImpl.clearAllData();
    yield Unauthenticated();
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    var token = await localRepositoryImpl.getToken();
    print(token);
    var user;
    if (token != null) {
      user = await apiRepositoryImpl.getUserFromToken(token);
    }
    yield Authenticated(token!, user);
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    try {
      final token = await localRepositoryImpl.getToken();
      print('token ---> $token');
      if (token != null) {
        final user = await apiRepositoryImpl.getUserFromToken(token);
        print(user);
        yield Authenticated(token, user);
      } else {
        yield Unauthenticated();
      }
    } catch (_) {
      yield Unauthenticated();
    }
  }
}
