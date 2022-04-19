part of 'remedy_bloc.dart';

@immutable
abstract class RemedyState {}

class RemedyInitial extends RemedyState {}

class LoadingRemedies extends RemedyState {}

class RemediesLoaded extends RemedyState {
  final List<Remedy> remedies;

  RemediesLoaded(this.remedies);
}

class AddingRemedy extends RemedyState {}

class RemedyAdded extends RemedyState {
  final String message;

  RemedyAdded(this.message);
}

class UpdatingRemedy extends RemedyState {}

class RemedyUpdated extends RemedyState {
  final String message;

  RemedyUpdated(this.message);
}

class DeletingRemedy extends RemedyState {}

class RemedyDeleted extends RemedyState {
  final String message;

  RemedyDeleted(this.message);
}

class Error extends RemedyState {
  final String message;

  Error(this.message);
}
