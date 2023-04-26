import 'dart:developer';

import 'package:buyitnow/services/auth_repo.dart';
import 'package:buyitnow/utils/shared_prefs.dart';
import 'package:buyitnow/utils/snack_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String _otpId = "";
  String get otpId => _otpId;
  String _userId = "";
  String get userId => _userId;
  final _prefs = SharedPrefs.instance();
  Future<bool> signIn(
      String email, String password, BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await AuthRepo().login(email: email, password: password);
      _isLoading = false;
      notifyListeners();
      final user = response.data['user'];
      log(user["token"].toString());
      _prefs.setToken(user['token']);
      return true;
    } on DioError catch (e) {
      log(e.response.toString());
      dioError(context, e);
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signUp(
      String name, String email, String password, BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response =
          await AuthRepo().signUp(email: email, password: password, name: name);
      _isLoading = false;
      notifyListeners();
      final user = response.data['user'];
      log(user["token"].toString());
      _prefs.setToken(user['token']);
      return true;
    } on DioError catch (e) {
      log(e.response.toString());
      dioError(context, e);
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> getOtp(String email, BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await AuthRepo().getOtp(email);
      _otpId = response.data['id'] ?? '';
      _isLoading = false;
      notifyListeners();
      return true;
    } on DioError catch (e) {
      log(e.response.toString());
      dioError(context, e);
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> verifyOtp(String otp, BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await AuthRepo().verifyOtp(otp, _otpId);
      // _otpId = response.data['id'] ?? '';
      _userId = response.data['user'];
      _isLoading = false;
      notifyListeners();
      return true;
    } on DioError catch (e) {
      log(e.response.toString());
      dioError(context, e);
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> resetPassword(String password, BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await AuthRepo().resetPassword(password, userId);
      // _otpId = response.data['id'] ?? '';
      _isLoading = false;
      notifyListeners();
      _prefs.setToken(response.data['token']);
      return true;
    } on DioError catch (e) {
      log(e.response.toString());
      dioError(context, e);
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> logOut() async => _prefs.clear();
}
