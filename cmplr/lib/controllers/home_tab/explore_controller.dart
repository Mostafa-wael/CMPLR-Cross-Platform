import 'dart:convert';
import 'dart:math';

import '../../models/pages_model/explore_tab/explore_model.dart';

import '../../models/cmplr_service.dart';

import '../../backend_uris.dart';
import '../../views/views.dart';

import '../../views/explore_tab/search_results_view.dart';

import '../../views/utilities/hashtag_posts_view.dart';
import '../../utilities/custom_widgets/trending_row.dart';

import '../../utilities/custom_widgets/check_out_these_tags_element.dart';
import '../../utilities/custom_widgets/text_on_image.dart';
import '../../utilities/sizing/sizing.dart';
import '../../flags.dart';

import 'check_out_these_blogs_element.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

class ExploreController extends GetxController {
  static const elementWidthPercentage = 30.0;
  final scrollController = ScrollController();
  final tagsYouFollowHeight = Sizing.blockSizeVertical * 10.0;
  final checkOutTheseTagsHeight = Sizing.blockSizeVertical * 20;
  final checkOutTheseBlogsHeight = Sizing.blockSizeVertical * 20;
  final blogImgRadius = Sizing.blockSize * 5;
  final blogNameCenterHeightFactor = 0.6;

  var tagsYouFollow = <Widget>[];

  Widget? getAppBarBackground() {
    if (Flags.mock) {
      return FadeInImage.assetNetwork(
          placeholder: placeHolders[math.Random().nextInt(placeHolders.length)],
          image:
              'https://64.media.tumblr.com/86aed1e9b1106498e4d4d1fe8a54b239/85e04bde816e1285-b2/s500x750/bac8027b6d5a996cb402bad8b351b18735042740.gifv');
    } else
      // TODO: API Integration
      return null;
  }

  Future<void> search() async {
    Get.to(const SearchResultsView());
  }

  void getTagsYouFollow() async {
    // There should be a list of posts in the response entry of the map
    // Each tag should have the keys: tag_id, tag_name, tag_slug post_views
    //                                int,    string,   string,  string arr
    final tagsYouFollow = await ExploreModel.getFollowedTags();
    final tyfWidgets = <Widget>[];
    for (final tag in tagsYouFollow) {
      final otherData = Map.from(tag);
      final List postViews = tag['post_views'];

      tyfWidgets.add(TextOnImage(
        otherData: otherData,
        width: Sizing.blockSize * elementWidthPercentage,
        height: tagsYouFollowHeight,
        backgroundURL: postViews[Random().nextInt(postViews.length)],
        text: tag['tag_name'],
        borderRadius: BorderRadius.circular(Sizing.blockSize),
        onTap: () {
          Get.to(const HashtagPosts(), arguments: tag['tag_name']);
        },
      ));
    }
    this.tagsYouFollow = tyfWidgets;
    update();
  }

  List<Widget> getCheckOutTheseTags() {
    if (Flags.mock) {
      const widthPercentage = 30, borderRadiusFactor = 1;
      final checkOutTheseTagsList = <Widget>[];

      var colorIndex = 0;
      for (var i = 0; i < checkOutTheseTagsMockData.length; i++) {
        final cott = checkOutTheseTagsMockData[i];
        checkOutTheseTagsList.add(CheckOutTheseTagsElement(
            gestureDetectorKey: ValueKey('CheckOutTheseTags$i'),
            width: Sizing.blockSize * widthPercentage,
            height: checkOutTheseTagsHeight,
            borderRadius: Sizing.blockSize * borderRadiusFactor,
            imgOneURL: cott['img_one_url'],
            imgTwoURL: cott['img_two_url'],
            tagName: cott['tag_name'],
            tagURL: cott['tag_url'],
            followed: cott['followed'],
            widgetColor: clrs[(colorIndex++ % clrs.length)]));
      }
      return checkOutTheseTagsList;
    } else
      return [];
  }

