import 'dart:convert';
import 'dart:io';
import '../home_tab/explore_controller.dart';
import '../controllers.dart';
import '../../cmplr_theme.dart';
import '../../views/profile_tab/change_name_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../models/cmplr_service.dart';
import '../../utilities/user.dart';
import '../../views/views.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../models/models.dart';
import 'package:share_plus/share_plus.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController
    with GetSingleTickerProviderStateMixin {
  /// The model used to fetch the profile data
  final _model =
      ModelProfile(blogId: GetStorage().read('user')['primary_blog_id']);

  /// The model used to fetch the user following
  final searchModel = ProfileSearchModel();

  /// Used to monitor and control the title & its changes
  final titleController = TextEditingController();

  /// Used to monitor and control the description & its changes
  final descCrontroller = TextEditingController();

  /// Used to monitor and control the blog name & its changes
  final changeNameController = TextEditingController();

  /// Variables that hold the profile data that we get from the explorer
  var blogInfo,
      _blogName,
      _blogTitle,
      _blogAvatar,
      _blogAvatarShape,
      _description,
      _backgroundColor,
      _headerImage,
      _url;

  /// Getters for profile information
  dynamic get blogName => _blogName;
  dynamic get blogTitle => _blogTitle;
  dynamic get blogAvatar => _blogAvatar;
  dynamic get blogAvatarShape => _blogAvatarShape;
  dynamic get headerImage => _headerImage;
  dynamic get description => _description;
  dynamic get backgroundColor => _backgroundColor;
  dynamic get url => _url;
  dynamic get currentColor => _currentColor;

  /// Variable that holds the new background color to be updated
  var _currentColor;

  /// Variable that holds the new header image to be uploaded
  var _pickedHeader;

  /// Variable that holds the new avatar image to be uploaded
  var _pickedAvatar;

  /// Variable that tracks how many times the profile was refreshed
  var loaded = 0;

  /// Function that's used to increment the loaded variable
  void incLoaded() {
    loaded++;
  }

  /// Variable that holds the extension of the uploaded image
  var _extension;

  /// Variables that hold the new image urls that are obtained
  /// from the database after the images are uploaded to the server
  var _newHeaderUrl, _newAvatarUrl;

  /// Used to get images from the file explorer of the device
  final ImagePicker _picker = ImagePicker();

  /// Variables used for the settings view (toggles)
  var allowSubmissions = false;
  var ask = false;
  var useMedia = false;
  var topPosts = false;
  var optimizeVideo = false;
  var showUploadProg = false;
  var disableDoubleTapToLike = false;

  /// Variables that are used for settings for theme
  bool trueBlue = User.userMap['theme'] == 'trueBlue';
  bool darkMode = User.userMap['theme'] != 'trueBlue';

  /// A list of blogs that user follows
  List<Blog>? followingBlogs;

  /// The function that's used to get the profile information and sets
  /// the variables that hold that information
  Future<void> getBlogInfo() async {
    blogInfo = await _model.getBlogInfo();
    if (blogInfo != null) {
      _blogTitle = blogInfo['title'];
      _blogName = blogInfo['blog_name'];
      _blogAvatar = blogInfo['avatar'];
      _blogAvatarShape = blogInfo['avatar_shape'];
      _headerImage =
          blogInfo['header_image'] ?? 'https://via.placeholder.com/150';
      _description = blogInfo['description'] ?? '';
      _backgroundColor = clrs[blogInfo['background_color']];
      _url = blogInfo['url'];
    }
  }

  /// Function thats used to open the share view to allow
  /// sharing to other applications
  Future<void> share(BuildContext context) async {
    await Share.share(_url);
    update();
  }

  /// Function that goes to the settings view
  Future<void> goToSettings() async {
    Get.to(const ProfileSettingsView());
    update();
  }

  /// Function that's used to share the url of a blog that the user follows
  Future<void> shareFollowing(BuildContext context, String blogURL) async {
    await Share.share(blogURL);
    update();
  }

  /// Function that implements the pop functionality
  Future<void> goBack() async {
    Get.back();
    update();
  }

  /// Function that goes to the Edit view
  /// Sets the new background color to the current background color
  /// and it does same to the blog title and description
  /// this is so this information is displayed in the edit profile view
  /// and the user can then change it as they which
  Future<void> goToEdit() async {
    _currentColor = backgroundColor;
    titleController.text = blogTitle;
    descCrontroller.text = description;
    Get.to(const EditProfileView());
    update();
  }

  /// Function that toggles the allow submission setting
  Future<void> toggleSubmissions() async {
    allowSubmissions = !allowSubmissions;
    update();
  }

  /// Function that toggles the allow media use setting
  Future<void> toggleUseMedia() async {
    useMedia = !useMedia;
    update();
  }

  /// Function that toggles the allow ask setting
  Future<void> toggleAsk() async {
    ask = !ask;
    update();
  }

  /// Function that toggles the show top posts setting
  Future<void> toggleShowTopPosts() async {
    topPosts = !topPosts;
    update();
  }

  /// Function that toggles the double tap to like setting
  Future<void> toggleDisableDoubleTapToLike() async {
    disableDoubleTapToLike = !disableDoubleTapToLike;
    update();
  }

  /// Function that toggles the allow optimize videos setting
  Future<void> toggleOptimizeVids() async {
    optimizeVideo = !optimizeVideo;
    update();
  }

  /// Function that toggles the show upload progress setting
  Future<void> toggleShowUploadProg() async {
    showUploadProg = !showUploadProg;
    update();
  }

  /// Function that navigates to the account settings view
  Future<void> goToAccountSettings() async {
    Get.to(const AccountSettingsView());
    update();
  }

  /// Function that's used to change the background color localy
  /// (doesn't sent requests)
  Future<void> changeColor(String key) async {
    _currentColor = clrs[key];
    update();
  }

  /// Used to get the header image from the device file explorer and
  ///  convert it to base64 so that it can be sent to the database
  Future<void> pickHeader() async {
    _pickedHeader =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (_pickedHeader != null) {
      _extension = _pickedHeader.name.split('.')[1];
      _pickedHeader = File(_pickedHeader.path).readAsBytesSync();
      final temp = base64Encode(_pickedHeader);
      _pickedHeader = 'data:image/${_extension};base64,' + temp.toString();
    }
  }

  /// Used to get the avatar
  /// image from the device file explorer and convert it to
  /// base64 so that it can be sent to the database
  Future<void> pickAvatar() async {
    _pickedAvatar =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (_pickedAvatar != null) {
      _extension = _pickedAvatar.name.split('.')[1];
      _pickedAvatar = File(_pickedAvatar.path).readAsBytesSync();
      final temp = base64Encode(_pickedAvatar);
      _pickedAvatar = 'data:image/${_extension};base64,' + temp.toString();
    }
  }

  /// Used to upload the image to the server & returns a url
  /// that is then used to update the current header/avatar image url
  Future<dynamic> getImgUrl(bool header) async {
    final response;
    if (header)
      response = await _model.uploadImg(_pickedHeader);
    else
      response = await _model.uploadImg(_pickedAvatar);
    final Map responseMap = jsonDecode(utf8.decode(response.bodyBytes));
    if (responseMap.containsKey('error')) {
      _showToast('Failed to upload image, please try again');
    } else {
      if (response.statusCode != 400) if (header)
        _newHeaderUrl = responseMap['response']['url'];
      else
        _newAvatarUrl = responseMap['response']['url'];
      final response1 = await saveEdits(false);
    }
  }

  /// Used to update the current title, background color, descriptionm,
  /// header and avatar image urls and blog name
  Future<void> saveEdits(visibleKeyboard) async {
    final response = await _model.putBlogSettings(
      nameClrs[_currentColor ?? _backgroundColor],
      titleController.text == '' ? _blogTitle : titleController.text,
      descCrontroller.text == '' ? description : descCrontroller.text,
      _newHeaderUrl ?? _headerImage,
      _newAvatarUrl ?? _blogAvatar,
      changeNameController.text == '' ? _blogName : changeNameController.text,
    );

    await getBlogInfo();
    Get.back();
    if (visibleKeyboard) Get.back();
    update();
    _newHeaderUrl = _headerImage;
    _newAvatarUrl = _blogAvatar;
    _currentColor = _backgroundColor;
    titleController.text = _blogTitle;
    descCrontroller.text = _description;
    titleController.text = _blogName;
  }

  /// Navigates to change Username view
  Future<void> goToChangeName(visibleKeyboard) async {
    Get.to(const ChangeNameView());
    update();
  }

  /// Function that gets the blogs that the user follows from the server
  Future<void> getFollowingBlogs() async {
    followingBlogs = await searchModel.getFollowingBlogs();
  }

  /// Used to set the theme of the application to trueBlue
  /// Refreshes all the widgets by refreshing their controllers
  Future<void> setTrueBlue() async {
    final response = await _model.putTheme('trueBlue');
    if (response.statusCode == CMPLRService.requestSuccess) {
      Get.changeThemeMode(ThemeMode.light);
      Get.changeTheme(CMPLRTheme.trueBlue());
      User.userMap['theme'] = 'trueBlue';
      trueBlue = true;
      darkMode = false;

      rebuildViews();

      update();
    }
  }

  /// Used to set the theme of the application to darkMode
  /// Refreshes all the widgets by refreshing their controllers
  Future<void> setDarkMode() async {
    final response = await _model.putTheme('darkMode');
    if (response.statusCode == CMPLRService.requestSuccess) {
      User.userMap['theme'] = 'darkMode';
      Get.changeTheme(CMPLRTheme.darkTheme());
      trueBlue = false;
      darkMode = true;
      Get.changeThemeMode(ThemeMode.dark);

      rebuildViews();

      update();
    }
  }

  /// Updates all controllers holding a widget that uses the theme
  /// If your widget / page uses the global [Get.theme], please add it here.
  void rebuildViews() {
    try {
      Get.find<MasterPageController>().update();
      Get.find<PostFeedController>(tag: 'OtherBlogs').update();
      Get.find<PostFeedController>(tag: 'HomeFollowing').update();
      Get.find<PostFeedController>(tag: 'StuffForYou').update();
      Get.find<PostFeedController>(tag: 'EditProfilePost').update();
      Get.find<PostFeedController>(tag: 'EditProfileLike').update();
      Get.find<PostFeedController>(tag: 'ProfileViewPosts').update();
      Get.find<PostFeedController>(tag: 'ProfileViewLikesRecent').update();
      Get.find<PostFeedController>(tag: 'HashTagPostsRecent').update();
      Get.find<PostFeedController>(tag: 'HashTagPostsTop').update();
      Get.find<PostFeedController>(tag: 'SearchResults1').update();
      Get.find<PostFeedController>(tag: 'SearchResults2').update();
      Get.find<PostFeedController>(tag: 'SearchResults3').update();
      Get.find<PostFeedController>(tag: 'TryThesePosts').update();
      Get.find<ExploreController>().update();
    } catch (e) {
      e.printError();
    }
  }

  /// Navigates to the Color Palette Setting in the account settings view
  Future<void> goToColorPalette() async {
    Get.to(const ColorPaletteView());
    update();
  }

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

  static var nameClrs = {
    Colors.white: 'white',
    Colors.black: 'black',
    Colors.green: 'green',
    Colors.blue: 'blue',
    Colors.red: 'red',
    Colors.yellow: 'yellow',
    Colors.grey: 'grey',
    Colors.brown: 'brown',
    Colors.pink: 'pink',
    Colors.teal: 'teal',
    Colors.cyan: 'cyan',
    Colors.orange: 'orange',
    Colors.amber: 'amber',
    Colors.purple: 'purple',
    Colors.indigo: 'indigo',
  };

  final List popupMenuChoices = [
    'Share',
    'Get notifications',
    'Block',
    'Report',
    'Unfollow'
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
