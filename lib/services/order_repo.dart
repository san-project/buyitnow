import 'package:buyitnow/services/base_api_service.dart';
import 'package:dio/dio.dart';

import '../utils/shared_prefs.dart';

class OrderRepo {
  final _api = BaseApi().dio;
  final token = SharedPrefs.instance().token;

  //
  Future<Response> newOrder(String address) async {
    try {
      return await _api.post('/product/order',
          data: {"deliveryAddress": address},
          options: Options(
            headers: {'Authorization': 'Bearer $token'},
          ));
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getAllOrders() async {
    try {
      return await _api.get('/user/orders',
          options: Options(
            headers: {'Authorization': 'Bearer $token'},
          ));
    } catch (e) {
      rethrow;
    }
  }
}
