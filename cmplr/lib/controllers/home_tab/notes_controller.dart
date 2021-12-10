import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/models.dart';

class NotesController extends GetxController with SingleGetTickerProviderMixin {
  final RxBool _postSubscribed = false.obs;

  late TabController _tabController;

  final RxInt _tabBarIndex = 0.obs;

  RxBool get postSubscribed => _postSubscribed;

  final NotesModel _notesModel = NotesModel();

  final Rx<MaterialColor> _tabBarIndicatorColor = Colors.lightBlue.obs;

  RxInt get tabBarIndex => _tabBarIndex;

  MaterialColor get tabBarIndicatorColor => _tabBarIndicatorColor.value;

  TabController get tabController => _tabController;

  NotesModel get notesModel => _notesModel;

  set setTabBarIndex(int index) {
    _tabBarIndex.value = index;
  }

  void subscriptionButtonPressed() {
    String snackBarMessage;
    if (_postSubscribed.value) {
      snackBarMessage = 'Unsubscribed. Easy as pie.';
    } else {
      snackBarMessage = 'Okay you are subscribed to this post.';
    }
    _postSubscribed.value = !_postSubscribed.value;
    if (Get.isSnackbarOpen == true) {
      Get.back();
    }
    // Show error SnackBar
    Get.rawSnackbar(
      backgroundColor: Colors.green,
      messageText: Text(
        snackBarMessage,
        style: const TextStyle(fontSize: 16, color: Colors.white),
      ),
      duration: const Duration(seconds: 3),
    );
  }

  @override
  void onInit() {
    _tabController = TabController(length: 3, vsync: this);
    // _tabController.addListener(_handleTabSelection);
    super.onInit();
  }

  // void handleTabSelection() {
  //   switch (_tabController.index) {
  //     case 0:
  //       {
  //         _tabBarIndicatorColor.value = Colors.lightBlue;
  //       }
  //       break;
  //     case 1:
  //       {
  //         _tabBarIndicatorColor.value = Colors.green;
  //       }
  //       break;
  //     case 2:
  //       {
  //         _tabBarIndicatorColor.value = Colors.red;
  //       }
  //       break;
  //   }
  // }

  void closeNotesScreen() {
    Get.back();
  }
}
