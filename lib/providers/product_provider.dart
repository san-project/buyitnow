import 'dart:developer';
import 'dart:io';
import 'package:buyitnow/services/search_repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import '../models/get_product_model.dart' as prd;

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
  List<prd.ProductModel> _listOfProductsFilter = [];
  List<prd.ProductModel> get listOfProductsFilter => _listOfProductsFilter;
  List<prd.ProductModel> _wishlist = [];
  List<prd.ProductModel> get wishlist => _wishlist;

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

  Future<void> getSearchProducts(
      BuildContext context, String searchText) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await SearchRepo().getSearchProduct(searchText);
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

  Future<void> getProductByCategory(
      BuildContext context, String categoryId) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await ProductRepo().getProductByCategory(categoryId);
      final listOfProducts = response.data['products'] as List;
      _listOfProductsFilter = prd.getProductsFromJson(listOfProducts);
      _isLoading = false;
      notifyListeners();
      log("listofproducts $_listOfProductsFilter");
    } on DioError catch (e) {
      _isLoading = false;
      notifyListeners();
      dioError(context, e);
    }
  }

  Future<void> getProductBySeller(BuildContext context, String sellerId) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await ProductRepo().getProductBySeller(sellerId);
      final listOfProducts = response.data['products'] as List;
      _listOfProductsFilter = prd.getProductsFromJson(listOfProducts);
      _isLoading = false;
      notifyListeners();
      log("listofproducts $_listOfProductsFilter");
    } on DioError catch (e) {
      _isLoading = false;
      notifyListeners();
      dioError(context, e);
    }
  }

  Future<void> getWishlistProducts(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await ProductRepo().getAllWishlistProducts();
      final listOfProducts =
          response.data['wishListProducts']['products'] as List;
      _wishlist = prd.getProductsFromJson(listOfProducts);
      _isLoading = false;
      notifyListeners();
      log("listofproducts $_wishlist");
    } on DioError catch (e) {
      _isLoading = false;
      notifyListeners();
      dioError(context, e);
    }
  }

  Future<void> addOrRemoveProductWishlist(
      String id, bool isFavourite, BuildContext context) async {
    try {
      if (isFavourite) {
        final response = await ProductRepo().removeProductToWishlist(id);
        // _listOfProducts.firstWhere((element) => element.id == id).isFavourite =
        //     false;
        log(response.data.toString());
      } else {
        final response = await ProductRepo().addProductToWishlist(id);
        // _listOfProducts.firstWhere((element) => element.id == id).isFavourite =
        //     true;
        log(response.data.toString());
      }

      // final listOfProducts = response.data['products'] as List;
      // _wishlist = prd.getProductsFromJson(listOfProducts);
      // _isLoading = false;
      // notifyListeners();
      // log("listofproducts $_wishlist");
    } on DioError catch (e) {
      _isLoading = false;
      notifyListeners();
      dioError(context, e);
    }
  }

  getProductsFromFilter(List<String> category) {
    _listOfProducts = _listOfProducts.filter((element) {
      return category.contains(element.category.id);
    }).toList();
    notifyListeners();
  }
}
