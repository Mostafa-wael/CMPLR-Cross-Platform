import 'package:flutter/material.dart';

import '../controllers.dart';
import '../../utilities/custom_widgets/custom_widgets.dart';
import '../../routes.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class PostItemController extends GetxController {
  //final _followers = ;

  bool lovedPost = false;
  void openNotes(int numNotes) {
    Get.toNamed(Routes.notes, arguments: numNotes);
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

  // TODO: Change this to Future<user>
  Future<List> getFollowers() async {
    // TODO: Add the logic that returns the list of users
    // Each user contains an avatar & name
    // This will all be added after creating the model
    // final following = await _model.getFollowing();
    return [];
  }

  void openProfile() {
    // Get.toNamed(Routes.openProfile);
  }

  void loveClicked() {
    lovedPost = !lovedPost;
    // TODO: send post request to '/user/like/ with post_id and reblog_key
  }
}
