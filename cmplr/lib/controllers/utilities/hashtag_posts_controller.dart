import '../../models/cmplr_service.dart';
import '../../backend_uris.dart';
import '../home_tab/write_post_controller.dart';
import '../../views/home_tab/write_post_view.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import '../../utilities/functions.dart' as cmplr_fn;

class HashtagPostsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxBool hashtagFollowed = false.obs;
  String? tagAvatar;
  bool dataReloaded = false;

  TabController? _tabController;
  TabController? get tabController => _tabController;

  late String tagName;

  @override
  void onInit() {
    tagName = Get.arguments;
    hashtagFollowed = false.obs;
    _tabController = TabController(length: 2, vsync: this);
    super.onInit();
  }

  void followHashtagButtonPressed() async {
    hashtagFollowed.value = !hashtagFollowed.value;
    if (hashtagFollowed.value)
      await CMPLRService.followTag(PostURIs.followTag, {'tag_name': tagName});
    else
      await CMPLRService.unfollowTag(
          DeleteURIs.unfollowTag, {'tag_name': tagName});
  }

  // This fetches the data once again
  Future<void> refreshScreen() async {
    //notes = await notesModel.getNotes();
    dataReloaded = true;
    update();
  }

  Future<void> share(BuildContext context, tagURL) async {
    await Share.share(tagURL);
    update();
  }

  void writePostWithTag() {
    final writePostController = Get.find<WritePostController>();
    writePostController.tags = [tagName];
    Get.to(const WritePost());
  }

  void showShareMenu(context) {
    cmplr_fn.showShareMenu(
      context,
      () {
        // TODO: share tag url
        share(context, 'FIXME:');
      },
    );
  }
}
