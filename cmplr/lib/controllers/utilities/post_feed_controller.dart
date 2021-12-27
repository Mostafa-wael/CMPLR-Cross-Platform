import '../../models/Utilities/posts/post_feed_model.dart';

import '../../utilities/custom_widgets/custom_widgets.dart';

import 'package:get/get.dart';

class PostFeedController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final ModelPostsFeed model = ModelPostsFeed();

  bool _dataReloaded = false;
  RxBool isLoading = true.obs;
  bool get dataReloaded => _dataReloaded;
  List<PostItem> posts = [];

  @override
  void onInit() async {
    super.onInit();
  }

  Future<void> updatePosts() async {
    try {
      isLoading(true);
      final newPosts = await model.getNewPosts();
      posts += newPosts;
    } finally {
      isLoading(false);
      _dataReloaded = true;
      update();
    }
  }
}
