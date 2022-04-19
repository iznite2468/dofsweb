import 'package:bloc/bloc.dart';
import 'package:dofsweb/models/patient_case.dart';
import 'package:dofsweb/models/patient_case_data.dart';
import 'package:dofsweb/models/patient_info.dart';
import 'package:dofsweb/services/service_api.dart';
import 'package:meta/meta.dart';

part 'patient_case_event.dart';
part 'patient_case_state.dart';

class PatientCaseBloc extends Bloc<PatientCaseEvent, PatientCaseState> {
  final _api = ServiceApi();
  PatientCaseBloc() : super(PatientCaseInitial()) {
    on<PatientCaseEvent>((event, emit) async {
      if (event is LoadPatientCases) {
        emit.call(LoadingData());
        final response = await _api.getPatientCases();
        if (response.data['success']) {
          final cases = PatientCase.fromList(response.data['payload']);
          cases.sort((a,b) => b.formId!.compareTo(a.formId!));
          emit.call(DataLoaded(cases));
        } else {
          emit.call(Error(response.data.toString()));
        }
      }
      if (event is LoadPatientInfo) {
        emit.call(LoadingPatientInfo());
        final response = await _api.getPatients();
        if (response.data['success']) {
          final patients = PatientInfo.fromList(response.data['payload']);
          emit.call(PatientInfoLoaded(patients));
        } else {
          emit.call(Error(response.data['message']));
        }
      }
      if (event is UpdatePatientCase) {
        emit.call(UpdatingPatientCase());
        final response = await _api.updatePatientCase(event.data);
        if (response.data['success']) {
          emit.call(PatientCaseUpdated(response.data['message']));
        } else {
          emit.call(Error(response.data.toString()));
        }
      }
      if (event is DeletePatientCase) {
        emit.call(DeletingPatientCase());
        final response = await _api.archivePatientCase(event.formId);
        if (response.data['success']) {
          emit.call(PatientCaseDeleted(response.data['message']));
        } else {
          emit.call(Error(response.data.toString()));
        }
      }
    });
  }
}
