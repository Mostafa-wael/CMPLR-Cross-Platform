import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/models.dart';

class SignupPreferencesSearchController extends GetxController {
  final mock = [
    'barcelona',
    'paris',
    'bayern',
    'madrid',
    'barcelona',
    'paris',
    'bayern',
    'madrid',
    'barcelona',
    'paris',
    'bayern',
    'madrid',
    'barcelona',
    'paris',
    'bayern',
    'madrid',
    'barcelona',
    'paris',
    'bayern',
    'madrid',
    'barcelona',
    'paris',
    'bayern',
    'madrid',
    'barcelona',
    'paris',
    'bayern',
    'madrid'
  ];
  String _searchIndicatorString = 'Popular searched topics';
  final _searchBarController = TextEditingController();

  String get searchIndicatorString => _searchIndicatorString;
  TextEditingController get searchBarController => _searchBarController;

  void searchQueryChanged() {
    if (_searchBarController.text == '') {
      _searchIndicatorString = 'Popular searched topics';
    } else {
      _searchIndicatorString = 'Search results';
    }
    update();
  }

  void closeSearchPage() {
    Get.back();
  }
}
