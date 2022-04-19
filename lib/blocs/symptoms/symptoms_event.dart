part of 'symptoms_bloc.dart';

@immutable
abstract class SymptomsEvent {}

class LoadSymptoms extends SymptomsEvent {}

class AddSymptom extends SymptomsEvent {
  final Symptom symptom;

  AddSymptom(this.symptom);
}

class UpdateSymptom extends SymptomsEvent {
  final Symptom symptom;

  UpdateSymptom(this.symptom);
}

class DeleteSymptom extends SymptomsEvent {
  final int symptomId;

  DeleteSymptom(this.symptomId);
}
