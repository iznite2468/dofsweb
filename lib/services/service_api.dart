import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dofsweb/helpers/constants.dart';
import 'package:dofsweb/models/disease.dart';
import 'package:dofsweb/models/user_data.dart';
import 'package:dofsweb/models/user_info.dart';
import 'package:dofsweb/services/user_session.dart';

class ServiceApi {
  final dio = Dio();
  final session = UserSession();

  var options = Options(
    contentType: ContentType.parse("application/x-www-form-urlencoded").value,
  );

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

  Future<Response> updatePassword(String newPassword) async {
    final data = await session.getSession();
    final response = await dio.post(
      '$baseUrl/user/updatePassword',
      data: {
        'userAccessId': data!.userAccessId,
        'password': newPassword,
      },
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

  Future<Response> updateDisease(Disease disease) async {
    final data = await session.getSession();
    final response = await dio.post(
      '$baseUrl/disease/updateDisease',
      data: {
        'diseaseId': disease.diseaseId,
        'description': disease.description,
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
}
