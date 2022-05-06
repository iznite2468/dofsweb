import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dofsweb/helpers/constants.dart';
import 'package:dofsweb/models/disease.dart';
import 'package:dofsweb/models/patient_case_data.dart';
import 'package:dofsweb/models/patient_info_data.dart';
import 'package:dofsweb/models/remedy.dart';
import 'package:dofsweb/models/symptom.dart';
import 'package:dofsweb/models/user_data.dart';
import 'package:dofsweb/services/user_session.dart';

class ServiceApi {
  final dio = Dio();
  final session = UserSession();

  var options = Options(
    contentType: ContentType.parse("application/x-www-form-urlencoded").value,
  );

  // USER REQUESTS
  Future<Response> login({required String username, required password}) async {
    final response = await dio.post(
      '$baseUrl/user/login',
      data: {
        'isAdmin': 1,
        'username': username,
        'password': password,
      },
      options: options,
    );

    return response;
  }

  Future<Response> register(UserData data) async {
    data.isAdmin = 0;
    final response = await dio.post(
      '$baseUrl/user/register',
      data: data.toJson(),
      options: options,
    );

    return response;
  }

  Future<Response> getUsers() async {
    final data = await session.getSession();
    final response = await dio.get(
      '$baseUrl/user/getUsers/${data!.userAccessId}',
      options: Options(
        contentType:
            ContentType.parse("application/x-www-form-urlencoded").value,
        headers: {
          'authorization': data.token,
        },
      ),
    );

    return response;
  }

  Future<Response> updatePassword(
    String newPassword,
    int userAccessId,
  ) async {
    final data = await session.getSession();
    final response = await dio.post(
      '$baseUrl/user/updatePassword',
      data: {
        'userAccessId': userAccessId,
        'password': newPassword,
      },
      options: Options(
        contentType:
            ContentType.parse("application/x-www-form-urlencoded").value,
        headers: {
          'authorization': data!.token,
        },
      ),
    );

    return response;
  }

  Future<Response> updateUserInfo(UserData info) async {
    final data = await session.getSession();
    final response = await dio.post(
      '$baseUrl/user/updateInfo',
      data: info.toJson(),
      options: Options(
        contentType:
            ContentType.parse("application/x-www-form-urlencoded").value,
        headers: {
          'authorization': data!.token,
        },
      ),
    );

    return response;
  }

  Future<Response> updateAccountStatus(String status, int userAccessId) async {
    final data = await session.getSession();
    final response = await dio.post(
      '$baseUrl/user/updateAccountStatus',
      data: {
        "status": status,
        "userAccessId": userAccessId,
      },
      options: Options(
        contentType:
            ContentType.parse("application/x-www-form-urlencoded").value,
        headers: {
          'authorization': data!.token,
        },
      ),
    );
    return response;
  }

  // PATIENT CASE REQUESTS

  Future<Response> getPatientCases() async {
    final data = await session.getSession();
    final response = await dio.get(
      '$baseUrl/patientCase/getPatientCases',
      options: Options(
        contentType:
            ContentType.parse("application/x-www-form-urlencoded").value,
        headers: {
          'authorization': data!.token,
        },
      ),
    );

    return response;
  }

  Future<Response> addPatientCase(PatientCaseData caseData) async {
    final data = await session.getSession();

    final response = await dio.post(
      '$baseUrl/patientCase/addPatientCase',
      data: caseData.dateAdmission == null
          ? caseData.toJSON()
          : caseData.toJson(),
      options: Options(
        contentType:
            ContentType.parse("application/x-www-form-urlencoded").value,
        headers: {
          'authorization': data!.token,
        },
      ),
    );

    return response;
  }

  Future<Response> updatePatientCase(PatientCaseData caseData) async {
    final data = await session.getSession();

    final response = await dio.post(
      '$baseUrl/patientCase/updatePatientCase',
      data: caseData.dateAdmission == null
          ? caseData.toJSON()
          : caseData.toJson(),
      options: Options(
        contentType:
            ContentType.parse("application/x-www-form-urlencoded").value,
        headers: {
          'authorization': data!.token,
        },
      ),
    );

    return response;
  }

