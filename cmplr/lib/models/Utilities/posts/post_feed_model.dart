import '../../../utilities/custom_widgets/post_item.dart';
import '../../../backend_uris.dart';
import '../../cmplr_service.dart';
import 'dart:convert';

class ModelPostsFeed {
  Future<List<PostItem>> getNewPosts() async {
    final posts = <PostItem>[];

    final response = await CMPLRService.get(GetURIs.postFollow, {});
    final responseBody = jsonDecode(response.body);
    print('model');
    print(responseBody['total_posts']);
    for (var i = 0; i < responseBody['total_posts']; i++) {
      posts.add(PostItem.fromJson(responseBody['posts'][i]));
    }
    print(posts.length);
    return posts;
  }
}
