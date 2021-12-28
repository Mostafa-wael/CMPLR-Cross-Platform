import 'package:share_plus/share_plus.dart';

import '../../views/views.dart';
import '../../utilities/custom_widgets/check_out_these_tags_element.dart';
import '../../utilities/custom_widgets/top_blogs_element.dart';
import '../../utilities/sizing/sizing.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../flags.dart';
import '../../models/models.dart';

class ProfileSearchController extends GetxController
    with GetSingleTickerProviderStateMixin {
  ProfileSearchModel profileSearchModel = ProfileSearchModel();

  // controller for the search text field
  final _searchBarController = TextEditingController();

  RxBool showClearSearchBarIcon = false.obs;

  late TabController _tabController;

  int _tabIndex = 0;

  final RxString searchQuery = ''.obs;

  final List<String> popupMenuChoices = [
    'Share',
    'Get notifications',
    'Block',
    'Report',
    'Unfollow'
  ];

  List<Blog>? followingBlogs;

  List<RxBool>? showProfiles;

  // getters for class attributes
  TextEditingController get searchBarController => _searchBarController;

  TabController get tabController => _tabController;

  @override
  void onInit() {
    _tabController = TabController(length: 2, vsync: this);

    _tabController.addListener(() {
      if (_tabController.index != _tabIndex) {
        searchBarController.text = '';
        searchQueryChanged();
      }
      _tabIndex = _tabController.index;
    });

    super.onInit();
  }

  /// This reads the search query then it display the results in the list view,
  /// this method is called whenever the search query is changed
  void searchQueryChanged() {
    searchQuery.value = _searchBarController.text;
    if (_searchBarController.text == '') {
      showClearSearchBarIcon.value = false;
    } else {
      showClearSearchBarIcon.value = true;
    }
    if (followingBlogs != null) {
      for (var i = 0; i < followingBlogs!.length; i++) {
        if (!followingBlogs![i].blogName.contains(_searchBarController.text)) {
          showProfiles![i].value = false;
        } else {
          showProfiles![i].value = true;
        }
      }
    }
  }

  void closeSearchPage() {
    Get.back();
  }

  Future<void> share(BuildContext context, String blogURL) async {
    await Share.share(blogURL);
  }
}