  Future<Response> archivePatientCase(int formId) async {
    final data = await session.getSession();
    final response = await dio.get(
      '$baseUrl/patientCase/archivePatientCase/$formId',
      options: Options(
        contentType:
            ContentType.parse("application/x-www-form-urlencoded").value,
        headers: {
          'authorization': data!.token,
        },
      ),
    );

    return response;
  }

  // DISEASE REQUESTS

  Future<Response> getDiseases() async {
    final data = await session.getSession();
    final response = await dio.get(
      '$baseUrl/disease/getDiseases',
      options: Options(
        contentType:
            ContentType.parse("application/x-www-form-urlencoded").value,
        headers: {
          'authorization': data!.token,
        },
      ),
    );

    return response;
  }

  Future<Response> addDisease(Disease disease) async {
    final data = await session.getSession();
    final response = await dio.post(
      '$baseUrl/disease/addDisease',
      data: disease.toJson(),
      options: Options(
        contentType:
            ContentType.parse("application/x-www-form-urlencoded").value,
        headers: {
          'authorization': data!.token,
        },
      ),
    );
    return response;
  }

  Future<Response> updateDisease(Disease disease) async {
    final data = await session.getSession();
    final response = await dio.post(
      '$baseUrl/disease/updateDisease',
      data: disease.toJson(),
      options: Options(
        contentType:
            ContentType.parse("application/x-www-form-urlencoded").value,
        headers: {
          'authorization': data!.token,
        },
      ),
    );

    return response;
  }

  Future<Response> archiveDisease(int diseaseId) async {
    final data = await session.getSession();
    final response = await dio.get(
      '$baseUrl/disease/archiveDisease/$diseaseId',
      options: Options(
        contentType:
            ContentType.parse("application/x-www-form-urlencoded").value,
        headers: {
          'authorization': data!.token,
        },
      ),
    );

    return response;
  }

  // BARANGAY REQUEST

  Future<Response> getBarangays() async {
    final data = await session.getSession();
    final response = await dio.get(
      '$baseUrl/barangay/list',
      options: Options(
        contentType:
            ContentType.parse("application/x-www-form-urlencoded").value,
        headers: {
          'authorization': data!.token,
        },
      ),
    );

    return response;
  }

  // PATIENT INFO REQUESTS

  Future<Response> getPatients() async {
    final data = await session.getSession();
    final response = await dio.get(
      '$baseUrl/patientInfo/getPatients',
      options: Options(
        contentType:
            ContentType.parse("application/x-www-form-urlencoded").value,
        headers: {
          'authorization': data!.token,
        },
      ),
    );

    return response;
  }

  Future<Response> addPatient(PatientInfoData patientInfoData) async {
    final data = await session.getSession();
    final response = await dio.post(
      '$baseUrl/patientInfo/addPatient',
      data: patientInfoData.toJson(),
      options: Options(
        contentType:
            ContentType.parse("application/x-www-form-urlencoded").value,
        headers: {
          'authorization': data!.token,
        },
      ),
    );

    return response;
  }

  Future<Response> updatePatientContactNumber(
      PatientInfoData patientInfoData) async {
    final data = await session.getSession();
    final response = await dio.post(
      '$baseUrl/patientInfo/updatePatientContactNumber',
      data: patientInfoData.toJson(),
      options: Options(
        contentType:
            ContentType.parse("application/x-www-form-urlencoded").value,
        headers: {
          'authorization': data!.token,
        },
      ),
    );

    return response;
  }

  Future<Response> updatePatientAddress(PatientInfoData patientInfoData) async {
    final data = await session.getSession();
    final response = await dio.post(
      '$baseUrl/patientInfo/updatePatientAddress',
      data: patientInfoData.toJson(),
      options: Options(
        contentType:
            ContentType.parse("application/x-www-form-urlencoded").value,
        headers: {
          'authorization': data!.token,
        },
      ),
    );

    return response;
  }

  //PIVOT REQUEST

