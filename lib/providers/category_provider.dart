import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../models/get_product_model.dart';
import '../services/category_repo.dart';
import '../utils/snack_bar.dart';
import '../widgets/filter_diolog.dart';

class CategoryProvider extends ChangeNotifier {
  List<Category> _categories = [];
  List<Category> get categories => _categories;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  RadioValues _radioValues = RadioValues.relevance;
  RadioValues get radioValues => _radioValues;
  bool _isCategory = false;
  bool get isCategory => _isCategory;
  final List<String> _selectedCategories = [];
  List<String> get selectedCategories => _selectedCategories;

  clearFilters() {
    _radioValues = RadioValues.relevance;
    _selectedCategories.clear();
    notifyListeners();
  }

  radioOnChange(RadioValues? value) {
    if (value != null) {
      _radioValues = value;
      notifyListeners();
    }
  }

  changeFilter(bool value) {
    _isCategory = value;
    notifyListeners();
  }

  handleCheckBox(String id, bool? isChecked) {
    if (isChecked == true) {
      selectedCategories.add(id);
    } else {
      selectedCategories.remove(id);
    }
    notifyListeners();
  }

  Future<void> getAllCategories(BuildContext context) async {
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
