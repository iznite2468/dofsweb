part of 'splash_bloc.dart';

@immutable
abstract class SplashState {}

class SplashInitial extends SplashState {}

class LoggedIn extends SplashState {
  final UserPreferences userPreferences;

  LoggedIn(this.userPreferences);
}

class NotLoggedIn extends SplashState {}
