import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../backend_uris.dart';
import '../../cmplr_service.dart';

class WritePostModel {
  const WritePostModel();

  // Sends the required parameters to the backend
  // Receives a unique post id in return.
  // Note that all the parameters mentioned in the API are required
  Future<http.Response> createPost(
    String content,
    String blogName,
    String type, // text, photos, video, audio, quotes, chats
    // the state of the post. Specify one of the following:
    // published, draft, queue, private
    String state,

    // Comma-separated tags for this post
    List<String> tags,
  ) async {
    final response = await CMPLRService.post(PostURIs.post, {
      'content': content,
      'type': type,
      'blog_name': blogName,
      'state': state,
      'tags': tags,
    });

    // TODO: Check if the response decodes successfully
    if (response.statusCode == CMPLRService.insertSuccess) {
      return response;
    } else
      return http.Response(jsonEncode({}), response.statusCode);
  }
}
