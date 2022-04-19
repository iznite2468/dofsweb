import 'package:bloc/bloc.dart';
import 'package:dofsweb/models/user_preferences.dart';
import 'package:dofsweb/services/service_api.dart';
import 'package:dofsweb/services/user_session.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final _api = ServiceApi();
  final _userSession = UserSession();
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is LoginUser) {
        emit.call(LoggingIn());
        final response = await _api.login(
          username: event.username,
          password: event.password,
        );

        if (response.data['success']) {
          final user = UserPreferences.fromJson(response.data['payload']);
          _userSession.setSession(user);
          emit.call(HasUser(user));
        } else {
          emit.call(NoUser(response.data['message'].toString()));
        }
      }
    });
  }
}
