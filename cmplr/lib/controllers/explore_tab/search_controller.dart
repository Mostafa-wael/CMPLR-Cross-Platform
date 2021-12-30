import '../../views/views.dart';
import '../../utilities/custom_widgets/check_out_these_tags_element.dart';
import '../../utilities/custom_widgets/top_blogs_element.dart';
import '../../utilities/sizing/sizing.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../flags.dart';
import '../../models/models.dart';

class SearchController extends GetxController {
  // data model for search preferences
  SearchModel searchModel = SearchModel();

  // controller for the search text field
  final _searchBarController = TextEditingController();

  // list of the recommended search topics
  List recommendedQueries = [];

  RxBool showClearSearchBarIcon = false.obs;

  // getters for class attributes
  TextEditingController get searchBarController => _searchBarController;

  @override
  void onInit() {
    super.onInit();
  }

  /// This reads the search query then it display the results in the list view,
  /// this method is called whenever the search query is changed
  void searchQueryChanged() {
    if (_searchBarController.text == '') {
      showClearSearchBarIcon.value = false;
    } else {
      showClearSearchBarIcon.value = true;
    }
  }

  void search(String searchQuery) {
    // go to the search results here
    Get.to(const SearchResultsView());
  }

  void closeSearchPage() {
    Get.back();
  }

  bool _isFollowed = false;
  bool get isFollowed => _isFollowed;
  // Make this begin with new

  // TODO: Fix this
  Future<void> returnToSearch() async {
    // TODO: This might be changed when search screen is implemented
    Get.off(const SearchBar());
    update();
  }

  Future<void> toggleFollow() async {
    // TODO: send request in the backend
    if (_isFollowed) {
      _isFollowed = false;
    } else {
      _showToast('''Great! We'll show you the best new things about
           ${_searchBarController.text} from time to time''');
      _isFollowed = true;
    }
    update();
  }

  List<Widget> getExploreMoreTags() {
    if (Flags.mock) {
      const widthPercentage = 30, heightPercentage = 10, borderRadiusFactor = 1;
      final checkOutTheseTagsList = <Widget>[];

      var colorIndex = 0;
      for (final Map cott in checkOutTheseTagsMockData) {
        checkOutTheseTagsList.add(CheckOutTheseTagsElement(
            width: Sizing.blockSize * widthPercentage,
            height: Sizing.blockSizeVertical * 20,
            borderRadius: Sizing.blockSize * borderRadiusFactor,
            imgOneURL: cott['img_one_url'],
            imgTwoURL: cott['img_two_url'],
            tagName: cott['tag_name'],
            widgetColor: clrs[(colorIndex++ % clrs.length)]));
      }
      return checkOutTheseTagsList;
    } else
      return [];
  }

  List<Widget> getTopBlogs(width, height, topBlog) {
    if (Flags.mock) {
      const borderRadiusFactor = 1;
      final topBlogs = <Widget>[];

      for (final Map tb in topBlogsData) {
        topBlogs.add(TopBlogsElement(
          width: width,
          height: height,
          top: topBlog,
          borderRadius: Sizing.blockSize * borderRadiusFactor,
          coverImgURL: tb['cover_img_url'],
          blogPicURL: tb['blog_pic_url'],
          blogPicType: tb['blog_pic_type'],
          blogTitle: tb['blog_title'],
          blogName: tb['blog_name'],
          buttonColor: tb['button_color'],
          textColor: tb['text_color'],
          blogText: tb['blog_text'],
          blogURL: tb['blog_url'],
          followed: tb['followed'],
          imgOneURL: tb['blog_img_1'],
          imgTwoURL: tb['blog_img_2'],
          imgThreeURL: tb['blog_img_3'],
        ));
      }
      return topBlogs;
    } else
      return [];
  }

  final checkOutTheseTagsMockData = [
    {
      'img_one_url':
          'https://64.media.tumblr.com/c3165ebd9c1fbbfcb9ee2282debae9de/b14f71f1c6109186-93/s540x810/b8d7676377233009b10428fc9546487fc0c14126.jpg',
      'img_two_url':
          'https://64.media.tumblr.com/7ad94a0f1f2e1c0c9cb00d6fed72edf9/b14f71f1c6109186-83/s540x810/3de33fae7a449390f856d243236d8c910ecd402b.png',
      'tag_name': 'Test tag',
      'tag_url': 'https://www.tumblr.com',
      'followed': 'true'
    },
    {
      'img_one_url':
          'https://64.media.tumblr.com/2e2813ef0edfe7c0a9c8478b4b25ece5/b14f71f1c6109186-aa/s540x810/7ca399aa9a3e3b78d49a512bb338d12ff93009c3.jpg',
      'img_two_url':
          'https://64.media.tumblr.com/9410f22a29285fbdc65d884bc5054d56/b14f71f1c6109186-5e/s540x810/56c69ed615e2cb5afebdfa1cce95aacd0ed0d1ae.jpg',
      'tag_name': 'Test tag',
      'tag_url': 'https://www.tumblr.com',
      'followed': 'false'
    },
    {
      'img_one_url':
          'https://64.media.tumblr.com/5d9e0997337264f1f0d99a6c30dc41dc/b14f71f1c6109186-a6/s540x810/c5ff288763620cb4331dcdcca9e5059309ef4e43.png',
      'img_two_url':
          'https://64.media.tumblr.com/a18c8063bf9d095d99f12b51d3dd1eda/57803298a6ae7123-0a/s540x810/35b1580573afd7e8d52a33546e021c3df27778b3.gif',
      'tag_name': 'Test tag',
      'tag_url': 'https://www.tumblr.com',
      'followed': 'false'
    },
    {
      'img_one_url':
          'https://64.media.tumblr.com/fd654c32f041cb02c757b5646c1cf9e1/a4c5782524284f82-d5/s540x810/dc9b214a0dd3612a3e1154c725ec175ad9921fe9.jpg',
      'img_two_url':
          'https://64.media.tumblr.com/439b77661f74cea5af5559a392dfe505/573d1660335efd03-4e/s540x810/46e78fb5a9f5e7d91352cf6c1ef016977aada3dc.jpg',
      'tag_name': 'Test tag',
      'tag_url': 'https://www.tumblr.com',
      'followed': 'false'
    },
  ];

