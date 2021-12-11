import '../../models/Utilities/posts/post_feed_model.dart';

import '../../utilities/custom_widgets/custom_widgets.dart';

import 'package:get/get.dart';

class PostFeedController extends GetxController
    with SingleGetTickerProviderMixin {
  final ModelPostsFeed model = ModelPostsFeed();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List<PostItem> posts = [];

  @override
  void onInit() async {
    _isLoading = true;
    await Future.delayed(const Duration(milliseconds: 1500));
    _isLoading = false;
    super.onInit();
  }

  Future<void> updatePosts() async {
    final newPosts = await model.getNewPosts();
    posts += newPosts;
  }
}
