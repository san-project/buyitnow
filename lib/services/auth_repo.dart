import 'dart:developer';
import 'package:dio/dio.dart';

import './base_api_service.dart';

class AuthRepo {
  final _api = BaseApi().dio;

  Future<Response> getOtp(String email) async {
    print(email);
    return await _api
        .post('/auth/user/forgot_password', data: {"email": email});
  }

  Future<Response> verifyOtp(String otp, String verificationId) async {
    log(verificationId);
    return await _api.post('/auth/user/verifyOtp',
        data: {"verificationId": verificationId, "otp": otp});
  }

  Future<Response> resetPassword(String password, String userId) async {
    return await _api.put('/auth/user/changePassword',
        data: {"userId": userId, "password": password});
  }

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
