import 'dart:developer';

import 'package:dio/dio.dart';
import '../../utils/shared_prefs.dart';
import 'base_api_service.dart';

class ProductRepo {
  final _api = BaseApi().dio;

  final token = SharedPrefs.instance().token;
  final userId = SharedPrefs.instance().userId;

  Future<Response> getAllProducts() async {
    log(userId ?? "no seller id found");
    try {
      return await _api.get('/product',
          options: token != null
              ? Options(headers: {'Authorization': 'Bearer $token'})
              : Options());
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getProductByCategory(String categoryId) async {
    try {
      return await _api.get('/product/categoryproducts?categoryId=$categoryId');
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getProductBySeller(String sellerId) async {
    try {
      return await _api.get('/product/sellerProducts?sellerId=$sellerId');
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getAllCategories() async {
    try {
      return _api.get(
        '/category',
      );
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<Response> getAllWishlistProducts() async {
    log("TOKEN++++ $token");
    try {
      return _api.get('/wishlist',
          options: Options(headers: {'Authorization': 'Bearer $token'}));
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<Response> addProductToWishlist(String id) async {
    try {
      return _api.post('/wishlist',
          data: {"productId": id},
          options: Options(headers: {'Authorization': 'Bearer $token'}));
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<Response> removeProductToWishlist(String id) async {
    try {
      return _api.delete('/wishlist',
          data: {"productId": id},
          options: Options(headers: {'Authorization': 'Bearer $token'}));
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