  Future<Response> getPivots() async {
    final data = await session.getSession();
    final response = await dio.get(
      '$baseUrl/pivot/list',
      options: Options(
        contentType:
            ContentType.parse("application/x-www-form-urlencoded").value,
        headers: {
          'authorization': data!.token,
        },
      ),
    );

    return response;
  }

  Future<Response> getPivotByYear(String year) async {
    final data = await session.getSession();
    final response = await dio.get(
      '$baseUrl/pivot/year/$year',
      options: Options(
        contentType:
        ContentType.parse("application/x-www-form-urlencoded").value,
        headers: {
          'authorization': data!.token,
        },
      ),
    );

    return response;
  }

  Future<Response> getPivotByDisease(String disease) async {
    final data = await session.getSession();
    final response = await dio.get(
      '$baseUrl/pivot/disease/$disease',
      options: Options(
        contentType:
        ContentType.parse("application/x-www-form-urlencoded").value,
        headers: {
          'authorization': data!.token,
        },
      ),
    );

    return response;
  }


  //SYMPTOMS REQUEST

  Future<Response> getSymptoms() async {
    final data = await session.getSession();
    final response = await dio.get(
      '$baseUrl/symptom/getSymptoms',
      options: Options(
        contentType:
            ContentType.parse("application/x-www-form-urlencoded").value,
        headers: {
          'authorization': data!.token,
        },
      ),
    );

    return response;
  }

  Future<Response> addSymptom(Symptom symptom) async {
    final data = await session.getSession();
    final response = await dio.post(
      '$baseUrl/symptom/addSymptom',
      data: symptom.toJson(),
      options: Options(
        contentType:
            ContentType.parse("application/x-www-form-urlencoded").value,
        headers: {
          'authorization': data!.token,
        },
      ),
    );

    return response;
  }

  Future<Response> updateSymptom(Symptom symptom) async {
    final data = await session.getSession();
    final response = await dio.post(
      '$baseUrl/symptom/updateSymptom',
      data: symptom.toJson(),
      options: Options(
        contentType:
            ContentType.parse("application/x-www-form-urlencoded").value,
        headers: {
          'authorization': data!.token,
        },
      ),
    );

    return response;
  }

  Future<Response> deleteSymptom(int symptomId) async {
    final data = await session.getSession();
    final response = await dio.get(
      '$baseUrl/symptom/deleteSymptom/$symptomId',
      options: Options(
        contentType:
            ContentType.parse("application/x-www-form-urlencoded").value,
        headers: {
          'authorization': data!.token,
        },
      ),
    );

    return response;
  }

  //REMEDY REQUEST

  Future<Response> getRemedies() async {
    final data = await session.getSession();
    final response = await dio.get(
      '$baseUrl/remedy/getRemedies',
      options: Options(
        contentType:
            ContentType.parse("application/x-www-form-urlencoded").value,
        headers: {
          'authorization': data!.token,
        },
      ),
    );

    return response;
  }

  Future<Response> addRemedy(Remedy remedy) async {
    final data = await session.getSession();
    final response = await dio.post(
      '$baseUrl/remedy/addRemedy',
      data: remedy.toJson(),
      options: Options(
        contentType:
            ContentType.parse("application/x-www-form-urlencoded").value,
        headers: {
          'authorization': data!.token,
        },
      ),
    );

    return response;
  }

  Future<Response> updateRemedy(Remedy remedy) async {
    final data = await session.getSession();
    final response = await dio.post(
      '$baseUrl/remedy/updateRemedy',
      data: remedy.toJson(),
      options: Options(
        contentType:
            ContentType.parse("application/x-www-form-urlencoded").value,
        headers: {
          'authorization': data!.token,
        },
      ),
    );

    return response;
  }

  Future<Response> deleteRemedy(int remedyId) async {
    final data = await session.getSession();
    final response = await dio.get(
      '$baseUrl/remedy/deleteRemedy/$remedyId',
      options: Options(
        contentType:
            ContentType.parse("application/x-www-form-urlencoded").value,
        headers: {
          'authorization': data!.token,
        },
      ),
    );

    return response;
  }
  // END REQUESTS
}
