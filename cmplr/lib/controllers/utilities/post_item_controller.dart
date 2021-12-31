import '../../backend_uris.dart';

import '../../models/cmplr_service.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

import '../controllers.dart';
import '../../views/utilities/utility_views.dart';
import '../../routes.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class PostItemController extends GetxController {
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

  void loveClicked(bool lovedPost, String postID) async {
    print('Post ID: ' + postID);
    if (lovedPost) {
      await CMPLRService.likePost(PostURIs.likePost, {'id': postID});
    } else {
      await CMPLRService.unlikePost(DeleteURIs.unlikePost, {'id': postID});
    }
    // TODO: send post request to '/user/like/ with post_id and reblog_key
  }
}
