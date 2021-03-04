part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class InitialState extends LoginState {}

class LoadingState extends LoginState {}

class FailState extends LoginState {
  final String message;

  FailState({this.message});
}
