import 'package:bloc/bloc.dart';
import 'package:dofsweb/models/user_data.dart';
import 'package:dofsweb/services/service_api.dart';
import 'package:meta/meta.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final _api = ServiceApi();
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterEvent>((event, emit) async {
      if (event is RegisterUser) {
        emit.call(SigningUp());
        final response = await _api.register(event.userData);

        if (response.data['success']) {
          emit.call(Success(response.data['message'].toString()));
        } else {
          emit.call(Error(response.data['message'].toString()));
        }
      }
    });
  }
}
