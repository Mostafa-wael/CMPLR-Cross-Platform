import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/models.dart';

class SearchController extends GetxController {
  // data model for search preferences
  SearchModel searchModel = SearchModel();

  // controller for the search text field
  final _searchBarController = TextEditingController();

  // list of the recommended search topics
  List recommendedQueries = [];

  RxBool showClearSearchBarIcon = false.obs;

  // getters for class attributes
  TextEditingController get searchBarController => _searchBarController;

  @override
  void onInit() {
    super.onInit();
  }

  /// This reads the search query then it display the results in the list view,
  /// this method is called whenever the search query is changed
  void searchQueryChanged() {
    if (_searchBarController.text == '') {
      showClearSearchBarIcon.value = false;
    } else {
      showClearSearchBarIcon.value = true;
    }
  }

  void search(String searchQuery) {
    // go to the search results here
  }

  void closeSearchPage() {
    Get.back();
  }
}
