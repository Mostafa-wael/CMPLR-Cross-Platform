import '../../../utilities/custom_widgets/post_item.dart';
import '../../../backend_uris.dart';
import '../../cmplr_service.dart';
import 'dart:convert';

class ModelPostsFeed {
  Future<List<PostItem>> getNewPosts() async {
    final posts = <PostItem>[];

    final response = await CMPLRService.get(GetURIs.postFollow, {});
    final responseBody = jsonDecode(response.body);
    print('model, posts from json');
    print(responseBody['posts_per_page']);
    for (var i = 0; i < responseBody['posts_per_page']; i++) {
      posts.add(PostItem.fromJson(responseBody['post'][i]));
    }
    print('model, posts list');
    print(posts.length);
    return posts;
  }
}
