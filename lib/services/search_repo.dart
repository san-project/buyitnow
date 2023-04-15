import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../utils/shared_prefs.dart';
import 'base_api_service.dart';

class SearchRepo {
  final _api = BaseApi().dio;

  final token = SharedPrefs.instance().token;
  final userId = SharedPrefs.instance().userId;

  Future<Response> getSearchProduct(String searchText) async {
    try {
      return await _api.get('/product/search?q=$searchText');
    } catch (e) {
      rethrow;
    }
  }
}
