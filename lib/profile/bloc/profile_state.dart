import 'package:afogata/domain/models/user_model.dart';
import 'package:equatable/equatable.dart';

class ProfileState {
  final UserModel user;

  ProfileState({required this.user});

  String get rol => user.role;

  ProfileState copyWith({
    UserModel? user,
    bool? isLogginOut,
    bool? isLoggedOut,
  }) {
    return ProfileState(
      user: user ?? this.user,
    );
  }
}

// class ProfileInitial extends ProfileState {}

// class IsLogginOut extends ProfileState {
//   @override
//   String toString() => 'Loggin Out...';
// }

// class IsLoggedOut extends ProfileState {
//   @override
//   String toString() => 'Log Out completed...';
// }
