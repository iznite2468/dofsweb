part of 'users_bloc.dart';

@immutable
abstract class UsersState {}

class UsersInitial extends UsersState {}

class LoadingData extends UsersState {}

class DataLoaded extends UsersState {
  final List<UserInfo> users;

  DataLoaded(this.users);
}

class Error extends UsersState {
  final String message;

  Error(this.message);
}

class UpdatingUserInfo extends UsersState {}

class UserInfoUpdated extends UsersState {
  final String message;

  UserInfoUpdated(this.message);
}

class UpdatingStatus extends UsersState {}

class StatusUpdated extends UsersState {
  final String message;

  StatusUpdated(this.message);
}

class UpdatingPassword extends UsersState {}

class PasswordUpdated extends UsersState {
  final String message;

  PasswordUpdated(this.message);
}
