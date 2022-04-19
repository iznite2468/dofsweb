part of 'disease_bloc.dart';

@immutable
abstract class DiseaseEvent {}

class LoadDiseases extends DiseaseEvent {}

class AddDisease extends DiseaseEvent {
  final Disease disease;

  AddDisease(this.disease);
}

class DeleteDisease extends DiseaseEvent {
  final int diseaseId;

  DeleteDisease(this.diseaseId);
}

class UpdateDisease extends DiseaseEvent {
  final Disease disease;

  UpdateDisease(this.disease);
}
