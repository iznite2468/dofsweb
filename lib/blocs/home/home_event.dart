part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class LogoutUser extends HomeEvent {}

class LoadPivotResult extends HomeEvent {
  final String disease;

  LoadPivotResult(this.disease);
}
