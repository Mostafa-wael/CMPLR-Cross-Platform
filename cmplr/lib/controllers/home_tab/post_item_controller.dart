import '../../routes.dart';
import '../../utilities/custom_widgets/custom_widgets.dart';
import '../../controllers/controllers.dart';
import 'package:get/get.dart';

class PostController extends GetxController {
  void openNotes(int numNotes) {
    Get.toNamed('/notes', arguments: numNotes);
  }

  void reblog(PostItem postItem) {
    final reblogController = Get.find<ReblogController>();
    reblogController.post = postItem;
    Get.toNamed(Routes.reblog);
  }

  void openMoreOptions() {
    // Get.toNamed('/more_options');
  }

  void share() {
    // Get.toNamed('/share');
  }

  void lovePost() {}
}
