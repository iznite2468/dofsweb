import 'package:bloc/bloc.dart';
import 'package:dofsweb/models/pivot_by_disease.dart';
import 'package:dofsweb/services/service_api.dart';
import 'package:dofsweb/services/user_session.dart';
import 'package:flutter/material.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final _api = ServiceApi();
  final _userSession = UserSession();
  HomeBloc() : super(HomeInitial()) {
    on<LogoutUser>(_onLogoutUser);
    on<LoadPivotResult>(_onLoadPivotResult);
  }

  _onLogoutUser(LogoutUser event, Emitter<HomeState> emit) async {
    emit.call(SigningOut());
    await _userSession.clearSession();
    emit.call(SignedOut());
  }

  _onLoadPivotResult(LoadPivotResult event, Emitter<HomeState> emit) async {
    emit.call(LoadingPivotResult());
    try {
      final response = await _api.getPivotByDisease(event.disease);
      if (response.data['success']) {
        final list = PivotByDisease.fromList(response.data['payload']);
        list.sort((a, b) => a.weeks!.compareTo(b.weeks!));

        emit.call(PivotResultLoaded(event.disease, list));
      } else {
        emit.call(Error(response.data['message']));
      }
    } catch (e) {
      emit.call(Error(e.toString()));
    }
  }
}
