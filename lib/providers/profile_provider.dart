import 'package:buyitnow/models/user_model.dart';
import 'package:buyitnow/services/profile_repo.dart';
import 'package:buyitnow/utils/snack_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  User? _user;
  User? get user => _user;

  Future<void> getProfileDetails(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await ProfileRepo().getProfileDetails();
      _user = User.fromJson(response.data['user']);
      _isLoading = false;
      notifyListeners();
    } on DioError catch (e) {
      _isLoading = false;
      notifyListeners();
      dioError(context, e);
    }
  }
}
