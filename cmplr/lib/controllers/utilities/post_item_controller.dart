import '../controllers.dart';
import '../../utilities/custom_widgets/custom_widgets.dart';

import '../../routes.dart';
import 'package:get/get.dart';

class PostItemController extends GetxController {
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

  void share() {
    // Get.toNamed(Routes.share);
  }

  void openProfile() {
    // Get.toNamed(Routes.openProfile);
  }

  void loveClicked() {
    lovedPost = !lovedPost;
    // TODO: send post request to '/user/like/ with post_id and reblog_key
  }
}
