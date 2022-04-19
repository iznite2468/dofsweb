part of 'patient_case_bloc.dart';

@immutable
abstract class PatientCaseState {}

class PatientCaseInitial extends PatientCaseState {}

class LoadingData extends PatientCaseState {}

class DataLoaded extends PatientCaseState {
  final List<PatientCase> patientCase;

  DataLoaded(this.patientCase);
}

class Error extends PatientCaseState {
  final String message;

  Error(this.message);
}

class UpdatingPatientCase extends PatientCaseState {}

class PatientCaseUpdated extends PatientCaseState {
  final String message;

  PatientCaseUpdated(this.message);
}

class DeletingPatientCase extends PatientCaseState {}

class PatientCaseDeleted extends PatientCaseState {
  final String message;

  PatientCaseDeleted(this.message);
}

class LoadingPatientInfo extends PatientCaseState {}

class PatientInfoLoaded extends PatientCaseState {
  final List<PatientInfo> patients;

  PatientInfoLoaded(this.patients);
}
