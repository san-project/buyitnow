import 'dart:developer';

import 'package:dio/dio.dart';

import '../utils/shared_prefs.dart';
import 'base_api_service.dart';

class CartRepo {
  final _api = BaseApi().dio;

  final token = SharedPrefs.instance().token;

  Future<Response> addCartProduct(String id) async {
    try {
      return _api.post('/cart',
          data: {"product": id},
          options: Options(headers: {'Authorization': 'Bearer $token'}));
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<Response> deleteCart(String cartId) async {
    try {
      return _api.delete('/cart/$cartId',
          // data: {"product": id},
          options: Options(headers: {'Authorization': 'Bearer $token'}));
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<Response> updateCart(String cartId, bool qtyIncDec) async {
    try {
      return _api.put('/cart/$cartId',
          data: {"qtyIncDec": qtyIncDec},
          options: Options(headers: {'Authorization': 'Bearer $token'}));
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<Response> getCart() async {
    try {
      return _api.get('/cart',
          // data: {"product": id},
          options: Options(headers: {'Authorization': 'Bearer $token'}));
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
