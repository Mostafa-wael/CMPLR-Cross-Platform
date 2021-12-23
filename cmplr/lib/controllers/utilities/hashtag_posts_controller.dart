import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/models.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_ticket_provider_mixin.dart';

class HashtagPostsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  TabController? _tabController;

  bool dataReloaded = false;

  late RxBool hashtagFollowed;

  TabController? get tabController => _tabController;

  @override
  void onInit() {
    hashtagFollowed = false.obs;
    _tabController = TabController(length: 2, vsync: this);
    super.onInit();
  }

  void followHashtagButtonPressed() {
    hashtagFollowed.value = !hashtagFollowed.value;
  }

  // This fetches the data once again
  Future<void> refreshScreen() async {
    //notes = await notesModel.getNotes();
    dataReloaded = true;
    update();
  }
}
