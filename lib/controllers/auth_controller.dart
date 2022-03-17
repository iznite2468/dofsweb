import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:dofsweb/models/user_data.dart';
import 'package:dofsweb/models/user_preferences.dart';
import 'package:dofsweb/services/service_api.dart';
import 'package:dofsweb/services/user_session.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final _api = ServiceApi();
  final session = UserSession();

  //login
  final showPassword = false.obs;

  //signuo
  final showRPassword = false.obs;
  final showRConPass = false.obs;

  final signingIn = false.obs;
  final signingUp = false.obs;

  void signIn(String username, String password, BuildContext context) async {
    signingIn.value = true;
    final response = await _api.login(username: username, password: password);

    if (response.data['success']) {
      final data = UserPreferences.fromJson(response.data['payload']);
      session.setSession(data);

      signingIn.value = false;
      Get.offAllNamed('/home', arguments: data);
    } else {
      signingIn.value = false;
      FlushbarHelper.createError(
        message: response.data['message'].toString(),
      ).show(context);
    }
  }

  void signUp(UserData data, BuildContext context) async {
    signingUp.value = true;
    final response = await _api.register(data);

    if (response.data['success']) {
      signingUp.value = false;
      FlushbarHelper.createInformation(
        message: response.data['message'].toString(),
      ).show(context);
    } else {
      signingUp.value = false;
      FlushbarHelper.createError(
        message: response.data['message'].toString(),
      ).show(context);
    }
  }

  void signOut() async {
    session.clearSession();
    Get.offAllNamed('/splash');
  }
}
