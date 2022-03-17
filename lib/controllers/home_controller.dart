import 'package:another_flushbar/flushbar_helper.dart';
import 'package:dofsweb/models/disease.dart';
import 'package:dofsweb/models/patient_case.dart';
import 'package:dofsweb/models/user_data.dart';
import 'package:dofsweb/models/user_info.dart';
import 'package:dofsweb/services/service_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final _api = ServiceApi();

  final loadingUsers = false.obs;
  final users = <UserInfo>[].obs;

  final loadingCases = false.obs;
  final patientCases = <PatientCase>[].obs;

  final loadingDiseases = false.obs;
  final diseases = <Disease>[].obs;

  final updatingDisease = false.obs;
  final updatingUserInfo = false.obs;

  @override
  void onInit() {
    fetchUsers();
    fetchPatientCases();
    fetchDiseases();
    super.onInit();
  }

  void fetchUsers() async {
    loadingUsers.value = true;
    final response = await _api.getUsers();

    if (response.data['success']) {
      final list = UserInfo.fromList(response.data['payload']);

      users.assignAll(list);
      users.where((p0) => p0.userLevelId != 1);
      users.sort((a, b) => a.fname!.compareTo(b.fname!));

      loadingUsers.value = false;
    } else {
      loadingUsers.value = false;
      debugPrint(response.data['message']);
    }
  }

  void fetchPatientCases() async {
    loadingCases.value = true;
    final response = await _api.getPatientCases();

    if (response.data['success']) {
      final list = PatientCase.fromList(response.data['payload']);

      patientCases.assignAll(list);
      patientCases.sort((a, b) => a.patientFname!.compareTo(b.patientFname!));

      loadingCases.value = false;
    } else {
      loadingCases.value = false;
      debugPrint(response.data['message']);
    }
  }

  void fetchDiseases() async {
    loadingDiseases.value = true;
    final response = await _api.getDiseases();

    if (response.data['success']) {
      final list = Disease.fromList(response.data['payload']);

      diseases.assignAll(list);
      diseases.sort((a, b) => a.diseaseName!.compareTo(b.diseaseName!));

      loadingDiseases.value = false;
    } else {
      loadingDiseases.value = false;
      debugPrint(response.data['message']);
    }
  }

  void updateDisease(Disease disease, BuildContext context) async {
    updatingDisease.value = true;
    final response = await _api.updateDisease(disease);

    if (response.data['success']) {
      updatingDisease.value = false;
      FlushbarHelper.createSuccess(
        message: response.data['message'],
      ).show(context);
    } else {
      updatingDisease.value = false;
      FlushbarHelper.createError(
        message: response.data['message'],
      ).show(context);
    }
  }

  void updateUserInfo(UserData data, BuildContext context) async {
    updatingUserInfo.value = true;
    final response = await _api.updateUserInfo(data);

    if (response.data['success']) {
      updatingUserInfo.value = false;
      FlushbarHelper.createSuccess(
        message: response.data['message'],
      ).show(context);
    } else {
      updatingUserInfo.value = false;
      FlushbarHelper.createError(
        message: response.data['message'],
      ).show(context);
    }
  }
}
