import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/models.dart';

class SignupPreferencesSearchController extends GetxController {
  // data model for search preferences
  SignupPreferencesSearchModel preferencesSearchModel =
      SignupPreferencesSearchModel();

  // the header text of the scroll view (it changes after search)
  String _searchIndicatorString = 'Popular searched topics';

  // controller for the search text field
  final _searchBarController = TextEditingController();

  // list of the currently shown search topics
  List _currentlyShownTopics = [];

  // getters for class attributes
  String get searchIndicatorString => _searchIndicatorString;

  TextEditingController get searchBarController => _searchBarController;

  List get currentlyShownTopics => _currentlyShownTopics;

  @override
  void onInit() {
    // initially, get the popular topics
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
    // the argument here is the controller of the preference page which is used
    // to add the preference to the preferences page after the search
    Get.arguments.addPreference(topicName);
    Get.back();
  }
}
