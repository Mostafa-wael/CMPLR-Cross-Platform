import '../../../utilities/custom_widgets/post_item.dart';
import '../../../backend_uris.dart';
import '../../cmplr_service.dart';
import 'dart:convert';

class ModelPostsFeed {
  var postFeedType = '';
  String? tag;
  ModelPostsFeed({required String postFeedTypeContoller, String? tag}) {
    postFeedType = postFeedTypeContoller;
    this.tag = tag;
    print('in the model, postFeedType is $postFeedType');
  }
  Future<List<PostItem>> getNewPosts(
      {String postFeedTypeContoller = ''}) async {
    postFeedType =
        postFeedTypeContoller != '' ? postFeedTypeContoller : postFeedType;
    final posts = <PostItem>[];
    final response = await CMPLRService.get(postFeedType, {'tag': tag});
    if (response.statusCode == CMPLRService.requestSuccess) {
      final responseBody = jsonDecode(response.body);
      // print('model, $postFeedType posts from json');
      // print(responseBody['posts_per_page']);
      if (tag == null && postFeedTypeContoller != GetURIs.hashtagPosts) {
        for (var i = 0; i < responseBody['response']['post'].length; i++) {
          posts.add(PostItem.fromJson(responseBody['response']['post'][i]));
        }
      } else {
        for (var i = 0; i < responseBody['post'].length; i++) {
          posts.add(PostItem.fromJson(responseBody['post'][i]));
        }
      }

      print('model, $postFeedType posts list');
      print(posts.length);
      return posts;
    } else
      return [];
  }
}
