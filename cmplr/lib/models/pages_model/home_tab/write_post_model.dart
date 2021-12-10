import 'dart:convert';

import '../../../backend_uris.dart';
import '../../cmplr_service.dart';

class WritePostModel {
  const WritePostModel();

  // Sends the required parameters to the backend
  // Receives a unique post id in return.
  // Note that all the parameters mentioned in the API are required
  Future<int?> createPost(
    String content,

    // the state of the post. Specify one of the following:
    // published, draft, queue, private
    String state,
    String publishOn,

    // Comma-separated tags for this post
    String tags,
    String date,
    bool isPrivate,
  ) async {
    final response = await CMPLRService.post(PostURIs.post, {
      'content': content,
      'state': state,
      'publish_on': publishOn,
      'tags': tags,
      'date': date,
      'is_private': isPrivate,
    });

    // TODO: Check if the response decodes successfully
    if (response.statusCode == CMPLRService.insertSuccess) {
      final responseBody = jsonDecode(response.body);
      return responseBody['id'];
    } else
      return null;
  }
}
