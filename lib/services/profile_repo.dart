import 'package:buyitnow/services/base_api_service.dart';
import 'package:buyitnow/utils/shared_prefs.dart';
import 'package:dio/dio.dart';

class ProfileRepo {
  final _api = BaseApi().dio;
  final token = SharedPrefs.instance().token;

  Future<Response> getProfileDetails() async {
    try {
      return await _api.get('/user/my-profile',
          options: Options(headers: {'Authorization': 'Bearer $token'}));
    } catch (e) {
      rethrow;
    }
  }
}
