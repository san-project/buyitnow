import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../models/get_product_model.dart';
import '../services/category_repo.dart';
import '../utils/snack_bar.dart';

class CategoryProvider extends ChangeNotifier {
  List<Category> _categories = [];
  List<Category> get categories => _categories;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  getAllCategories(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await CategoryRepo().getAllCategories();
      final List list = response.data;
      _categories = list.map((e) => Category.fromJson(e)).toList();
      _isLoading = false;
      notifyListeners();
    } on DioError catch (e) {
      _isLoading = false;
      notifyListeners();
      dioError(context, e);
    }
  }
}
