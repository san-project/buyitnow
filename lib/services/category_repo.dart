import 'package:buyitnow/services/base_api_service.dart';
import 'package:dio/dio.dart';

class CategoryRepo {
  final _api = BaseApi().dio;

  Future<Response> getAllCategories() async {
    try {
      return await _api.get('/category');
    } catch (e) {
      rethrow;
    }
  }
}
