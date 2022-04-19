part of 'symptoms_bloc.dart';

@immutable
abstract class SymptomsState {}

class SymptomsInitial extends SymptomsState {}

class LoadingSymptoms extends SymptomsState {}

class SymptomsLoaded extends SymptomsState {
  final List<Symptom> symptoms;

  SymptomsLoaded(this.symptoms);
}

class AddingSymptom extends SymptomsState {}

class SymptomAdded extends SymptomsState {
  final String message;

  SymptomAdded(this.message);
}

class UpdatingSymptom extends SymptomsState {}

class SymptomUpdated extends SymptomsState {
  final String message;

  SymptomUpdated(this.message);
}

class DeletingSymptom extends SymptomsState {}

class SymptomDeleted extends SymptomsState {
  final String message;

  SymptomDeleted(this.message);
}

class Error extends SymptomsState {
  final String message;

  Error(this.message);
}
