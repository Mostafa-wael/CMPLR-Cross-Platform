import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/models.dart';

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
    // initially, get the popular searched topics
    _currentlyShownTopics = preferencesSearchModel.getPopularSearchedTopics();
    super.onInit();
  }

  /// This reads the search query then it display the results in the list view,
  /// this method is called whenever the search query is changed
  void searchQueryChanged() {
    if (_searchBarController.text == '') {
      _searchIndicatorString = 'Popular searched topics';
      _currentlyShownTopics = preferencesSearchModel.getPopularSearchedTopics();
    } else {
      _searchIndicatorString = 'Search results';
      _currentlyShownTopics =
          preferencesSearchModel.getPopularSearchedTopics().sublist(5, 8);
    }
    update();
  }

  void closeSearchPage() {
    Get.back();
  }

  /// This method adds the searched topic to the signup preferences page and
  /// then navigates to the signup preferences page.
  /// The argument of Get is the controller of the preference page which is used
  /// to add the preference to the preferences page after the search is done
  void addSearchedTopic(String topicName) {
    Get.arguments.addPreference(topicName);
    Get.back();
  }
}
