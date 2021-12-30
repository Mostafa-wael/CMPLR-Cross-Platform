import 'dart:convert';
import '../../../backend_uris.dart';
import '../../models.dart';
import '../../cmplr_service.dart';

class ProfileSearchModel {
  Future<List<Blog>> getFollowingBlogs() async {
    final blogs = <Blog>[];
    final response =
        await CMPLRService.getFollowingBlogs(GetURIs.followingBlogs, {});
    if (response.statusCode == CMPLRService.requestSuccess) {
      final responseBody = jsonDecode(response.body);
      for (var i = 0; i < responseBody['response']['blogs'].length; i++) {
        blogs.add(Blog.fromJson(responseBody['response']['blogs'][i]));
      }
      return blogs;
    } else
      return [];
  }

  Future<void> followBlog(String blogName) async {
    await CMPLRService.followBlog(PostURIs.followBlog, {'blogName': blogName});
  }

  Future<void> unfollowBlog(String blogName) async {
    await CMPLRService.unfollowBlog(
        DeleteURIs.unfollowBlog, {'blogName': blogName});
  }
}
