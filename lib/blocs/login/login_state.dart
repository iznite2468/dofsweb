part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoggingIn extends LoginState {}

class HasUser extends LoginState {
  final UserPreferences data;

  HasUser(this.data);
}

class NoUser extends LoginState {
  final String message;

  NoUser(this.message);
}
