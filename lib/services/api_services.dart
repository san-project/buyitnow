import 'dart:developer';

import 'package:buyitnow/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiServices {
  final _dio = Dio(BaseOptions(
    baseUrl: 'https://buyitnow-j5c7.onrender.com/api/v1',
  ))
    ..interceptors.add(PrettyDioLogger());

  Future<Response> signUp(
      {required String name,
      required String email,
      required String password}) async {
    try {
      return await _dio.post('/auth/user/register',
          data: {"name": name, "email": email, "password": password});
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<Response> login(
      {required String email, required String password}) async {
    try {
      return await _dio.post('/auth/user/login',
          data: {"email": email, "password": password});
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
