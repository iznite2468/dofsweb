import 'package:bloc/bloc.dart';
import 'package:dofsweb/models/symptom.dart';
import 'package:dofsweb/services/service_api.dart';
import 'package:meta/meta.dart';

part 'symptoms_event.dart';
part 'symptoms_state.dart';

class SymptomsBloc extends Bloc<SymptomsEvent, SymptomsState> {
  final _api = ServiceApi();
  SymptomsBloc() : super(SymptomsInitial()) {
    on<SymptomsEvent>((event, emit) async {
      if (event is LoadSymptoms) {
        emit.call(LoadingSymptoms());
        final response = await _api.getSymptoms();
        if (response.data['success']) {
          final list = Symptom.fromList(response.data['payload']);
          emit.call(SymptomsLoaded(list));
        } else {
          emit.call(Error(response.data.toString()));
        }
      }
      if (event is AddSymptom) {
        emit.call(AddingSymptom());
        final response = await _api.addSymptom(event.symptom);
        if (response.data['success']) {
          emit.call(SymptomAdded(response.data['message']));
        } else {
          emit.call(Error(response.data.toString()));
        }
      }
      if (event is UpdateSymptom) {
        emit.call(UpdatingSymptom());
        final response = await _api.updateSymptom(event.symptom);
        if (response.data['success']) {
          emit.call(SymptomUpdated(response.data['message']));
        } else {
          emit.call(Error(response.data.toString()));
        }
      }
      if (event is DeleteSymptom) {
        emit.call(DeletingSymptom());
        final response = await _api.deleteSymptom(event.symptomId);
        if (response.data['success']) {
          emit.call(SymptomDeleted(response.data['message']));
        } else {
          emit.call(Error(response.data.toString()));
        }
      }
    });
  }
}
