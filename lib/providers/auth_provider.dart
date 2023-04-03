import 'dart:developer';

import 'package:buyitnow/services/api_services.dart';
import 'package:buyitnow/utils/shared_prefs.dart';
import 'package:buyitnow/utils/snack_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final _prefs = SharedPrefs.instance();
  Future<bool> signIn(
      String email, String password, BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response =
          await ApiServices().login(email: email, password: password);
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
      final response = await ApiServices()
          .signUp(email: email, password: password, name: name);
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

  Future<bool> logOut() async => _prefs.clear();
}
