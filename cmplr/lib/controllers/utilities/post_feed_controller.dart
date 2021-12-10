import '../../models/Utilities/posts/post_feed_model.dart';

import '../../utilities/custom_widgets/custom_widgets.dart';

import 'package:get/get.dart';

class PostFeedController extends GetxController
    with SingleGetTickerProviderMixin {
  final ModelPostsFeed _model = ModelPostsFeed();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List<PostItem> posts = [];

  List<PostItem> getNewPosts() {
    return _model.getNewPosts();
  }

  void initialPosts() async {
    _isLoading = true;
    update();
    await Future.delayed(const Duration(milliseconds: 1500));
    posts += getNewPosts();
    _isLoading = false;
    update();
  }

  void updatePosts() async {
    _isLoading = true;
    update();
    await Future.delayed(const Duration(milliseconds: 1500));
    posts += getNewPosts();
    _isLoading = false;
    update();
  }
}
