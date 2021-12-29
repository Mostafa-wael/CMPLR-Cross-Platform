import 'dart:async';
import 'dart:convert';

import '../../../backend_uris.dart';
import '../../../flags.dart';
import '../../cmplr_service.dart';

class ExploreModel {
  static Future<List<Map>> getTagsYouFollow() async {
    if (Flags.mock) {
      return Future.delayed(
          const Duration(seconds: 1), () => tagsYouFollowMockData);
    } else {
      final rawResponse = await CMPLRService.get(GetURIs.tagsYouFollow, {});
      if (rawResponse.statusCode == CMPLRService.requestSuccess) {
        final bodyMap = jsonDecode(rawResponse.body) as Map;
        return bodyMap['response']['tags'];
      } else
        return [];
    }
  }

  static Future<List> getCheckOutTheseTags() async {
    if (Flags.mock) {
      return Future.delayed(
          const Duration(seconds: 2), () => checkOutTheseTagsMockData);
    } else {
      final rawResponse = await CMPLRService.get(GetURIs.checkOutTheseTags, {});
      if (rawResponse.statusCode == CMPLRService.requestSuccess) {
        final bodyMap = jsonDecode(rawResponse.body) as Map;
        return bodyMap['response']['tags'];
      } else
        return [];
    }
  }

  static Future<List> getCheckOutTheseBlogs() async {
    if (Flags.mock) {
      return Future.delayed(
          const Duration(milliseconds: 500), () => checkOutTheseBlogsMockData);
    } else {
      final rawResponse =
          await CMPLRService.get(GetURIs.checkOutTheseBlogs, {});
      if (rawResponse.statusCode == CMPLRService.requestSuccess) {
        final bodyMap = jsonDecode(rawResponse.body) as Map;
        return bodyMap['response']['blogs'];
      } else
        return [];
    }
  }

  static final tagsYouFollowMockData = [
    {
      'test_id': 0,
      'tag_id': 12,
      'tag_name': 'Test Tag 1',
      'tag_slug': 'Test Tag 1',
      'posts_views': [
        'https://64.media.tumblr.com/ffbb3a853b2e35ba0cf9a4ceea35f084/011c36db4adfbc03-f7/s640x960/2904c0ed277b4a94b417a3cb57d8fc571e7d10a1.jpg'
      ],
    },
    {
      'test_id': 1,
      'tag_id': 69,
      'tag_name': 'Test Tag 2',
      'tag_slug': 'Test Tag 2',
      'posts_views': [
        'https://64.media.tumblr.com/ec1771be19d696cfdd02876076351d32/011c36db4adfbc03-66/s400x600/c903540d69f06fb1fed4a53ce7d41c83327b986b.png'
      ],
    },
    {
      'test_id': 2,
      'post_id': 420,
      'tag_name': 'Test Tag 3',
      'tag_slug': 'Test Tag 3',
      'posts_views': [
        'https://64.media.tumblr.com/e26147f7d725be1bdf271833465c6b02/de62e5ead274760f-13/s400x600/a4e13ca012f2360235f1d3c8822daa838d6d6eff.jpg'
      ],
    },
    {
      'test_id': 3,
      'tag_id': 1212,
      'tag_name': 'Test Tag 4',
      'tag_slug': 'Test Tag 4',
      'posts_views': [
        'https://64.media.tumblr.com/a9ff82d660b038a98c2f995889d92450/65cec8f252625e24-ed/s400x600/0d3aafd1ecb3cc3e696c899a7a2f331bef40bb21.png'
      ],
    },
  ];

