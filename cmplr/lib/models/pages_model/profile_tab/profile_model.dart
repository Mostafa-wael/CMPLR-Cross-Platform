import 'package:get/get_connect/http/src/utils/utils.dart';
import 'dart:convert';
import '../../../backend_uris.dart';

import '../../cmplr_service.dart';

class ModelProfile {
  var blogId;
  ModelProfile({required this.blogId}) {}

  Future<dynamic> getBlogInfo() async {
    final response = await CMPLRService.get(GetURIs.blogInfo, {});
    final responseBody = jsonDecode(response.body);
    return responseBody['response'];
  }

  Future<dynamic> getTheme() async {
    final response = await CMPLRService.get('/user_theme', {});
    final responseBody = jsonDecode(response.body);
    return responseBody['response'];
  }

  Future<void> putTheme() async {}

  Future<dynamic> putBlogSettings(backgroundColor, title, desc) async {
    final response = await CMPLRService.put('/blog/ /settings/save', {
      'blog_title': title,
      'background_color': backgroundColor,
      'blog_description': desc,
    });
    return response;
  }
}
