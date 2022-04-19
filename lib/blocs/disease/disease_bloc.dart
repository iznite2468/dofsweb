import 'package:bloc/bloc.dart';
import 'package:dofsweb/models/disease.dart';
import 'package:dofsweb/services/service_api.dart';
import 'package:meta/meta.dart';

part 'disease_event.dart';
part 'disease_state.dart';

class DiseaseBloc extends Bloc<DiseaseEvent, DiseaseState> {
  final _api = ServiceApi();
  DiseaseBloc() : super(DiseaseInitial()) {
    on<DiseaseEvent>((event, emit) async {
      if (event is LoadDiseases) {
        emit.call(LoadingData());
        final response = await _api.getDiseases();
        if (response.data['success']) {
          final diseases = Disease.fromList(response.data['payload']);
          emit.call(DataLoaded(diseases));
        } else {
          emit.call(Error(response.data.toString()));
        }
      }
      if (event is AddDisease) {
        emit.call(AddingDisease());
        final response = await _api.addDisease(event.disease);
        if (response.data['success']) {
          emit.call(DiseaseAdded(response.data['message']));
        } else {
          emit.call(Error(response.data['message']));
        }
      }
      if (event is DeleteDisease) {
        emit.call(DeletingDisease());
        final response = await _api.archiveDisease(event.diseaseId);
        if (response.data['success']) {
          emit.call(DiseaseDeleted(response.data['message']));
        } else {
          emit.call(Error(response.data['message']));
        }
      }
      if (event is UpdateDisease) {
        emit.call(UpdatingDisease());
        final response = await _api.updateDisease(event.disease);
        if (response.data['success']) {
          emit.call(DiseaseUpdated(response.data['message']));
        } else {
          emit.call(Error(response.data['message']));
        }
      }
    });
  }
}