  final topBlogsData = [
    {
      'cover_img_url':
          'https://64.media.tumblr.com/2d97eb18fe957c9e9c0fd6dce6dea069/cffbbac4fb46a508-8f/s2048x3072_c0,9150,100000,79600/d3dc6195be9a63013b642c5a531a973ce310f453.jpg',
      'blog_pic_url':
          'https://64.media.tumblr.com/6d4e66fa68c8f1c487aa87c6c1b01c24/cffbbac4fb46a508-5f/s64x64u_c1/cfa7a52128f232c59922450875b73a8f4c0765e6.pnj',
      'blog_pic_type': 'circle',
      'blog_title': 'FY! EVERGLOW',
      'blog_name': 'fy-everglow',
      'button_color': 'blue',
      'text_color': 'grey',
      'blog_text':
          'blog deticated to EVERGLOW\'s members, sihyeon, E:U, Mia, Onda, Ais',
      'blog_url': 'https://www.tumblr.com',
      'followed': 'false',
      'blog_img_1':
          'https://64.media.tumblr.com/b97098ee3b325051e7b498766f82effe/4bd2bfc232884849-03/s100x200/f362539102db91d8bcc4a0aa04f105886af01095.jpg',
      'blog_img_2':
          'https://64.media.tumblr.com/712520609ec0bf2f4a3d670acbaf8036/769fd8104277eed2-0b/s100x200/b4c4c6534d54d12c2502b90855dd8e771f08bc59.jpg',
      'blog_img_3':
          'https://64.media.tumblr.com/d7360e028fb99a1dc98fe26d6acfa37c/364eab1c3782d088-74/s100x200/870e0592d0458b93f6ada13a9e2242da221629a2.jpg',
    },
    {
      'cover_img_url':
          'https://64.media.tumblr.com/03b0e3033d0c74a8850db9944ca71a19/19d2ca084ac9b502-d4/s2048x3072_c0,0,100000,75750/9ae588787b2455b5c7d39a8549388062600054df.gif',
      'blog_pic_url':
          'https://64.media.tumblr.com/e6440dc8eeb0757f7c9c5e05b1af3dae/19d2ca084ac9b502-10/s64x64u_c1/3f5d176dd98f1dbec42222b057a71bc9c2f9d6c4.jpg',
      'blog_pic_type': 'square',
      'blog_title': 'especially for you',
      'blog_name': 'glowing-eu',
      'button_color': 'black',
      'text_color': 'grey',
      'blog_text': 'nomi, 93 liner, forever everglow sideblog',
      'blog_url': 'https://www.tumblr.com',
      'followed': 'false',
      'blog_img_1':
          'https://64.media.tumblr.com/6f51bb1b184954944d2ac12116c45a1c/04e4f970ca019da6-2e/s100x200/0789b657bf272bee3ce9d1fd653c8f397437bc58.gifv',
      'blog_img_2':
          'https://64.media.tumblr.com/925ffeac42778e1fe3c5fd6864bcb927/1aa1c2583d6c3ca2-76/s100x200/c19094a5311b02e306b70fea5f2bccfdc56cad52.gifv',
      'blog_img_3':
          'https://64.media.tumblr.com/4e5321ba24ac2f4114297de055583131/afc3ed6b4b9b4493-33/s100x200/633f49412f8c2ffcbea79608fb4a49dfae6d9faf.gifv',
    },
    {
      'cover_img_url':
          'https://assets.tumblr.com/images/default_header/optica_pattern_11_focused_v3.png?_v=4275fa0865b78225d79970023dde05a1',
      'blog_pic_url':
          'https://64.media.tumblr.com/95091c7e1c9da57090eed353f97e8115/db2cbe2f408b70c3-eb/s64x64u_c1/7afd419fc07551d65a6246dd99310d86916cf623.jpg',
      'blog_pic_type': 'circle',
      'blog_title': '⭑ candyyglow',
      'blog_name': 'candyglow',
      'button_color': 'brown',
      'text_color': 'brown',
      'blog_text': '𝗈𝗇𝗅𝗒 𝖾𝗏𝖾𝗋𝗀𝗅𝗈𝗐 !! pt - br',
      'blog_url': 'https://www.tumblr.com',
      'followed': 'true',
      'blog_img_1':
          'https://64.media.tumblr.com/81fc6fa6517fe91eb20f790b65909cff/d325d92d7f4e6896-9d/s100x200/b199d8f3235d68580a46a2c4e236b695f0be86fa.jpg',
      'blog_img_2':
          'https://64.media.tumblr.com/e4156492d8367494c3c5180dd6a2abf2/938f03a31ff743f3-a4/s100x200/4acc46049f36f66757d457a8f922212b61620cc9.jpg',
      'blog_img_3':
          'https://64.media.tumblr.com/11a35813a315f681fa0e7c97ba118914/962b55aa36bf7003-55/s100x200/e12b6cc4b74e7a1130a075bc5d7a65970c94e351.jpg',
    },
  ];

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
}

void _showToast(String message) => Fluttertoast.showToast(
      msg: message,
      fontSize: 16,
      gravity: ToastGravity.BOTTOM,
      textColor: Colors.white,
      backgroundColor: const Color(0xFF4E4F53),
      timeInSecForIosWeb: 1,
    );
