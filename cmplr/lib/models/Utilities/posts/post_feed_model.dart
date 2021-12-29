import 'dart:math';

import '../../../utilities/custom_widgets/post_item.dart';
import '../../../backend_uris.dart';
import '../../cmplr_service.dart';
import 'dart:convert';

class ModelPostsFeed {
  var postFeedType = '';
  ModelPostsFeed({required String postFeedTypeContoller}) {
    postFeedType = postFeedTypeContoller;
    print('in the model, postFeedType is $postFeedType');
  }
  Future<List<PostItem>> getNewPosts(
      {String postFeedTypeContoller = ''}) async {
    postFeedType =
        postFeedTypeContoller != '' ? postFeedTypeContoller : postFeedType;
    final posts = <PostItem>[];
    final response = await CMPLRService.get(postFeedType, {});
    if (response.statusCode == CMPLRService.requestSuccess) {
      final responseBody = jsonDecode(response.body);
      // print('model, $postFeedType posts from json');
      // print(responseBody['posts_per_page']);
      for (var i = 0; i < responseBody['response']['post'].length; i++) {
        posts.add(PostItem.fromJson(responseBody['response']['post'][i]));
      }
      print('model, $postFeedType posts list');
      print(posts.length);
      return posts;
    } else
      return [];
  }
}
