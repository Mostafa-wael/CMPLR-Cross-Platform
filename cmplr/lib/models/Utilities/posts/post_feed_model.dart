import 'dart:convert';

import '../../../utilities/custom_widgets/post_item.dart';
import '../../../../backend_uris.dart';
import '../../cmplr_service.dart';
import '../../../../utilities/functions.dart';
import 'package:http/http.dart' as http;

class ModelPostsFeed {
  // TODO: this function should return list of posts
  Future<http.Response> getNewPosts(String postType) async {
    final response = await CMPLRService.post(
      PostURIs.posts,
      {
        'postType': postType,
      },
    );
    // TODO: you should porse the JSON
    final postMap = jsonDecode(response.body);

    return postMap;
  }
}