  List<Widget> getCheckOutTheseBlogs() {
    if (Flags.mock) {
      final cotbList = <Widget>[];
      var colorIndex = 0;

      for (var i = 0; i < checkOutTheseBlogsMockData.length; i++) {
        final cotb = checkOutTheseBlogsMockData[i];
        cotbList.add(CheckOutTheseBlogsElement(
          gestureDetectorKey: ValueKey('CheckOutTheseBlogs$i'),
          width: Sizing.blockSize * 30,
          height: checkOutTheseBlogsHeight,
          borderRadius: Sizing.blockSize * 2,
          blogName: cotb['blog_name'],
          blogImgURL: cotb['blog_img_url'],
          blogBgURL: cotb['blog_bg_url'],
          blogURL: cotb['blog_url'],
          blogImgRadius: blogImgRadius,
          blogImgCenterHeightFactor: blogNameCenterHeightFactor,
          widgetColor: clrs.reversed.toList()[colorIndex++ % clrs.length],
        ));
      }
      return cotbList;
    } else
      // TODO: API Integration
      return [];
  }

  List<Widget> getTrending() {
    if (Flags.mock) {
      final trendingRows = <TrendingRow>[];

      for (final Map item in trendingNowMockData) {
        final trendingTags = <Widget>[];
        final trendingPosts = <Widget>[];

        for (final trendTag in item['trend_tags']) {
          trendingTags.add(Padding(
            padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
            child: Text(trendTag),
          ));
        }

        final double width = Sizing.blockSize * 20,
            height = Sizing.blockSizeVertical * 2;

        const maxTextRows = 3;

        for (final Map trendPost in item['trend_posts']) {
          String? text = null, imgURL = null;

          if (trendPost.containsKey('img_url') && !trendPost['img_url'].isEmpty)
            imgURL = trendPost['img_url'];
          else if (trendPost.containsKey('text') && !trendPost['text'].isEmpty)
            text = trendPost['text'];

          trendingPosts.add(TextOnImage(
            width: width,
            height: height,
            text: text,
            backgroundURL: imgURL,
            maxTextRows: maxTextRows,
          ));
        }

        trendingRows.add(TrendingRow(
          rowNum: item['trend_number'],
          trendName: item['trend_name'],
          trendTags: trendingTags,
          trendPosts: trendingPosts,
          circleColor: clrs[math.Random().nextInt(clrs.length)],
        ));
      }

      return trendingRows;
    } else

      // TODO: API Integration
      return [];
  }

