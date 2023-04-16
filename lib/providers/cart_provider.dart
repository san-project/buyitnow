import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../models/cart_model.dart';
import '../services/cart_repo.dart';
import '../utils/snack_bar.dart';

class CartProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  Cart? _cart;
  Cart? get cart => _cart;
  List<String> _cartProducts = [];
  List<String> get cartProducts => _cartProducts;

  Future<void> addCartProduct(String id, BuildContext context) async {
    _cartProducts.add(id);
    _isLoading = true;
    notifyListeners();
    try {
      final response = await CartRepo().addCartProduct(id);
      log(response.data.toString());
      _isLoading = false;
      notifyListeners();
    } on DioError catch (e) {
      _isLoading = false;
      notifyListeners();
      dioError(context, e);
    }
  }

  Future<void> getCartProduct(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await CartRepo().getCart();
      _cart = Cart.fromJson(response.data);
      log(_cart!.cart.length.toString());

      _isLoading = false;
      notifyListeners();
    } on DioError catch (e) {
      _isLoading = false;
      notifyListeners();
      dioError(context, e);
    }
  }

  Future<void> updateCartProduct(
      BuildContext context, String cartId, bool incDec) async {
    _isLoading = true;
    notifyListeners();
    try {
      await CartRepo()
          .updateCart(cartId, incDec)
          .then((value) => getCartProduct(context));
      _isLoading = false;
      notifyListeners();
    } on DioError catch (e) {
      _isLoading = false;
      notifyListeners();
      dioError(context, e);
    }
  }

  Future<void> deleteCart(
      BuildContext context, String cartId, String productId) async {
    _isLoading = true;

    _cartProducts.remove(productId);
    notifyListeners();
    try {
      await CartRepo()
          .deleteCart(cartId)
          .then((value) => getCartProduct(context));
      _isLoading = false;
      notifyListeners();
    } on DioError catch (e) {
      _isLoading = false;
      notifyListeners();
      dioError(context, e);
    }
  }
}
