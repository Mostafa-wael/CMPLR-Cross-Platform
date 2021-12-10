<<<<<<< Updated upstream
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
=======
import '../../views/home_tab/write_post_view.dart';

import '../../utilities/custom_widgets/custom_widgets.dart';

import '../controllers.dart';
import '../../routes.dart';
>>>>>>> Stashed changes
import 'package:get/get.dart';
import '../../models/models.dart';

class PostController extends GetxController {
  void openNotes(int numNotes) {
    Get.toNamed('/notes', arguments: numNotes);
  }

<<<<<<< Updated upstream
  void reblog() {
    Get.toNamed('/reblog');
=======
  void reblog(PostItem postItem) {
    final reblogController = Get.find<ReblogController>();
    reblogController.post = postItem;
    Get.toNamed(Routes.reblog);
>>>>>>> Stashed changes
  }

  void openMoreOptions() {
    // Get.toNamed('/more_options');
  }

  void share() {
    // Get.toNamed('/share');
  }

  void lovePost() {}
}
