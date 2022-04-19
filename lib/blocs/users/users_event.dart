part of 'users_bloc.dart';

@immutable
abstract class UsersEvent {}

class LoadUsers extends UsersEvent {}

class UpdateUserInfo extends UsersEvent {
  final UserData userData;

  UpdateUserInfo(this.userData);
}

class UpdateStatus extends UsersEvent {
  final String status;
  final int userAccessId;

  UpdateStatus(this.status, this.userAccessId);
}

class UpdatePassword extends UsersEvent {
  final String newPassword;
  final int userAccessId;

  UpdatePassword(this.newPassword, this.userAccessId);
}
