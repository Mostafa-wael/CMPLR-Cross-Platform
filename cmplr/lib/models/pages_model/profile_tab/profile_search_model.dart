import 'dart:convert';
import '../../../backend_uris.dart';
import '../../models.dart';
import '../../cmplr_service.dart';

class ProfileSearchModel {
  Future<List<Blog>> getFollowingBlogs() async {
    final blogs = <Blog>[];
    final response =
        await CMPLRService.getFollowingBlogs(GetURIs.followedBlogs, {});
    final responseBody = jsonDecode(response.body);
    for (var i = 0; i < responseBody['blogs'].length; i++) {
      blogs.add(Blog.fromJson(responseBody['blogs'][i]));
    }
    return blogs;
  }
}
