import 'dart:math';
import 'package:html/parser.dart' as parser;

import '../../models/pages_model/explore_tab/explore_model.dart';
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
  final checkOutTheseTagsHeight = Sizing.blockSizeVertical * 21;
  final checkOutTheseBlogsHeight = Sizing.blockSizeVertical * 20;
  final blogImgRadius = Sizing.blockSize * 5;
  final blogNameCenterHeightFactor = 0.6;

  var tagsYouFollow = <Widget>[];
  var checkOutTheseTags = <Widget>[];
  var checkOutTheseBlogs = <Widget>[];
  Widget tryThesePosts = Container();
  var thingsWeCareAbout = <Widget>[];

  void initLists() async {
    getTagsYouFollow();
    getCheckOutTheseBlogs();
    checkOutTheseTags = await getCheckOutTheseTags('cott');
    thingsWeCareAbout = await getCheckOutTheseTags('twca');

    getTryThesePostsGrid();
  }

  ExploreController() {
    initLists();
  }

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
    // Each tag should have the keys: tag_id, tag_name, tag_slug posts_views
    //                                int,    string,   string,  string arr
    final tagsYouFollow = await ExploreModel.getTagsYouFollow();
    final tyfWidgets = <Widget>[];
    for (var i = 0; i < tagsYouFollow.length; i++) {
      final tag = tagsYouFollow[i];
      final otherData = Map.from(tag);
      // final List postViews = tag['posts_views'];
      // final testId = tag.containsKey('test_id') ? tag['test_id'] : -1;

      tyfWidgets.add(TextOnImage(
        otherData: otherData,
        gestureDetectorKey: ValueKey('TagsYouFollow${i}'),
        width: Sizing.blockSize * elementWidthPercentage,
        height: tagsYouFollowHeight,
        backgroundURL: placeHolderImgUrl,
        text: tag['name'],
        borderRadius: BorderRadius.circular(Sizing.blockSize),
        onTap: () {
          Get.to(const HashtagPosts(), arguments: tag['name']);
        },
      ));
    }
    this.tagsYouFollow = tyfWidgets;
    update();
  }

  Future<List<Widget>> getCheckOutTheseTags(String type) async {
    const widthPercentage = 30, borderRadiusFactor = 1;
    final checkOutTheseTags = await ExploreModel.getCheckOutTheseTags();
    final cottWidgets = <Widget>[];

    if (type == 'cott') {
      var colorIndex = 0;
      for (final cott in checkOutTheseTags) {
        final otherData = Map.from(cott);
        final List postViews = cott['posts_views'];
        final testId = cott.containsKey('test_id')
            ? cott['test_id']
            : Random().nextInt(16);
        var imgOneUrl, imgTwoUrl;

        if (postViews.length > 0) {
          imgOneUrl = postViews[Random().nextInt(postViews.length)];
          imgTwoUrl = postViews[Random().nextInt(postViews.length)];
        } else {
          imgOneUrl = placeHolderImgUrl;
          imgTwoUrl = placeHolderImgUrl;
        }

        cottWidgets.add(CheckOutTheseTagsElement(
            otherData: otherData,
            gestureDetectorKey: ValueKey('CheckOutTheseTags${testId}'),
            width: Sizing.blockSize * widthPercentage,
            height: checkOutTheseTagsHeight,
            borderRadius: Sizing.blockSize * borderRadiusFactor,
            imgOneURL: imgOneUrl,
            imgTwoURL: imgTwoUrl,
            tagName: cott['tag_name'],
            followed: false,
            widgetColor: clrs[(colorIndex++ % clrs.length)]));
      }
    } else if (type == 'twca') {
      for (var i = 0; i < checkOutTheseTags.length; i++) {
        final twca = checkOutTheseTags[i];
        cottWidgets.add(
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
    }
    return cottWidgets;
  }

  void getCheckOutTheseBlogs() async {
    final checkOutTheseBlogs = await ExploreModel.getCheckOutTheseBlogs();
    final cotbWidgets = <Widget>[];
    var colorIndex = 0;

    for (final cotb in checkOutTheseBlogs) {
      final testId =
          cotb.containsKey('test_id') ? cotb['test_id'] : Random().nextInt(16);

      cotbWidgets.add(CheckOutTheseBlogsElement(
        otherData: Map.from(cotb),
        gestureDetectorKey: ValueKey('CheckOutTheseBlogs$testId'),
        width: Sizing.blockSize * 30,
        height: checkOutTheseBlogsHeight,
        borderRadius: Sizing.blockSize * 2,
        blogName: cotb['blog_name'],
        blogImgURL: cotb['avatar'],
        blogBgURL: cotb['header_image'],
        blogImgRadius: blogImgRadius,
        blogImgCenterHeightFactor: blogNameCenterHeightFactor,
        // FIXME: Figure out how the backend returns background_color and
        // convert it to flutter colors
        widgetColor: clrs.reversed.toList()[colorIndex++ % clrs.length],
      ));
    }
    this.checkOutTheseBlogs = cotbWidgets;
    update();
  }

  List<Widget> getTrending() {
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

  void getTryThesePostsGrid() async {
    final tryThesePosts = await ExploreModel.getTryThesePosts();
    final ttpWidgets = <Widget>[];

    //
    for (var i = 0; i < min(9, tryThesePosts.length); i++) {
      final ttp = tryThesePosts[i];
      final content = ttp['post']['content'];
      final document = parser.parse(content);

      final imageElements = document.getElementsByTagName('img');

      /* 
         ttpWidgets.add(
          FadeInImage.assetNetwork(
            placeholder:
                placeHolders[math.Random().nextInt(placeHolders.length)],
            image: ttp,
            fit: BoxFit.cover,
          ),
        );*/

      if (imageElements.length > 0) {
        final img = imageElements[0].attributes['src'];

        ttpWidgets.add(
          TextOnImage(
            width: Sizing.blockSize * elementWidthPercentage,
            height: tagsYouFollowHeight,
            backgroundURL: img,
            dimImage: false,
            borderRadius: BorderRadius.circular(Sizing.blockSize),
          ),
        );
      } else {
        final withoutHtmlTags =
            parser.parse(document.body?.text).documentElement?.text;
        ttpWidgets.add(
          TextOnImage(
            width: Sizing.blockSize * elementWidthPercentage,
            height: tagsYouFollowHeight,
            maxTextRows: 3,
            text: withoutHtmlTags,
            borderRadius: BorderRadius.circular(Sizing.blockSize),
          ),
        );
      }
    }
    this.tryThesePosts = GestureDetector(
      key: const ValueKey('TryThesePostsGrid'),
      child: GridView.count(
        padding: EdgeInsets.zero,
        primary: false,
        shrinkWrap: true,
        crossAxisCount: 3,
        semanticChildCount: 9,
        children: ttpWidgets,
      ),
      onTap: goToTryThesePosts,
    );
    update();
  }

  // List<Widget> getThingsWeCareAbout() {
  //   // if (Flags.mock) {
  //   //   final twcaList = <Widget>[];
  //   //   for (var i = 0; i < thingsWeCareAboutMockData.length; i++) {
  //   //     final twca = thingsWeCareAboutMockData[i];
  //   //     twcaList.add(
  //   //       TextOnImage(
  //   //         gestureDetectorKey: ValueKey('ThingsWeCareAbout$i'),
  //   //         backgroundURL: twca['background_url'],
  //   //         text: twca['tag_name'],
  //   //         width: Sizing.blockSize * 30,
  //   //         height: tagsYouFollowHeight,
  //   //         borderRadius: BorderRadius.circular(Sizing.blockSize),
  //   //         onTap: () {
  //   //           Get.to(const HashtagPosts(), arguments: twca['tag_name']);
  //   //         },
  //   //       ),
  //   //     );
  //   //   }
  //   //   return twcaList;
  //   // } else
  //   //   // TODO: API Integration
  //   //   return [];
  //   // return [];
  // }

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

  void goToTryThesePosts() {
    Get.to(TryThesePosts());
  }
}
