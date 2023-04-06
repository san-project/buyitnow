import 'dart:developer';
import 'package:dio/dio.dart';

import './base_api_service.dart';

class AuthRepo {
  final _api = BaseApi().dio;

  Future<Response> signUp(
      {required String name,
      required String email,
      required String password}) async {
    try {
      return await _api.post('/auth/user/register',
          data: {"name": name, "email": email, "password": password});
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<Response> login(
      {required String email, required String password}) async {
    try {
      return await _api.post('/auth/user/login',
          data: {"email": email, "password": password});
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