  bool handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification) {
      if (scrollController.position.extentAfter == 0) {
        print('Should load more');
        // final cont = Get.find<ExploreController>();

        update();
      }
    }
    return false;
  }

  Widget getTryThesePostsGrid() {
    if (Flags.mock) {
      final ttpList = <Widget>[];

      //
      for (final ttp in tryThesePostsMockData) {
        ttpList.add(
          FadeInImage.assetNetwork(
            placeholder:
                placeHolders[math.Random().nextInt(placeHolders.length)],
            image: ttp,
            fit: BoxFit.cover,
          ),
        );
      }
      return GestureDetector(
        key: const ValueKey('TryThesePostsGrid'),
        child: GridView.count(
          padding: EdgeInsets.zero,
          primary: false,
          shrinkWrap: true,
          crossAxisCount: 3,
          semanticChildCount: 9,
          children: ttpList,
        ),
        onTap: goToTryThesePosts,
      );
    } else
      // TODO: API Integration
      return Container(
        decoration: const BoxDecoration(color: Colors.red),
      );
  }

  List<Widget> getThingsWeCareAbout() {
    if (Flags.mock) {
      final twcaList = <Widget>[];
      for (var i = 0; i < thingsWeCareAboutMockData.length; i++) {
        final twca = thingsWeCareAboutMockData[i];
        twcaList.add(
          TextOnImage(
            gestureDetectorKey: ValueKey('ThingsWeCareAbout$i'),
            backgroundURL: twca['background_url'],
            text: twca['tag_name'],
            width: Sizing.blockSize * 30,
            height: tagsYouFollowHeight,
            borderRadius: BorderRadius.circular(Sizing.blockSize),
            onTap: () {
              Get.to(const HashtagPosts(), arguments: twca['tag_name']);
            },
          ),
        );
      }
      return twcaList;
    } else
      // TODO: API Integration
      return [];
  }

  final clrs = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.white,
    Colors.cyan,
    Colors.amber,
    Colors.purple,
    Colors.brown,
    Colors.deepOrange,
    Colors.indigo,
    Colors.lime,
    Colors.orange,
    Colors.pink,
    Colors.teal,
    Colors.yellow,
  ];

  final placeHolders = [
    'lib/utilities/assets/intro_screen/intro_1.gif',
    'lib/utilities/assets/intro_screen/intro_2.gif',
    'lib/utilities/assets/intro_screen/intro_3.jpg',
    'lib/utilities/assets/intro_screen/intro_4.jpg',
    'lib/utilities/assets/intro_screen/intro_5.gif',
  ];

  final trendingNowMockData = [
    {
      'trend_number': '1',
      'trend_name': 'spooderman',
      'trend_tags': [
        'Bruh',
        'AAAAAAAAAAAAAAAAA',
        'Nice',
        'LMFAO',
        'Sleepy',
        'Joyous',
        'Playful',
        'Funny',
      ],
      'trend_posts': [
        {
          'text': '',
          'img_url':
              'https://64.media.tumblr.com/fdf18308cbc8022156e28a4043b6e399/65870db942a6dfc9-e5/s400x600/554d4a6d71c5c4e9bf9876b555d4fc340762cf16.jpg'
        },
        {
          'text': '',
          'img_url':
              'https://64.media.tumblr.com/228235421f0013749f6c82fbc7c15883/58bea72f16b6a7c1-35/s400x600/900f6d8d5d046e3d7e7b9cc5ec1b74652aa82795.gif'
        },
        {'text': 'lmao shit movie nuke it out of the orbit', 'img_url': ''},
        {'text': 'RELEASE ME', 'img_url': ''},
        {
          'text': '',
          'img_url':
              'https://64.media.tumblr.com/c662366310ad69cab5c7e658154f5960/9620209f70bb3d5f-dd/s400x600/9e2cbffb22ee3772f3198eca1cc156fb259fcf17.png'
        },
      ]
    },
    {
      'trend_number': '2',
      'trend_name': 'the witcher',
      'trend_tags': [
        'witcher',
        'geralt',
        'siri',
        'fantasy',
        'roleplay',
        'rpg',
        'vampire',
        'middle age',
      ],
      'trend_posts': [
        {
          'text': '',
          'img_url':
              'https://64.media.tumblr.com/1fd5d310d756710ee532118bd6b08fbc/a22311ec2c2a5c8a-26/s400x600/ff5914e6cc98441267e91ca76865221a910c12e5.jpg'
        },
        {
          'text': 'the fact that jaskier is practically on the verge of tears',
          'img_url': ''
        },
        {
          'text': '',
          'img_url':
              'https://64.media.tumblr.com/ee283a033460dce4d1f9cd61aa08dfac/53cf637f41312d2a-2a/s400x600/4ab14353cdf4a8e5459bf5e24af8c2501fbd679b.gifv'
        },
        {
          'text': 'wItChErS cAnT sHoW eMoTiOn THIS MAN WAS D I S T R A U G H T',
          'img_url': ''
        },
        {
          'text': '',
          'img_url':
              'https://64.media.tumblr.com/c29de60aa46fdc7f214e03cebef49a19/a191a66d4e721c04-9a/s400x600/a294220dd8d442baff2a9063a53e4ab69a70f92a.gifv'
        },
      ]
    },
    {
      'trend_number': '3',
      'trend_name': 'avengers',
      'trend_tags': [
        'tony stark',
        'spooderman',
        'iron man',
        'thor',
        'hawkeye',
        'hulk',
        'fantastic four',
        'ultron',
      ],
      'trend_posts': [
        {
          'text':
              '"I' 'm going to be really aphobic and do some mental gymnast',
          'img_url': ''
        },
        {
          'text': '',
          'img_url':
              'https://64.media.tumblr.com/635d82a13b822afbe134567267ffd724/be836f73814357b3-06/s400x600/65ead256f3915820e4cf25dfde3091db9edae830.gifv'
        },
        {
          'text': '',
          'img_url':
              'https://64.media.tumblr.com/d6f2a006f88aab7f46a511093d5f0482/375bafd7d766bd05-36/s400x600/7dc79f4106b1b38ac44628f5a2fae646bf2dcc4f.png'
        },
        {
          'text': '',
          'img_url':
              'https://64.media.tumblr.com/9fee2821dbc9c391087563b665ce9846/e9a8f85f7e3fa337-2a/s400x600/8b0b6ac567a4d7589edd8c449157e0037100a6cf.gifv'
        },
        {
          'text': 'Avengers Forever #1 Preview\nAvengers Forever #1 Preview',
          'img_url': ''
        },
      ]
    }
  ];

  final checkOutTheseTagsMockData = [
    {
      'img_one_url':
          'https://64.media.tumblr.com/c3165ebd9c1fbbfcb9ee2282debae9de/b14f71f1c6109186-93/s540x810/b8d7676377233009b10428fc9546487fc0c14126.jpg',
      'img_two_url':
          'https://64.media.tumblr.com/7ad94a0f1f2e1c0c9cb00d6fed72edf9/b14f71f1c6109186-83/s540x810/3de33fae7a449390f856d243236d8c910ecd402b.png',
      'tag_name': 'Test tag',
      'tag_url': 'https://www.tumblr.com',
      'followed': 'true',
    },
    {
      'img_one_url':
          'https://64.media.tumblr.com/2e2813ef0edfe7c0a9c8478b4b25ece5/b14f71f1c6109186-aa/s540x810/7ca399aa9a3e3b78d49a512bb338d12ff93009c3.jpg',
      'img_two_url':
          'https://64.media.tumblr.com/9410f22a29285fbdc65d884bc5054d56/b14f71f1c6109186-5e/s540x810/56c69ed615e2cb5afebdfa1cce95aacd0ed0d1ae.jpg',
      'tag_name': 'Test tag',
      'tag_url': 'https://www.tumblr.com',
      'followed': 'false',
    },
    {
      'img_one_url':
          'https://64.media.tumblr.com/5d9e0997337264f1f0d99a6c30dc41dc/b14f71f1c6109186-a6/s540x810/c5ff288763620cb4331dcdcca9e5059309ef4e43.png',
      'img_two_url':
          'https://64.media.tumblr.com/a18c8063bf9d095d99f12b51d3dd1eda/57803298a6ae7123-0a/s540x810/35b1580573afd7e8d52a33546e021c3df27778b3.gif',
      'tag_name': 'Test tag',
      'tag_url': 'https://www.tumblr.com',
      'followed': 'false',
    },
    {
      'img_one_url':
          'https://64.media.tumblr.com/fd654c32f041cb02c757b5646c1cf9e1/a4c5782524284f82-d5/s540x810/dc9b214a0dd3612a3e1154c725ec175ad9921fe9.jpg',
      'img_two_url':
          'https://64.media.tumblr.com/439b77661f74cea5af5559a392dfe505/573d1660335efd03-4e/s540x810/46e78fb5a9f5e7d91352cf6c1ef016977aada3dc.jpg',
      'tag_name': 'Test tag',
      'tag_url': 'https://www.tumblr.com',
      'followed': 'false',
    },
  ];

  final checkOutTheseBlogsMockData = [
    {
      'blog_name': 'AAAAA',
      'blog_img_url':
          'https://64.media.tumblr.com/7c639466082be78cf3fc2f36c91c4d6e/c3101cc497330567-18/s128x128u_c1/1ccf730b27f200ada0f180c9831c85edaa9b1b98.jpg',
      'blog_bg_url':
          'https://64.media.tumblr.com/910534a51d1a0aaac19118a4070b15c9/c3101cc497330567-c3/s2048x3072/ad5469f6d5f1d88447c2872fafd19ad3906b0bdb.jpg',
      'blog_url': 'youtube.com',
    },
    {
      'blog_name': 'KAK',
      'blog_img_url':
          'https://64.media.tumblr.com/3ac39cb04388f6cbd92c62340f10763d/507eb9043a64a789-8a/s96x96u_c1/f8f4dc4fe57c63836a00360ac5c4171bc09b71af.pnj',
      'blog_bg_url':
          'https://64.media.tumblr.com/31d08c312828053eda871ef6ce6158cb/507eb9043a64a789-8d/s2048x3072_c7800,48200,67600,81867/999fb2a528e600514669ca6ec402cb125b6935f4.jpg',
      'blog_url': 'youtube.com',
    },
    {
      'blog_name': 'Storm',
      'blog_img_url':
          'https://64.media.tumblr.com/a48f0eda406e341451619fe9f04c33f8/d3bf61f3bf912169-dc/s96x96u_c1/27ec1dd59dfac2ff7a040e734e2c240a433ce83f.jpg',
      'blog_bg_url':
          'https://64.media.tumblr.com/83f27684eeb6831a76f8a8c1e6d5d9f4/d3bf61f3bf912169-ed/s2048x3072_c6780,8114,93179,91815/6cf1fdb16c5b5409a1b2f402e1db7edf80968140.jpg',
      'blog_url': 'youtube.com',
    },
    {
      'blog_name': 'Bruh why is my name so long',
      'blog_img_url':
          'https://64.media.tumblr.com/07b377bffb90d3226d18be619383dfa5/fdced055d48f80f2-3a/s96x96u_c1/1df25d1bfd780ccef2686dd793a6e6f5722236c0.jpg',
      'blog_bg_url':
          'https://64.media.tumblr.com/8ed48312e7af1551b5750278439cbd3d/fdced055d48f80f2-ed/s2048x3072_c0,7692,100000,88064/46ed7e90fcea44eaae57e3e550e31791f262fd5e.jpg',
      'blog_url': 'youtube.com',
    },
  ];

  final tryThesePostsMockData = [
    'https://64.media.tumblr.com/7a9525e72f6cbcb7075588984f3389ae/b9bba28b99b572fc-29/s400x600/ddccd44807f1491258124b8acf4748b62632fdd7.jpg',
    'https://64.media.tumblr.com/234c2c6770d789e37b8eeaa797a8f60d/3271277c18d42cad-0e/s400x600/145f521c44bdb261fda331f004fb8f6c2e34520f.png',
    'https://64.media.tumblr.com/4daa6e52e4dc2b63cc0c3b540f957641/ab1aace2e41fb5ac-90/s400x600/dde36aaf01e8aa94e21a867eb3bc56170f69b74e.jpg',
    'https://64.media.tumblr.com/3e3f88a2e60e0bd79356e9e43b851103/db19d029dc0afce8-68/s250x250_c1/d3eb64499af22377b6154f45f5c6a1f60a2de05d.gifv',
    'https://64.media.tumblr.com/65212a35471940e78b6fb6f5d1d8fb03/1c40f364748bca0c-46/s400x600/63c58f39b7de3d35106befd601aed4fb56352eed.png',
    'https://64.media.tumblr.com/1ee268f86e5e7b896526c5bb2630e22f/d45ecdd0931c6bbe-1c/s400x600/b9c2b59abb9df9a535c27dcce9a31e0dd575cc90.jpg',
    'https://64.media.tumblr.com/194e199bff1b21ca401eabd12d974d8a/cbda3ca550417d25-c4/s400x600/017b70610453f07003c0b5be7e5096087072e8e8.jpg',
    'https://64.media.tumblr.com/1e8434b79a91d952441723e2a79199f1/4ba5b7fbe0ab7855-56/s400x600/1be0bb6b2b18cee3e5ed2e955d3797897cb34b81.gifv',
    'https://64.media.tumblr.com/c4cc9af07e29af7310cf0e152cfa88f8/21614c182a3165eb-64/s400x600/b2ec067085ff125fa6faffc4ab8dc169a2a17acf.gifv',
  ];

  final thingsWeCareAboutMockData = [
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

  void goToTryThesePosts() {
    Get.to(TryThesePosts());
  }
}
