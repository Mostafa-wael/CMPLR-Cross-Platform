import 'dart:convert';

import '../../backend_uris.dart';
import '../../models/cmplr_service.dart';

import '../../models/pages_model/blog/blog_info_model.dart';
import 'package:get/get.dart';

/// [BlogController] class is inherited from [GetxController]
/// The class is used to handle and conrol the logic of Visitor Blog,
/// and to handle the state
/// Class has the following data member:
/// [scrolledDown] :boolean which handles the state of scrolling down,
/// in order to change the appBar theme, and the profile picture theme
/// [blogInfo] : BlogInfo Object which handles the data of the blog
/// like title, avatar, posts, name, ...etc.
/// [isBlogInfoLoading] : boolean to check whether the data is fetched or not
/// To handle the state, and avoid null
/// Also the Class has [fetchBlogInfo] : async Future Function void
/// This Function retrives the data from the API depending on the BlogIdentifier
/// like BlogName
/// The function takes as an arguemtn: [blogName]
/// and changes the state: [isBlogInfoLoading], [blogInfo]
/// Example
/// ```dart
/// final blogController = Get.put(BlogController()); // This for first use
/// final blogController = Get.find(BlogController()); // for other uses
/// ```

class BlogController extends GetxController {
  // To Change the Color Depending on Scrolling
  RxBool scrolledDown = false.obs;
  Rx<BlogInfo>? blogInfo;
  RxBool isBlogInfoLoading = true.obs;

  /// ToDo: Change this into Navigation instead of inside InitState

  @override
  void onInit() {
    super.onInit();
  }

  /// [fetchBlogInfo]: Future void async function
  /// parameters: [blogName]: String -> the name of the blog
  /// This Function is used to get the blogInfo from the API
  /// given the [BlogName] as a BlogIdentifier
  /// Example:
  /// ```dart
  /// TextButton(
  /// child: Text('update'),
  /// onClicked: ()async{
  ///   await blogController.fetchBlogInfo('FlutterBlog');
  /// }
  /// );
  /// ```
  Future fetchBlogInfo(String blogName) async {
    try {
      isBlogInfoLoading(true);
      /*
      Future.delayed(const Duration(milliseconds: 500), () {
        final mockData = <String, dynamic>{
          'title': 'John Doe',
          'avatar': 'https://www.example.com/image/avatar.png',
          'posts': 69,
          'name': 'john-doe',
          'url': 'https://www.cmplr.com/blogs/john-doe',
          'updated': 1308953007,
          'description':
              r'<p><strong>Mr. Karp</strong> is tall and skinny, with unflinching blue eyes a mop of brown hair.\\r\\nHe speaks incredibly fast and in complete paragraphs.</p>',
          'ask': false,
          'ask_anon': false,
          'likes': 420,
          'is_blocked_from_primary': false,
          'theme': {
            'avatar_shape': 'circle',
            'background_color': '#00f980',
            'body_font': 'Arial',
            'header_image': 'https://www.example.com/image/header.png',
            'link_color': '#eefeef',
            'show_avatar': false,
            'show_description': false,
            'show_header_image': false,
            'show_title': false,
            'title_color': '#f0f0f0',
            'title_font': 'Arial',
            'title_font_weight': 'bold'
          }
        };

        blogInfo = BlogInfo.fromJson(mockData).obs;
      });
      */

      final response =
          await CMPLRService.getBlogInfo(GetURIs.getBlogInfo(blogName), {});

      blogInfo = BlogInfo.fromJson(json.decode(response.body)).obs;
    } finally {
      isBlogInfoLoading(false);
    }
  }
}

/*

  Future<List<PostItem>> getNewPosts() async {
    final posts = <PostItem>[];

    final response = await CMPLRService.get(GetURIs.postFollow, {});
    final responseBody = jsonDecode(response.body);
    print('model');
    print(responseBody['total_posts']);
    for (var i = 0; i < responseBody['total_posts']; i++) {
      posts.add(PostItem.fromJson(responseBody['posts'][i]));
    }
    print(posts.length);
    return posts;
  }
*/