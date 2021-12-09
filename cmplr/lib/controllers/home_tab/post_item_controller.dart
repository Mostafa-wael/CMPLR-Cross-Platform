import '../../routes.dart';
import 'package:get/get.dart';

class PostController extends GetxController with SingleGetTickerProviderMixin {
  void openNotes(int numNotes) {
    Get.toNamed(Routes.notes, arguments: numNotes);
  }

  void reblog() {
    Get.toNamed(Routes.reblog);
  }

  void openMoreOptions() {
    // Get.toNamed(Routes.moreOptions);
  }

  void share() {
    // Get.toNamed(Routes.share);
  }

  void lovePost() {
    // TODO: send post request to '/user/like/ with post_id and reblog_key
  }
}
