part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class SignEvent extends LoginEvent {
  final String username;
  final String password;

  SignEvent({this.username, this.password});
}

class SignupLaunchEvent extends LoginEvent {}
