part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginUser extends LoginEvent {
  final String username;
  final String password;

  LoginUser(this.username, this.password);
}
