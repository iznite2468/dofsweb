import 'package:bloc/bloc.dart';
import 'package:dofsweb/models/patient_case.dart';
import 'package:dofsweb/models/patient_case_data.dart';
import 'package:dofsweb/models/patient_info.dart';
import 'package:dofsweb/models/patient_info_data.dart';
import 'package:dofsweb/services/service_api.dart';
import 'package:meta/meta.dart';

part 'patient_case_event.dart';
part 'patient_case_state.dart';

class PatientCaseBloc extends Bloc<PatientCaseEvent, PatientCaseState> {
  final _api = ServiceApi();
  PatientCaseBloc() : super(PatientCaseInitial()) {
    on<LoadPatientCases>(_onLoadPatientCases);
    on<LoadPatientInfo>(_onLoadPatientInfo);
    on<UpdatePatientCase>(_onUpdatePatientCase);
    on<DeletePatientCase>(_onDeletePatientCase);
    on<AddPatientCases>(_onAddPatientCases);
    on<AddPatients>(_onAddPatients);
  }

  void _onLoadPatientCases(
    LoadPatientCases event,
    Emitter<PatientCaseState> emit,
  ) async {
    emit.call(LoadingData());
    final response = await _api.getPatientCases();
    if (response.data['success']) {
      final cases = PatientCase.fromList(response.data['payload']);
      cases.sort((a, b) => b.formId!.compareTo(a.formId!));
      emit.call(DataLoaded(cases));
    } else {
      emit.call(Error(response.data.toString()));
    }
  }

  void _onLoadPatientInfo(
    LoadPatientInfo event,
    Emitter<PatientCaseState> emit,
  ) async {
    emit.call(LoadingPatientInfo());
    final response = await _api.getPatients();
    if (response.data['success']) {
      final patients = PatientInfo.fromList(response.data['payload']);
      emit.call(PatientInfoLoaded(patients));
    } else {
      emit.call(Error(response.data['message']));
    }
  }

  void _onUpdatePatientCase(
    UpdatePatientCase event,
    Emitter<PatientCaseState> emit,
  ) async {
    emit.call(UpdatingPatientCase());
    final response = await _api.updatePatientCase(event.data);
    if (response.data['success']) {
      emit.call(PatientCaseUpdated(response.data['message']));
    } else {
      emit.call(Error(response.data.toString()));
    }
  }

  void _onDeletePatientCase(
    DeletePatientCase event,
    Emitter<PatientCaseState> emit,
  ) async {
    emit.call(DeletingPatientCase());
    final response = await _api.archivePatientCase(event.formId);
    if (response.data['success']) {
      emit.call(PatientCaseDeleted(response.data['message']));
    } else {
      emit.call(Error(response.data.toString()));
    }
  }

  void _onAddPatientCases(
    AddPatientCases event,
    Emitter<PatientCaseState> emit,
  ) async {
    emit.call(AddingPatientCases('Adding Patient Cases...'));
    try {
      for (var i = 0; i < event.data.length; i++) {
        final response = await _api.addPatientCase(event.data[i]);
        if (i == event.data.length - 1 && response.data['success']) {
          emit.call(PatientCasesAdded('Patient Cases has been Added'));
        }
        if (!response.data['success']) {
          emit.call(Error('Error Adding the ${i + 1} element'));
        }
      }
    } catch (e) {
      emit.call(Error(e.toString()));
    }
  }

  void _onAddPatients(
    AddPatients event,
    Emitter<PatientCaseState> emit,
  ) async {
    emit.call(AddingPatients('Adding Patients...'));
    try {
      for (var i = 0; i < event.data.length; i++) {
        final response = await _api.addPatient(event.data[i]);
        if (i == event.data.length - 1 && response.data['success']) {
          emit.call(PatientCasesAdded('Patient Cases has been Added'));
        }
        if (!response.data['success']) {
          emit.call(Error('Error Adding the ${i + 1} element'));
        }
      }
    } catch (e) {
      emit.call(Error(e.toString()));
    }
  }
}
