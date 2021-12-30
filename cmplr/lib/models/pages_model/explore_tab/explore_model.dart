// ignore_for_file: unnecessary_string_escapes

import 'dart:async';
import 'dart:convert';

import '../../../backend_uris.dart';
import '../../../flags.dart';
import '../../cmplr_service.dart';

/// Holds mock data and interfaces with the backend.
///
/// Responsible for fetching of the explore screen's data.
class ExploreModel {
  static Future<List<dynamic>> getTagsYouFollow() async {
    if (Flags.mock) {
      return Future.delayed(
          const Duration(seconds: 1), () => tagsYouFollowMockData);
    } else {
      final rawResponse = await CMPLRService.get(GetURIs.tagsYouFollow, {});
      if (rawResponse.statusCode == CMPLRService.requestSuccess) {
        final bodyMap = jsonDecode(rawResponse.body) as Map;
        return bodyMap['response'];
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

  static Future<List> getTryThesePosts() async {
    if (Flags.mock) {
      return Future.delayed(
          const Duration(seconds: 3), () => tryThesePostsMockData);
    } else {
      final rawResponse = await CMPLRService.get(GetURIs.tryThesePosts, {});
      if (rawResponse.statusCode == CMPLRService.requestSuccess) {
        final bodyMap = jsonDecode(rawResponse.body) as Map;
        return bodyMap['response']['post'];
      } else {
        return [];
      }
    }
  }

  static final tagsYouFollowMockData = [
    {
      'test_id': 0,
      'tag_id': 12,
      'name': 'Test Tag 1',
      'slug': 'Test Tag 1',
      'posts_views': [
        {
          'link':
              'https://64.media.tumblr.com/ffbb3a853b2e35ba0cf9a4ceea35f084/011c36db4adfbc03-f7/s640x960/2904c0ed277b4a94b417a3cb57d8fc571e7d10a1.jpg'
        }
      ],
    },
    {
      'test_id': 1,
      'tag_id': 69,
      'name': 'Test Tag 2',
      'slug': 'Test Tag 2',
      'posts_views': [
        {
          'link':
              'https://64.media.tumblr.com/ec1771be19d696cfdd02876076351d32/011c36db4adfbc03-66/s400x600/c903540d69f06fb1fed4a53ce7d41c83327b986b.png'
        }
      ],
    },
    {
      'test_id': 2,
      'post_id': 420,
      'name': 'Test Tag 3',
      'slug': 'Test Tag 3',
      'posts_views': [
        {
          'link':
              'https://64.media.tumblr.com/e26147f7d725be1bdf271833465c6b02/de62e5ead274760f-13/s400x600/a4e13ca012f2360235f1d3c8822daa838d6d6eff.jpg'
        }
      ],
    },
    {
      'test_id': 3,
      'tag_id': 1212,
      'name': 'Test Tag 4',
      'slug': 'Test Tag 4',
      'posts_views': [
        {
          'link':
              'https://64.media.tumblr.com/a9ff82d660b038a98c2f995889d92450/65cec8f252625e24-ed/s400x600/0d3aafd1ecb3cc3e696c899a7a2f331bef40bb21.png'
        }
      ],
    },
  ];

  static final checkOutTheseTagsMockData = [
    {
      'test_id': 0,
      'tag_id': 23,
      'posts_views': [
        {
          'link':
              'https://64.media.tumblr.com/c3165ebd9c1fbbfcb9ee2282debae9de/b14f71f1c6109186-93/s540x810/b8d7676377233009b10428fc9546487fc0c14126.jpg'
        },
        {
          'link':
              'https://64.media.tumblr.com/7ad94a0f1f2e1c0c9cb00d6fed72edf9/b14f71f1c6109186-83/s540x810/3de33fae7a449390f856d243236d8c910ecd402b.png'
        }
      ],
      'tag_name': 'Test tag',
      'tag_slug': 'Test tag',
    },
    {
      'test_id': 1,
      'tag_id': 43,
      'posts_views': [
        {
          'link':
              'https://64.media.tumblr.com/2e2813ef0edfe7c0a9c8478b4b25ece5/b14f71f1c6109186-aa/s540x810/7ca399aa9a3e3b78d49a512bb338d12ff93009c3.jpg'
        },
        {
          'link':
              'https://64.media.tumblr.com/9410f22a29285fbdc65d884bc5054d56/b14f71f1c6109186-5e/s540x810/56c69ed615e2cb5afebdfa1cce95aacd0ed0d1ae.jpg'
        }
      ],
      'tag_name': 'Test tag',
      'tag_slug': 'Test tag',
    },
    {
      'test_id': 2,
      'tag_id': 66,
      'posts_views': [
        {
          'link':
              'https://64.media.tumblr.com/5d9e0997337264f1f0d99a6c30dc41dc/b14f71f1c6109186-a6/s540x810/c5ff288763620cb4331dcdcca9e5059309ef4e43.png'
        },
        {
          'link':
              'https://64.media.tumblr.com/a18c8063bf9d095d99f12b51d3dd1eda/57803298a6ae7123-0a/s540x810/35b1580573afd7e8d52a33546e021c3df27778b3.gif'
        }
      ],
      'tag_name': 'Test tag',
      'tag_slug': 'Test tag',
    },
    {
      'test_id': 3,
      'tag_id': 43241,
      'posts_views': [
        {
          'link':
              'https://64.media.tumblr.com/fd654c32f041cb02c757b5646c1cf9e1/a4c5782524284f82-d5/s540x810/dc9b214a0dd3612a3e1154c725ec175ad9921fe9.jpg'
        },
        {
          'link':
              'https://64.media.tumblr.com/439b77661f74cea5af5559a392dfe505/573d1660335efd03-4e/s540x810/46e78fb5a9f5e7d91352cf6c1ef016977aada3dc.jpg'
        }
      ],
      'tag_name': 'Test tag',
      'tag_slug': 'Test tag',
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

  static final tryThesePostsMockData = [
    {
      'post': {
        'post_id': 9,
        'type': 'text',
        'state': 'publish',
        'title': null,
        'content':
            '<img src=\'https://64.media.tumblr.com/7a9525e72f6cbcb7075588984f3389ae/b9bba28b99b572fc-29/s400x600/ddccd44807f1491258124b8acf4748b62632fdd7.jpg\'> <h1>Come on!\' So they sat down.</h1><p>Qui aut iste natus. Ipsum possimus enim veniam. Consequuntur accusamus aspernatur animi unde ab quos voluptas. Culpa neque autem fugit asperiores sequi.</p><p>Nisi in eaque amet in asperiores non. Qui minus voluptatem nostrum voluptates minima. Magni voluptatem eos sed dolor tenetur quis.</p><p>Animi iure sapiente debitis. Perspiciatis tempora saepe totam aperiam et. Voluptatum illo nam sit quidem. Qui molestiae dignissimos unde qui.</p><p>Occaecati occaecati suscipit illo aut eos esse aut. Suscipit suscipit dolorem autem alias sed vel. Aperiam molestiae ad aut voluptas commodi architecto. Et rerum ab dicta sit est.</p><p>Accusamus aut quaerat sequi ex. Fuga porro non qui perferendis. Ad ut ut fuga quibusdam fuga. Et consequuntur nobis adipisci.</p>',
        'date': 'Tuesday, 28-Dec-21 13:38:46 UTC',
        'source_content': '5BQwPuLuSb',
        'tags': ['summer', 'winter'],
        'is_liked': false,
        'notes_count': 21,
        'is_mine': false
      },
      'blog': {
        'blog_id': 7,
        'blog_name': 'quia',
        'avatar':
            'https://assets.tumblr.com/images/default_avatar/cone_closed_128.png',
        'avatar_shape': 'circle',
        'replies': 'everyone',
        'follower': false
      },
    },
    {
      'post': {
        'post_id': 73,
        'type': 'text',
        'state': 'publish',
        'title': null,
        'content':
            '<img src=\'https://64.media.tumblr.com/234c2c6770d789e37b8eeaa797a8f60d/3271277c18d42cad-0e/s400x600/145f521c44bdb261fda331f004fb8f6c2e34520f.png\'>',
        'date': 'Tuesday, 28-Dec-21 19:58:41 UTC',
        'source_content': null,
        'tags': [],
        'is_liked': false,
        'notes_count': 0,
        'is_mine': false
      },
      'blog': {
        'blog_id': 20,
        'blog_name': 'xaaq',
        'avatar':
            'https://assets.tumblr.com/images/default_avatar/cone_closed_128.png',
        'avatar_shape': 'circle',
        'replies': 'everyone',
        'follower': false
      },
    },
    {
      'post': {
        'post_id': 49,
        'type': 'audio',
        'state': 'publish',
        'title': null,
        'content':
            '<h1>Alice, \'it\'ll never do to.</h1><p>Vel est perferendis similique. Ea animi ea et quia. Aut temporibus iste sit rerum molestiae sit.</p><p>Et animi modi maxime quas libero. Cupiditate eum quia debitis aut omnis. Enim voluptatem aut facere cumque in.</p><p>Libero velit voluptatum delectus recusandae consequatur accusantium. Vitae consequuntur ratione error unde quia dolor delectus.</p><p>Repellendus et in ullam perferendis velit suscipit repellendus. Autem minima perspiciatis architecto adipisci et perferendis sit. Sit placeat iure dicta officia.</p><p>Ipsa doloremque voluptas eligendi voluptatem ipsam aut doloribus. At eum rem accusantium. Officiis est modi recusandae sunt exercitationem repudiandae fugit. Rem veniam doloremque rerum sit.</p>',
        'date': 'Tuesday, 28-Dec-21 13:38:46 UTC',
        'source_content': 'nviht0voNY',
        'tags': ['summer', 'winter'],
        'is_liked': false,
        'notes_count': 18,
        'is_mine': false
      },
      'blog': {
        'blog_id': 3,
        'blog_name': 'sed',
        'avatar':
            'https://assets.tumblr.com/images/default_avatar/cone_closed_128.png',
        'avatar_shape': 'circle',
        'replies': 'everyone',
        'follower': false
      }
    },
    {
      'post': {
        'post_id': 66,
        'type': 'text',
        'state': 'publish',
        'title': 'faw',
        'content':
            'gwaaa<img src=\'https://cmplrserver.s3.eu-west-2.amazonaws.com/images/1640715915_17_Killua-Featured.jpg\'>',
        'date': 'Tuesday, 28-Dec-21 18:25:24 UTC',
        'source_content': null,
        'tags': [],
        'is_liked': false,
        'notes_count': 2,
        'is_mine': false
      },
      'blog': {
        'blog_id': 17,
        'blog_name': 'de7kuuuuu',
        'avatar':
            'https://assets.tumblr.com/images/default_avatar/cone_closed_128.png',
        'avatar_shape': 'circle',
        'replies': 'everyone',
        'follower': false
      }
    },
    {
      'post': {
        'post_id': 60,
        'type': 'text',
        'state': 'publish',
        'title': 'الزعامة اتنين',
        'content':
            '<img src=\'https://cmplrserver.s3.eu-west-2.amazonaws.com/images/1640714114_16_DhAcqQcW0AAL8CG.jpg\'>',
        'date': 'Tuesday, 28-Dec-21 17:55:21 UTC',
        'source_content': null,
        'tags': [],
        'is_liked': false,
        'notes_count': 3,
        'is_mine': false
      },
      'blog': {
        'blog_id': 16,
        'blog_name': '3bhamed',
        'avatar':
            'https://assets.tumblr.com/images/default_avatar/cone_closed_128.png',
        'avatar_shape': 'circle',
        'replies': 'everyone',
        'follower': false
      },
    },
    {
      'post': {
        'post_id': 1212,
        'type': 'text',
        'state': 'publish',
        'title': 'faw',
        'content':
            'gwaaa<img src=\'https://64.media.tumblr.com/1ee268f86e5e7b896526c5bb2630e22f/d45ecdd0931c6bbe-1c/s400x600/b9c2b59abb9df9a535c27dcce9a31e0dd575cc90.jpg\'>',
        'date': 'Tuesday, 28-Dec-21 18:25:24 UTC',
        'source_content': null,
        'tags': [],
        'is_liked': false,
        'notes_count': 23,
        'is_mine': false
      },
      'blog': {
        'blog_id': 9809,
        'blog_name': 'KAK',
        'avatar':
            'https://assets.tumblr.com/images/default_avatar/cone_closed_128.png',
        'avatar_shape': 'circle',
        'replies': 'everyone',
        'follower': false
      }
    },
    {
      'post': {
        'post_id': 6126,
        'type': 'text',
        'state': 'publish',
        'title': 'faw',
        'content':
            'gwaaa<img src=\'https://64.media.tumblr.com/194e199bff1b21ca401eabd12d974d8a/cbda3ca550417d25-c4/s400x600/017b70610453f07003c0b5be7e5096087072e8e8.jpg\'>',
        'date': 'Tuesday, 28-Dec-21 18:25:24 UTC',
        'source_content': null,
        'tags': [],
        'is_liked': false,
        'notes_count': 2,
        'is_mine': false
      },
      'blog': {
        'blog_id': 11287,
        'blog_name': 'Please Help',
        'avatar':
            'https://assets.tumblr.com/images/default_avatar/cone_closed_128.png',
        'avatar_shape': 'circle',
        'replies': 'everyone',
        'follower': false
      }
    },
    {
      'post': {
        'post_id': 213166,
        'type': 'text',
        'state': 'publish',
        'title': 'faw',
        'content':
            'gwaaa<img src=\'https://64.media.tumblr.com/1e8434b79a91d952441723e2a79199f1/4ba5b7fbe0ab7855-56/s400x600/1be0bb6b2b18cee3e5ed2e955d3797897cb34b81.gifv\'>',
        'date': 'Tuesday, 28-Dec-21 18:25:24 UTC',
        'source_content': null,
        'tags': [],
        'is_liked': false,
        'notes_count': 2,
        'is_mine': false
      },
      'blog': {
        'blog_id': 12137,
        'blog_name': 'Suffering',
        'avatar':
            'https://assets.tumblr.com/images/default_avatar/cone_closed_128.png',
        'avatar_shape': 'circle',
        'replies': 'everyone',
        'follower': false
      }
    },
    {
      'post': {
        'post_id': 2166,
        'type': 'text',
        'state': 'publish',
        'title': 'faw',
        'content':
            'gwaaa<img src=\'https://64.media.tumblr.com/c4cc9af07e29af7310cf0e152cfa88f8/21614c182a3165eb-64/s400x600/b2ec067085ff125fa6faffc4ab8dc169a2a17acf.gifv\'>',
        'date': 'Tuesday, 28-Dec-21 18:25:24 UTC',
        'source_content': null,
        'tags': [],
        'is_liked': false,
        'notes_count': 2,
        'is_mine': false
      },
      'blog': {
        'blog_id': 137,
        'blog_name': '"Engineering"',
        'avatar':
            'https://assets.tumblr.com/images/default_avatar/cone_closed_128.png',
        'avatar_shape': 'circle',
        'replies': 'everyone',
        'follower': false
      }
    },
  ];

  static final thingsWeCareAboutMockData = [
    {
      'background_url':
          'https://64.media.tumblr.com/fc312aa74bcd0a17b25b934c91e8308d/ccc4e7351a7303c7-8f/s400x600/a450f7061efad2ccba0aed2f6bf0e12b4bb34424.jpg',
      'tag_name': 'Kot',
    },
    {
      'background_url':
          'https://64.media.tumblr.com/3f4815d42f2b66b895ec291cc3713c50/fc6dc77e7398caa9-1f/s250x400/183391398d073f7b6f925a42cfe39a474e25d5f2.gifv',
      'tag_name': 'Linux',
    },
    {
      'background_url':
          'https://64.media.tumblr.com/14639d89ae7f5aaac8357693f42af78b/e1666fecb49ab382-8f/s400x600/bd15b7568b38d44ea5450050da0b9b868a420238.jpg',
      'tag_name': 'Jetstream Sam',
    },
    {
      'background_url':
          'https://64.media.tumblr.com/3e4b9f462786881d444afbc75bd6800f/7417c9c24e07a800-dc/s400x600/2792e14ba44adaf1fdb704be21996ac54527a6c8.png',
      'tag_name': '2B',
    },
  ];
}
