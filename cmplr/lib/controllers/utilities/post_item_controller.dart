import '../../utilities/user.dart';

import '../../models/models.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

import '../controllers.dart';
import '../../utilities/custom_widgets/custom_widgets.dart';
import '../../routes.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import '../../user.dart';

class PostItemController extends GetxController {
  //final _followers = ;

  final _shareModel = ShareModel();

  bool lovedPost = false;

  void openNotes(PostItem postItem) {
    Get.toNamed(Routes.notes, arguments: postItem);
  }

  void reblog(PostItem postItem) {
    final reblogController = Get.find<ReblogController>();
    reblogController.post = postItem;
    Get.toNamed(Routes.reblog);
  }

  void openMoreOptions() {
    // Get.toNamed(Routes.moreOptions);
  }

  Future<void> share(BuildContext context, String postText) async {
    await Share.share(postText);
    update();
  }

  Future<void> back() async {
    Get.back();
    update();
  }

  // TODO: Change this to Future<user>
  Future<List> getFollowers() async {
    // TODO: Fix this
    return [];
    //return _shareModel.getFollowers(User.userData['id']);
  }

  void openProfile() {
    // Get.toNamed(Routes.openProfile);
  }

  void loveClicked() {
    // TODO: send post request to '/user/like/ with post_id and reblog_key
  }
}
