import '../../views/views.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../models/models.dart';
import 'package:share_plus/share_plus.dart';

class ProfileController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final _model =
      ModelProfile(blogId: GetStorage().read('user')['primary_blog_id']);

  final _searchModel = ProfileSearchModel();

  final titleController = TextEditingController();
  final descCrontroller = TextEditingController();

  var blogInfo,
      _blogName,
      _blogTitle,
      _blogAvatar,
      _blogAvatarShape,
      _description,
      _backgroundColor,
      _headerImage,
      _url;
  var _currentColor;

  static const clrs = {
    'white': Colors.white,
    'black': Colors.black,
    'green': Colors.green,
    'blue': Colors.blue,
    'red': Colors.red,
    'yellow': Colors.yellow,
    'grey': Colors.grey,
    'brown': Colors.brown,
    'pink': Colors.pink,
    'teal': Colors.teal,
    'cyan': Colors.cyan,
    'orange': Colors.orange,
    'amber': Colors.amber,
    'purple': Colors.purple,
    'indigo': Colors.indigo,
  };

  dynamic get blogName => _blogName;
  dynamic get blogTitle => _blogTitle;
  dynamic get blogAvatar => _blogAvatar;
  dynamic get blogAvatarShape => _blogAvatarShape;
  dynamic get headerImage => _headerImage;
  dynamic get description => _description;
  dynamic get backgroundColor => _backgroundColor;
  dynamic get url => _url;
  dynamic get currentColor => _currentColor;

  var allowSubmissions = false;
  var ask = false;
  var useMedia = false;
  var topPosts = false;
  var optimizeVideo = false;
  var showUploadProg = false;
  var disableDoubleTapToLike = false;
  var systemDefault, trueBlue, darkMode;

  List<Blog>? followingBlogs;

  Future<void> goToSettings() async {
    Get.to(const ProfileSettingsView());
    update();
  }

  final List popupMenuChoices = [
    'Share',
    'Get notifications',
    'Block',
    'Report',
    'Unfollow'
  ];

  Future<void> getBlogInfo() async {
    blogInfo = await _model.getBlogInfo();
    _blogTitle = blogInfo['title'];
    _blogName = blogInfo['blog_name'];
    _blogAvatar = blogInfo['avatar'];
    _blogAvatarShape = blogInfo['avatar_shape'];
    _headerImage = blogInfo['header_image'];
    _description = blogInfo['description'] ?? '';
    _backgroundColor = clrs[blogInfo['background_color']];
    _url = blogInfo['url'];
  }

  Future<void> share(BuildContext context) async {
    await Share.share(_url);
    update();
  }

  Future<void> shareFollowing(BuildContext context, String blogURL) async {
    await Share.share(blogURL);
    update();
  }

  Future<void> goBack() async {
    Get.back();
    update();
  }

  Future<void> goToEdit() async {
    _currentColor = backgroundColor;
    titleController.text = blogTitle;
    descCrontroller.text = description;
    Get.to(const EditProfileView());
    update();
  }

  // TODO: Integrate whatever of these the back implements
  Future<void> toggleSubmissions() async {
    allowSubmissions = !allowSubmissions;
    update();
  }

  Future<void> toggleUseMedia() async {
    useMedia = !useMedia;
    update();
  }

  Future<void> toggleAsk() async {
    ask = !ask;
    update();
  }

  Future<void> toggleShowTopPosts() async {
    topPosts = !topPosts;
    update();
  }

  Future<void> toggleDisableDoubleTapToLike() async {
    disableDoubleTapToLike = !disableDoubleTapToLike;
    update();
  }

  Future<void> toggleOptimizeVids() async {
    optimizeVideo = !optimizeVideo;
    update();
  }

  Future<void> toggleShowUploadProg() async {
    showUploadProg = !showUploadProg;
    update();
  }

  Future<void> goToAccountSettings() async {
    Get.to(const AccountSettingsView());
    update();
  }

  Future<void> changeColor(String key) async {
    _currentColor = clrs[key];
    update();
  }

  Future<void> saveEdits() async {
    // TODO: send request to back with changes if they implement it
    Get.back();
    update();
  }

  Future<void> getFollowingBlogs() async {
    followingBlogs = await _searchModel.getFollowingBlogs();
  }

  // Future<void> setSystemDefaults() async {
  //   systemDefault = true;
  //   trueBlue = false;
  //   darkMode = false;
  //   update();
  // }
}
