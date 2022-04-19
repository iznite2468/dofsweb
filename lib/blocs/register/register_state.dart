part of 'register_bloc.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class SigningUp extends RegisterState {}

class Success extends RegisterState {
  final String message;

  Success(this.message);
}

class Error extends RegisterState {
  final String message;

  Error(this.message);
}
