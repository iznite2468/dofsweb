part of 'patient_case_bloc.dart';

@immutable
abstract class PatientCaseEvent {}

class LoadPatientCases extends PatientCaseEvent {}

class UpdatePatientCase extends PatientCaseEvent {
  final PatientCaseData data;

  UpdatePatientCase(this.data);
}

class DeletePatientCase extends PatientCaseEvent {
  final int formId;

  DeletePatientCase(this.formId);
}

class LoadPatientInfo extends PatientCaseEvent {}

class AddPatientCases extends PatientCaseEvent {
  final List<PatientCaseData> data;

  AddPatientCases(this.data);
}

class AddPatients extends PatientCaseEvent {
  final List<PatientInfoData> data;

  AddPatients(this.data);
}
