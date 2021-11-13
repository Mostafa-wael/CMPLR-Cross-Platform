import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/models.dart';

class SignupPreferencesSearchController extends GetxController {
  SignupPreferencesSearchModel preferencesSearchModel =
      SignupPreferencesSearchModel();
  String _searchIndicatorString = 'Popular searched topics';
  final _searchBarController = TextEditingController();
  List _currentlyShownTopics = [];

  String get searchIndicatorString => _searchIndicatorString;
  TextEditingController get searchBarController => _searchBarController;
  List get currentlyShownTopics => _currentlyShownTopics;

  @override
  void onInit() {
    print(Get.arguments.runtimeType);
    _currentlyShownTopics = preferencesSearchModel.getPopularSearchedTopics();
    super.onInit();
  }

  void searchQueryChanged() {
    if (_searchBarController.text == '') {
      _searchIndicatorString = 'Popular searched topics';
      _currentlyShownTopics = preferencesSearchModel.getPopularSearchedTopics();
    } else {
      _searchIndicatorString = 'Search results';
      _currentlyShownTopics =
          preferencesSearchModel.getPopularSearchedTopics().sublist(5);
    }
    update();
  }

  void closeSearchPage() {
    Get.back();
  }

  void addSearchedTopic(String topicName) {
    Get.arguments.addPreference(topicName);
    Get.back();
  }
}
