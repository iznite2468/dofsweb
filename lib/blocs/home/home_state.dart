part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class SigningOut extends HomeState {}

class SignedOut extends HomeState {}

class LoadingPivotResult extends HomeState {}

class PivotResultLoaded extends HomeState {
  //final List<PivotResult> pivotResult;
  final String diseaseType;
  final List<PivotByDisease> pivotResult;

  PivotResultLoaded(this.diseaseType, this.pivotResult);
}

class Error extends HomeState {
  final String message;

  Error(this.message);
}
