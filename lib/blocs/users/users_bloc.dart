import 'package:bloc/bloc.dart';
import 'package:dofsweb/models/user_data.dart';
import 'package:dofsweb/models/user_info.dart';
import 'package:dofsweb/services/service_api.dart';
import 'package:meta/meta.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final _api = ServiceApi();
  UsersBloc() : super(UsersInitial()) {
    on<UsersEvent>((event, emit) async {
      if (event is LoadUsers) {
        emit.call(LoadingData());
        final response = await _api.getUsers();
        if (response.data['success']) {
          final users = UserInfo.fromList(response.data['payload']);
          emit.call(DataLoaded(users));
        } else {
          emit.call(Error(response.data.toString()));
        }
      }
      if (event is UpdateUserInfo) {
        emit.call(UpdatingUserInfo());
        final response = await _api.updateUserInfo(event.userData);
        if (response.data['success']) {
          emit.call(UserInfoUpdated(response.data['message']));
        } else {
          emit.call(Error(response.data['message']));
        }
      }
      if (event is UpdateStatus) {
        emit.call(UpdatingStatus());
        final response = await _api.updateAccountStatus(
          event.status,
          event.userAccessId,
        );
        if (response.data['success']) {
          emit.call(StatusUpdated(response.data['message']));
        } else {
          emit.call(Error(response.data['message']));
        }
      }
      if (event is UpdatePassword) {
        emit.call(UpdatingPassword());
        final response = await _api.updatePassword(
          event.newPassword,
          event.userAccessId,
        );

        if (response.data['success']) {
          emit.call(PasswordUpdated(response.data['message']));
        } else {
          emit.call(Error(response.data['message']));
        }
      }
    });
  }
}
