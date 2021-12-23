import '../../models/Utilities/posts/post_feed_model.dart';

import '../../utilities/custom_widgets/custom_widgets.dart';

import 'package:get/get.dart';

class PostFeedController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final ModelPostsFeed model = ModelPostsFeed();

  bool _dataReloaded = false;
  bool get dataReloaded => _dataReloaded;
  List<PostItem> posts = [];

  @override
  void onInit() async {
    super.onInit();
  }

  Future<void> updatePosts() async {
    var newPosts = await model.getNewPosts();
    newPosts += posts; // So that new posts are added at the top
    posts = newPosts;
    _dataReloaded = true;
    update();
  }
}
