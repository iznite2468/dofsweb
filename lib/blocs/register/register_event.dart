part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

class RegisterUser extends RegisterEvent {
  final UserData userData;

  RegisterUser(this.userData);
}
