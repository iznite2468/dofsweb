import 'package:bloc/bloc.dart';
import 'package:dofsweb/models/pivot_by_disease.dart';
import 'package:dofsweb/models/pivot_result.dart';
import 'package:dofsweb/services/service_api.dart';
import 'package:dofsweb/services/user_session.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final _api = ServiceApi();
  final _userSession = UserSession();
  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async {
      if (event is LogoutUser) {
        emit.call(SigningOut());
        await _userSession.clearSession();
        emit.call(SignedOut());
      }
      if (event is LoadPivotResult) {
        emit.call(LoadingPivotResult());
        //final response = await _api.getPivots();
        final response = await _api.getPivotByDisease(event.disease);
        if (response.data['success']) {
          //final list = PivotResult.fromList(response.data['payload']);
          final list = PivotByDisease.fromList(response.data['payload']);
          list.sort((a, b) => a.weeks!.compareTo(b.weeks!));

          emit.call(PivotResultLoaded(list));
        } else {
          emit.call(Error(response.data['message']));
        }
      }
    });
  }
}