  static final checkOutTheseTagsMockData = [
    {
      'test_id': 0,
      'tag_id': 23,
      'posts_views': [
        'https://64.media.tumblr.com/c3165ebd9c1fbbfcb9ee2282debae9de/b14f71f1c6109186-93/s540x810/b8d7676377233009b10428fc9546487fc0c14126.jpg',
        'https://64.media.tumblr.com/7ad94a0f1f2e1c0c9cb00d6fed72edf9/b14f71f1c6109186-83/s540x810/3de33fae7a449390f856d243236d8c910ecd402b.png'
      ],
      'tag_name': 'Test tag',
      'tag_slug': 'Test tag',
    },
    {
      'test_id': 1,
      'tag_id': 43,
      'posts_views': [
        'https://64.media.tumblr.com/2e2813ef0edfe7c0a9c8478b4b25ece5/b14f71f1c6109186-aa/s540x810/7ca399aa9a3e3b78d49a512bb338d12ff93009c3.jpg',
        'https://64.media.tumblr.com/9410f22a29285fbdc65d884bc5054d56/b14f71f1c6109186-5e/s540x810/56c69ed615e2cb5afebdfa1cce95aacd0ed0d1ae.jpg'
      ],
      'tag_name': 'Test tag',
      'tag_slug': 'Test tag',
    },
    {
      'test_id': 2,
      'tag_id': 66,
      'posts_views': [
        'https://64.media.tumblr.com/5d9e0997337264f1f0d99a6c30dc41dc/b14f71f1c6109186-a6/s540x810/c5ff288763620cb4331dcdcca9e5059309ef4e43.png',
        'https://64.media.tumblr.com/a18c8063bf9d095d99f12b51d3dd1eda/57803298a6ae7123-0a/s540x810/35b1580573afd7e8d52a33546e021c3df27778b3.gif'
      ],
      'tag_name': 'Test tag',
      'tag_slug': 'Test tag',
      'tag_url': 'https://www.tumblr.com',
    },
    {
      'test_id': 3,
      'tag_id': 43241,
      'posts_views': [
        'https://64.media.tumblr.com/fd654c32f041cb02c757b5646c1cf9e1/a4c5782524284f82-d5/s540x810/dc9b214a0dd3612a3e1154c725ec175ad9921fe9.jpg',
        'https://64.media.tumblr.com/439b77661f74cea5af5559a392dfe505/573d1660335efd03-4e/s540x810/46e78fb5a9f5e7d91352cf6c1ef016977aada3dc.jpg'
      ],
      'tag_name': 'Test tag',
      'tag_slug': 'Test tag',
      'tag_url': 'https://www.tumblr.com',
    },
  ];

  static final checkOutTheseBlogsMockData = [
    {
      'test_id': 0,
      'blog_id': 12,
      'blog_name': 'AAAAA',
      'title': 'Pain,',
      'avatar':
          'https://64.media.tumblr.com/7c639466082be78cf3fc2f36c91c4d6e/c3101cc497330567-18/s128x128u_c1/1ccf730b27f200ada0f180c9831c85edaa9b1b98.jpg',
      'avatar_shape': 'circle',
      'header_image':
          'https://64.media.tumblr.com/910534a51d1a0aaac19118a4070b15c9/c3101cc497330567-c3/s2048x3072/ad5469f6d5f1d88447c2872fafd19ad3906b0bdb.jpg',
      'description': null,
      'background_color': 'white',
    },
    {
      'test_id': 1,
      'blog_id': 17381,
      'blog_name': 'KAK',
      'title': 'KAK',
      'avatar':
          'https://64.media.tumblr.com/3ac39cb04388f6cbd92c62340f10763d/507eb9043a64a789-8a/s96x96u_c1/f8f4dc4fe57c63836a00360ac5c4171bc09b71af.pnj',
      'avatar_shape': 'circle',
      'header_image':
          'https://64.media.tumblr.com/31d08c312828053eda871ef6ce6158cb/507eb9043a64a789-8d/s2048x3072_c7800,48200,67600,81867/999fb2a528e600514669ca6ec402cb125b6935f4.jpg',
      'description': null,
      'background_color': 'white',
    },
    {
      'test_id': 2,
      'blog_id': 719283,
      'blog_name': 'Storm',
      'title': 'That is approaching',
      'avatar':
          'https://64.media.tumblr.com/a48f0eda406e341451619fe9f04c33f8/d3bf61f3bf912169-dc/s96x96u_c1/27ec1dd59dfac2ff7a040e734e2c240a433ce83f.jpg',
      'avatar_shape': 'circle',
      'header_image':
          'https://64.media.tumblr.com/83f27684eeb6831a76f8a8c1e6d5d9f4/d3bf61f3bf912169-ed/s2048x3072_c6780,8114,93179,91815/6cf1fdb16c5b5409a1b2f402e1db7edf80968140.jpg',
      'description': null,
      'background_color': 'white',
    },
    {
      'test_id': 3,
      'blog_id': 16371,
      'blog_name': 'Bruh why is my name so long',
      'title': 'It ain\'t even cool',
      'avatar':
          'https://64.media.tumblr.com/07b377bffb90d3226d18be619383dfa5/fdced055d48f80f2-3a/s96x96u_c1/1df25d1bfd780ccef2686dd793a6e6f5722236c0.jpg',
      'avatar_shape': 'circle',
      'header_image':
          'https://64.media.tumblr.com/8ed48312e7af1551b5750278439cbd3d/fdced055d48f80f2-ed/s2048x3072_c0,7692,100000,88064/46ed7e90fcea44eaae57e3e550e31791f262fd5e.jpg',
      'description': null,
      'background_color': 'white',
    },
  ];
}
