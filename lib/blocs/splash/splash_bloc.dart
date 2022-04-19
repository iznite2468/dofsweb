import 'package:bloc/bloc.dart';
import 'package:dofsweb/models/user_preferences.dart';
import 'package:dofsweb/services/user_session.dart';
import 'package:meta/meta.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final _userSession = UserSession();
  SplashBloc() : super(SplashInitial()) {
    on<SplashEvent>((event, emit) async {
      if (event is CheckUser) {
        final _session = await _userSession.getSession();
        if (_session != null) {
          emit.call(LoggedIn(_session));
        } else {
          emit.call(NotLoggedIn());
        }
      }
    });
  }
}
