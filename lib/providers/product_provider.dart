import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../models/get_product_model.dart' as prd;

import '../models/get_product_model.dart';
import '../services/product_repo.dart';
import '../utils/snack_bar.dart';

class ProductProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  File? _thumbnail;
  File? get thumbnail => _thumbnail;
  final List<File> _pickedImages = [];
  List<File> get pickedImages => _pickedImages;
  List<prd.ProductModel> _listOfProducts = [];
  List<prd.ProductModel> get listOfProducts => _listOfProducts;

  Future<void> getAllProducts(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await ProductRepo().getAllProducts();
      final listOfProducts = response.data['products'] as List;
      _listOfProducts = prd.getProductsFromJson(listOfProducts);
      _isLoading = false;
      notifyListeners();
      log("listofproducts $_listOfProducts");
    } on DioError catch (e) {
      _isLoading = false;
      notifyListeners();
      dioError(context, e);
    }
  }
}
