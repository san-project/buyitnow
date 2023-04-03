import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../utils/shared_prefs.dart';

class ProductRepo {
  final _dio = Dio(BaseOptions(
    baseUrl: 'https://buyitnow-j5c7.onrender.com/api/v1',
  ))
    ..interceptors.add(PrettyDioLogger());
  final token = SharedPrefs.instance().token;
  final userId = SharedPrefs.instance().userId;

  Future<Response> getAllProducts() async {
    log(userId ?? "no seller id found");
    try {
      return await _dio.get(
        '/product',
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getAllCategories() async {
    try {
      return _dio.get('/category');
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
