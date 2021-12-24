import '../../models/Utilities/posts/post_feed_model.dart';

import '../../utilities/custom_widgets/custom_widgets.dart';

import 'package:get/get.dart';

class PostFeedController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late ModelPostsFeed model;
  var postFeedType;
  bool _dataReloaded = false;

  PostFeedController({required String postFeedTypeFeed}) {
    postFeedType = postFeedTypeFeed;
    print('in the controller, postFeedType is $postFeedType');
    model = ModelPostsFeed(postFeedTypeContoller: postFeedTypeFeed);
  }

  bool get dataReloaded => _dataReloaded;
  List<PostItem> posts = [];

  @override
  void onInit() async {
    super.onInit();
  }

  Future<void> updatePosts() async {
    print('in the controller, updatePosts, postFeedType is $postFeedType');
    var newPosts = await model.getNewPosts(postFeedTypeContoller: postFeedType);
    newPosts += posts; // So that new posts are added at the top
    posts = newPosts;
    _dataReloaded = true;
    update();
  }
}
