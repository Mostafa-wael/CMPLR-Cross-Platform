import 'dart:convert';

import '../../../backend_uris.dart';
import '../../../flags.dart';
import '../../cmplr_service.dart';

class ExploreModel {
  static final tagsYouFollowMockData = [
    {
      'tag_id': 12,
      'tag_name': 'Test Tag 1',
      'tag_slug': 'Test Tag 1',
      'post_views': [
        'https://64.media.tumblr.com/ffbb3a853b2e35ba0cf9a4ceea35f084/011c36db4adfbc03-f7/s640x960/2904c0ed277b4a94b417a3cb57d8fc571e7d10a1.jpg'
      ],
    },
    {
      'tag_id': 69,
      'tag_name': 'Test Tag 2',
      'tag_slug': 'Test Tag 2',
      'post_views': [
        'https://64.media.tumblr.com/ec1771be19d696cfdd02876076351d32/011c36db4adfbc03-66/s400x600/c903540d69f06fb1fed4a53ce7d41c83327b986b.png'
      ],
    },
    {
      'post_id': 420,
      'tag_name': 'Test Tag 3',
      'tag_slug': 'Test Tag 3',
      'post_views': [
        'https://64.media.tumblr.com/e26147f7d725be1bdf271833465c6b02/de62e5ead274760f-13/s400x600/a4e13ca012f2360235f1d3c8822daa838d6d6eff.jpg'
      ],
    },
    {
      'tag_id': 1212,
      'tag_name': 'Test Tag 4',
      'tag_slug': 'Test Tag 4',
      'post_views': [
        'https://64.media.tumblr.com/a9ff82d660b038a98c2f995889d92450/65cec8f252625e24-ed/s400x600/0d3aafd1ecb3cc3e696c899a7a2f331bef40bb21.png'
      ],
    },
  ];

  static Future<List<Map>> getFollowedTags() async {
    if (Flags.mock) {
      return Future.delayed(
          const Duration(seconds: 1), () => tagsYouFollowMockData);
    } else {
      final rawResponse = await CMPLRService.get(GetURIs.followedTags, {});
      if (rawResponse.statusCode == CMPLRService.requestSuccess) {
        final bodyMap = jsonEncode(rawResponse.body) as Map;
        return bodyMap['response']['tags'];
      } else
        return [];
    }
  }
}
