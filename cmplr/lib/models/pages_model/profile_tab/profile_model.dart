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
    final response = await CMPLRService.get(GetURIs.userTheme, {});
    final responseBody = jsonDecode(response.body);
    return responseBody['response'];
  }

  Future<dynamic> putTheme(theme) async {
    final response =
        await CMPLRService.put(GetURIs.userTheme, {'theme': theme});
    return response;
  }

  Future<dynamic> putBlogSettings(backgroundColor, title, desc) async {
    final response = await CMPLRService.put('/blog/ /settings/save', {
      'blog_title': title,
      'background_color': backgroundColor,
      'description': desc,
    });
    return response;
  }

  Future<dynamic> uploadImg(img) async {
    final response = await CMPLRService.post(
        PostURIs.imgUpload, {'image': 'data:image/jpg:based64,' + img});
    return response;
  }
}
