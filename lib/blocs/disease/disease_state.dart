part of 'disease_bloc.dart';

@immutable
abstract class DiseaseState {}

class DiseaseInitial extends DiseaseState {}

class LoadingData extends DiseaseState {}

class DataLoaded extends DiseaseState {
  final List<Disease> diseases;

  DataLoaded(this.diseases);
}

class Error extends DiseaseState {
  final String message;

  Error(this.message);
}

class AddingDisease extends DiseaseState {}

class DiseaseAdded extends DiseaseState {
  final String message;

  DiseaseAdded(this.message);
}

class DeletingDisease extends DiseaseState {}

class DiseaseDeleted extends DiseaseState {
  final String message;

  DiseaseDeleted(this.message);
}

class UpdatingDisease extends DiseaseState {}

class DiseaseUpdated extends DiseaseState {
  final String message;

  DiseaseUpdated(this.message);
}
