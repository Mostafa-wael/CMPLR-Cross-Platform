import '../../models/Utilities/posts/post_feed_model.dart';

import '../../utilities/custom_widgets/custom_widgets.dart';

import 'package:get/get.dart';

class PostFeedController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late ModelPostsFeed model;
  var postFeedType;
  bool _dataReloaded = false;
  RxBool isLoading = true.obs;
  var prefix;
  bool get dataReloaded => _dataReloaded;

  String? blogName;
  List<PostItem> posts = [];

  PostFeedController(
      {required String postFeedTypeFeed,
      String? tag,
      String? blogName,
      required prefix}) {
    postFeedType = postFeedTypeFeed;
    this.prefix = prefix;
    this.blogName = blogName;
    print('in the controller, postFeedType is $postFeedType');

    model = ModelPostsFeed(
        postFeedTypeContoller: postFeedTypeFeed,
        tag: tag,
        blogName: blogName,
        prefix: prefix);
  }

  @override
  void onInit() async {
    super.onInit();
  }

  Future<void> updatePosts({bool clearPosts = true}) async {
    print('in the controller, updatePosts, postFeedType is $postFeedType');
    var newPosts = await model.getNewPosts(
        postFeedTypeContoller: postFeedType, blogName: blogName);

    if (clearPosts) posts.clear();

    newPosts += posts; // So that new posts are added at the top
    posts = newPosts;
    _dataReloaded = true;
    isLoading(false);
    update();
  }
}
