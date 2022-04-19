import 'package:bloc/bloc.dart';
import 'package:dofsweb/models/remedy.dart';
import 'package:dofsweb/services/service_api.dart';
import 'package:meta/meta.dart';

part 'remedy_event.dart';
part 'remedy_state.dart';

class RemedyBloc extends Bloc<RemedyEvent, RemedyState> {
  final _api = ServiceApi();
  RemedyBloc() : super(RemedyInitial()) {
    on<RemedyEvent>((event, emit) async {
      if (event is LoadRemedies) {
        emit.call(LoadingRemedies());
        final response = await _api.getRemedies();
        if (response.data['success']) {
          final list = Remedy.fromList(response.data['payload']);
          emit.call(RemediesLoaded(list));
        } else {
          emit.call(Error(response.data.toString()));
        }
      }
      if (event is AddRemedy) {
        emit.call(AddingRemedy());
        final response = await _api.addRemedy(event.remedy);
        if (response.data['success']) {
          emit.call(RemedyAdded(response.data['message']));
        } else {
          emit.call(Error(response.data.toString()));
        }
      }
      if (event is UpdateRemedy) {
        emit.call(UpdatingRemedy());
        final response = await _api.updateRemedy(event.remedy);
        if (response.data['success']) {
          emit.call(RemedyUpdated(response.data['message']));
        } else {
          emit.call(Error(response.data.toString()));
        }
      }
      if (event is DeleteRemedy) {
        emit.call(DeletingRemedy());
        final response = await _api.deleteRemedy(event.remedyId);
        if (response.data['success']) {
          emit.call(RemedyDeleted(response.data['message']));
        } else {
          emit.call(Error(response.data.toString()));
        }
      }
    });
  }
}
