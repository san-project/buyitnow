import 'package:buyitnow/models/order_model.dart';
import 'package:buyitnow/services/order_repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../utils/snack_bar.dart';

enum PaymentMode { cashOnDelivery, paypal }

class OrderProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List<Order> _listOfOrders = [];
  List<Order> get listOfOrder => _listOfOrders;

  PaymentMode _paymentMode = PaymentMode.cashOnDelivery;
  PaymentMode get paymentMode => _paymentMode;

  Future<void> addNewOrder(BuildContext context, String address) async {
    try {
      _isLoading = true;
      notifyListeners();
      await OrderRepo().newOrder(address);
      _isLoading = false;
      notifyListeners();
    } on DioError catch (e) {
      _isLoading = false;
      notifyListeners();
      dioError(context, e);
    }
  }

  Future<void> getAllOrders(BuildContext context) async {
    try {
      _isLoading = true;
      notifyListeners();
      final response = await OrderRepo().getAllOrders();
      _listOfOrders = (response.data['orders'] as List)
          .map((e) => Order.fromJson(e))
          .toList();
      // log(_listOfOrders.length.toString());
      _isLoading = false;
      notifyListeners();
    } on DioError catch (e) {
      _isLoading = false;
      notifyListeners();
      dioError(context, e);
    }
  }
}
